package com.paulina.zebrapace

import android.content.ActivityNotFoundException
import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// FlutterFragmentActivity (not FlutterActivity): both the health package's
// Health Connect permission request and local_auth's biometric prompt need
// a ComponentActivity/FragmentActivity.
class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Android's counterpart to iOS's `app-settings:` URL: Health Connect
        // won't re-show its permission sheet once access is granted, so the
        // only way to change it later is Health Connect's own settings.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "zebrapace/health_settings")
            .setMethodCallHandler { call, result ->
                if (call.method == "open") {
                    result.success(openHealthConnectSettings())
                } else {
                    result.notImplemented()
                }
            }
    }

    // Android 14+ ships Health Connect inside the OS, which only answers the
    // framework actions; the androidx action is for the separate Health
    // Connect app on Android 13 and below. Tries this app's own permission
    // page first, then Health Connect's home, then the old action.
    private fun openHealthConnectSettings(): Boolean {
        val candidates = mutableListOf<Intent>()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            candidates += Intent("android.health.connect.action.MANAGE_HEALTH_PERMISSIONS")
                .putExtra(Intent.EXTRA_PACKAGE_NAME, packageName)
            candidates += Intent("android.health.connect.action.HEALTH_HOME_SETTINGS")
        }
        candidates += Intent("androidx.health.ACTION_HEALTH_CONNECT_SETTINGS")
        for (intent in candidates) {
            try {
                startActivity(intent)
                return true
            } catch (e: ActivityNotFoundException) {
                // try the next one
            } catch (e: SecurityException) {
                // try the next one
            }
        }
        return false
    }
}
