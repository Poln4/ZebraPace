package com.paulina.zebrapace

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Bundle

/**
 * What Health Connect opens from "Read privacy policy" on ZebraPace's
 * permission screen. Hands off to the browser and gets out of the way;
 * no UI of its own (Theme.NoDisplay, so it must finish in onCreate).
 */
class PermissionsRationaleActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(PRIVACY_POLICY_URL)))
        } catch (_: ActivityNotFoundException) {
            // No browser; nothing more we can show.
        }
        finish()
    }

    private companion object {
        // web/privacy.html, deployed by netlify.toml.
        const val PRIVACY_POLICY_URL = "https://zebrapace.netlify.app/privacy.html"
    }
}
