import Flutter
import HealthKit
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // HealthKit background delivery only wakes the app for observer queries
    // that are registered again on every launch, before anything else.
    PacingAlertMonitor.shared.startIfEnabled()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "PacingAlertMonitor") {
      let channel = FlutterMethodChannel(
        name: PacingAlertMonitor.channelName, binaryMessenger: registrar.messenger())
      channel.setMethodCallHandler { call, result in
        guard call.method == "configure" else {
          result(FlutterMethodNotImplemented)
          return
        }
        guard let args = call.arguments as? [String: Any], let json = args["snapshot"] as? String
        else {
          result(FlutterError(code: "bad_args", message: "snapshot missing", details: nil))
          return
        }
        PacingAlertMonitor.shared.configure(json: json)
        result(nil)
      }
    }
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "SharedContainer") {
      let channel = FlutterMethodChannel(
        name: SharedContainer.channelName, binaryMessenger: registrar.messenger())
      channel.setMethodCallHandler { call, result in
        switch call.method {
        case "publish":
          guard let args = call.arguments as? [String: Any], let json = args["json"] as? String
          else {
            result(FlutterError(code: "bad_args", message: "json missing", details: nil))
            return
          }
          do {
            try SharedContainer.writeOutbox(json)
            result(nil)
          } catch {
            result(FlutterError(code: "write_failed", message: "\(error)", details: nil))
          }
        case "clear":
          SharedContainer.clearOutbox()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
  }
}

/// iOS half of the ZebraPace ↔ ZebraUp shared container: the App Group
/// group.com.paulina.zebras (both apps' Runner targets have it; ZebraUp's
/// Crisis Control extension does not). ZebraPace writes its outbox to
/// `zebrapace/outbox.json` (contract: lib/domain/services/
/// shared_outbox_builder.dart); ZebraUp only reads that folder. Android
/// serves the same JSON from SharedDataProvider.kt.
enum SharedContainer {
  static let channelName = "zebrapace/shared_container"
  static let appGroup = "group.com.paulina.zebras"

  private static var outboxURL: URL? {
    FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)?
      .appendingPathComponent("zebrapace", isDirectory: true)
      .appendingPathComponent("outbox.json")
  }

  static func writeOutbox(_ json: String) throws {
    guard let url = outboxURL else {
      throw NSError(
        domain: "SharedContainer", code: 1,
        userInfo: [NSLocalizedDescriptionKey: "App Group \(appGroup) unavailable"])
    }
    try FileManager.default.createDirectory(
      at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
    // Readable after the first unlock since boot, so ZebraUp can read it
    // from the background too; atomic so a reader never sees half a file.
    try Data(json.utf8).write(to: url, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
  }

  static func clearOutbox() {
    guard let url = outboxURL else { return }
    try? FileManager.default.removeItem(at: url)
  }
}

/// Pacing alerts while ZebraPace is closed. The Dart side
/// (lib/data/notifications/pacing_alert_bridge.dart) owns every envelope
/// rule; it hands over today's thresholds plus already-localized text, and
/// this only compares HealthKit's step total against them. Android has the
/// same contract in PacingAlerts.kt.
///
/// HealthKit's store is encrypted while the phone is locked, so a wake-up
/// that lands then can't read steps; the next one after unlocking does.
final class PacingAlertMonitor {
  static let shared = PacingAlertMonitor()
  static let channelName = "zebrapace/pacing_alerts"

  private let store = HKHealthStore()
  private let defaults = UserDefaults.standard
  private let snapshotKey = "pacing_alert_snapshot"
  private let carryDays = 2
  private var observer: HKObserverQuery?
  private let queue = DispatchQueue(label: "zebrapace.pacing-alerts")

  private var stepType: HKQuantityType? { HKQuantityType.quantityType(forIdentifier: .stepCount) }

  func configure(json: String) {
    defaults.set(json, forKey: snapshotKey)
    if snapshot()?.enabled == true {
      startIfEnabled()
      evaluate {}
    } else {
      stop()
    }
  }

  func startIfEnabled() {
    guard HKHealthStore.isHealthDataAvailable(), let type = stepType,
      snapshot()?.enabled == true, observer == nil
    else { return }
    let query = HKObserverQuery(sampleType: type, predicate: nil) { [weak self] _, completion, error in
      guard error == nil, let self else {
        completion()
        return
      }
      self.evaluate { completion() }
    }
    observer = query
    store.execute(query)
    store.enableBackgroundDelivery(for: type, frequency: .hourly) { _, _ in }
  }

  private func stop() {
    if let query = observer { store.stop(query) }
    observer = nil
    if let type = stepType { store.disableBackgroundDelivery(for: type) { _, _ in } }
  }

  private func evaluate(done: @escaping () -> Void) {
    guard let snap = snapshot(), let thresholds = snap.thresholds(for: Date(), carryDays: carryDays),
      let type = stepType
    else {
      done()
      return
    }
    let now = Date()
    let predicate = HKQuery.predicateForSamples(
      withStart: Calendar.current.startOfDay(for: now), end: now, options: .strictStartDate)
    let query = HKStatisticsQuery(
      quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum
    ) { [weak self] _, stats, error in
      guard let self, error == nil else {
        done()
        return
      }
      let steps = Int(stats?.sumQuantity()?.doubleValue(for: .count()) ?? 0)
      self.queue.async {
        self.maybeNotify(snap: snap, thresholds: thresholds, steps: steps, done: done)
      }
    }
    store.execute(query)
  }

  /// At most one goal and one caution alert per day.
  private func maybeNotify(
    snap: Snapshot, thresholds: (goal: Int, caution: Int), steps: Int, done: @escaping () -> Void
  ) {
    let today = Snapshot.dayKey(Date())
    let cautionKey = "pacing_notified_\(today)_caution"
    let goalKey = "pacing_notified_\(today)_goal"
    let kind: String
    if steps > thresholds.caution && !defaults.bool(forKey: cautionKey) {
      kind = "caution"
    } else if steps >= thresholds.goal && !defaults.bool(forKey: goalKey)
      && !defaults.bool(forKey: cautionKey)
    {
      kind = "goal"
    } else {
      done()
      return
    }
    let content = UNMutableNotificationContent()
    content.title = kind == "caution" ? snap.cautionTitle : snap.goalTitle
    content.body = kind == "caution" ? snap.cautionBody : snap.goalBody
    content.sound = .default
    let request = UNNotificationRequest(
      identifier: "pacing_\(kind)", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request) { [weak self] error in
      guard let self else {
        done()
        return
      }
      if error == nil {
        self.defaults.set(true, forKey: kind == "caution" ? cautionKey : goalKey)
        // Passing the caution line also covers the goal.
        if kind == "caution" { self.defaults.set(true, forKey: goalKey) }
        for key in self.defaults.dictionaryRepresentation().keys
        where key.hasPrefix("pacing_notified_") && !key.hasPrefix("pacing_notified_\(today)_") {
          self.defaults.removeObject(forKey: key)
        }
      }
      done()
    }
  }

  private func snapshot() -> Snapshot? {
    guard let json = defaults.string(forKey: snapshotKey), let data = json.data(using: .utf8) else {
      return nil
    }
    return try? JSONDecoder().decode(Snapshot.self, from: data)
  }

  struct Snapshot: Decodable {
    let enabled: Bool
    let date: String
    let goalSteps: Int
    let cautionSteps: Int
    let baseGoalSteps: Int
    let baseCautionSteps: Int
    let skipToday: Bool
    let goalTitle: String
    let goalBody: String
    let cautionTitle: String
    let cautionBody: String

    /// The snapshot's own day uses its thresholds (readiness applied); for
    /// up to `carryDays` after, while the app hasn't been opened, the plain
    /// baseline envelope stands in. Readiness and Rest/Flare don't carry.
    func thresholds(for day: Date, carryDays: Int) -> (goal: Int, caution: Int)? {
      guard enabled, let snapDay = Snapshot.dayFormatter.date(from: date) else { return nil }
      let cal = Calendar.current
      let gap =
        cal.dateComponents([.day], from: cal.startOfDay(for: snapDay), to: cal.startOfDay(for: day))
        .day ?? -1
      let t: (goal: Int, caution: Int)?
      if gap == 0 {
        t = skipToday ? nil : (goalSteps, cautionSteps)
      } else if gap >= 1 && gap <= carryDays {
        t = (baseGoalSteps, baseCautionSteps)
      } else {
        t = nil
      }
      guard let t, t.goal > 0, t.caution > 0 else { return nil }
      return t
    }

    static let dayFormatter: DateFormatter = {
      let f = DateFormatter()
      f.calendar = Calendar(identifier: .gregorian)
      f.locale = Locale(identifier: "en_US_POSIX")
      f.timeZone = .current
      f.dateFormat = "yyyy-MM-dd"
      return f
    }()

    static func dayKey(_ date: Date) -> String { dayFormatter.string(from: date) }
  }
}
