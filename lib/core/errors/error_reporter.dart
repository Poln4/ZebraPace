import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Sends crashes and unexpected failures to the `app_errors` table
/// (supabase/migrations/008_app_errors.sql) so problems on real phones
/// aren't invisible. Deliberately anonymous: no user id, email or log
/// data — only the error text, stack trace, platform and app version.
///
/// Release builds only (debug prints instead), never throws, and capped
/// per launch so a loop that keeps failing can't flood the table.
class ErrorReporter {
  ErrorReporter._();

  static const _table = 'app_errors';
  static const _maxPerLaunch = 20;
  static const _maxErrorLength = 500;
  static const _maxStackLength = 4000;

  static final _seen = <String>{};
  static String? _appVersion;

  /// [where] names the call site (e.g. 'health.steps') for errors caught
  /// and handled rather than crashes.
  static void report(Object error, StackTrace? stack, {String? where}) {
    if (kDebugMode) {
      debugPrint('ErrorReporter${where == null ? '' : ' [$where]'}: $error');
      return;
    }
    final text = _truncate('$error', _maxErrorLength);
    final key = '$where|$text';
    if (_seen.length >= _maxPerLaunch || !_seen.add(key)) return;
    _send(text, stack, where);
  }

  static Future<void> _send(String error, StackTrace? stack, String? where) async {
    try {
      _appVersion ??= await PackageInfo.fromPlatform()
          .then((info) => '${info.version}+${info.buildNumber}');
      await Supabase.instance.client.from(_table).insert({
        'platform': kIsWeb ? 'web' : defaultTargetPlatform.name,
        'app_version': _appVersion,
        'location': where,
        'error': error,
        'stack': stack == null ? null : _truncate('$stack', _maxStackLength),
      });
    } catch (_) {
      // Offline or Supabase down: reporting must never cause a new error.
    }
  }

  static String _truncate(String s, int max) => s.length <= max ? s : s.substring(0, max);
}
