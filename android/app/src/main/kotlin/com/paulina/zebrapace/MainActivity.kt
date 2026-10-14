package com.paulina.zebrapace

import android.content.ActivityNotFoundException
import android.content.Intent
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
                    try {
                        startActivity(Intent("androidx.health.ACTION_HEALTH_CONNECT_SETTINGS"))
                        result.success(true)
                    } catch (e: ActivityNotFoundException) {
                        result.success(false)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }
}
