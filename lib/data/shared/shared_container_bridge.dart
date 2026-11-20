import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Publishes ZebraPace's outbox into the shared container ZebraUp reads:
/// the App Group on iOS (AppDelegate.swift → SharedContainer), the
/// SharedDataProvider on Android.
class SharedContainerBridge {
  static const _channel = MethodChannel('zebrapace/shared_container');

  String? _lastPublished;

  static bool get supported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  Future<void> publish(String json) async {
    if (!supported || json == _lastPublished) return;
    try {
      await _channel.invokeMethod<void>('publish', {'json': json});
      _lastPublished = json;
    } on MissingPluginException {
      // Tests.
    } on PlatformException catch (e) {
      debugPrint('SharedContainerBridge.publish failed: $e');
    }
  }

  /// Sharing turned off: nothing is left for ZebraUp to read.
  Future<void> clear() async {
    if (!supported) return;
    try {
      await _channel.invokeMethod<void>('clear');
      _lastPublished = null;
    } on MissingPluginException {
      // Tests.
    } on PlatformException catch (e) {
      debugPrint('SharedContainerBridge.clear failed: $e');
    }
  }
}
