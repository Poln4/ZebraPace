package com.paulina.zebrapace

import android.content.ContentProvider
import android.content.ContentValues
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.database.Cursor
import android.database.MatrixCursor
import android.net.Uri
import android.os.Binder
import android.os.Build
import android.os.Process
import java.io.File
import java.security.MessageDigest

/**
 * Android's half of the ZebraPace ↔ ZebraUp shared container (iOS uses the
 * App Group group.com.paulina.zebras). ZebraPace publishes one JSON
 * outbox (lib/domain/services/shared_outbox_builder.dart); ZebraUp reads
 * it with
 *
 *   contentResolver.query(Uri.parse("content://com.paulina.zebrapace.shared/outbox"), ...)
 *
 * and gets one row with a single "json" column (no row when sharing is off).
 *
 * The two apps are signed with different Play app-signing keys, so a
 * `signature` permission can't protect this, and `knownSigner` needs
 * Android 12 while ZebraPace supports 8+. Instead every call checks the
 * caller's package name *and* signing certificate in code.
 */
class SharedDataProvider : ContentProvider() {

    override fun onCreate(): Boolean = true

    override fun query(
        uri: Uri,
        projection: Array<out String>?,
        selection: String?,
        selectionArgs: Array<out String>?,
        sortOrder: String?,
    ): Cursor? {
        val ctx = context ?: return null
        if (!SharedContainer.callerAllowed(ctx, Binder.getCallingUid())) {
            throw SecurityException("Not allowed")
        }
        if (uri.pathSegments != listOf("outbox")) return null
        val cursor = MatrixCursor(arrayOf("json"))
        SharedContainer.readOutbox(ctx)?.let { cursor.addRow(arrayOf(it)) }
        return cursor
    }

    override fun getType(uri: Uri): String = "application/json"

    // Read-only: ZebraUp never writes into ZebraPace.
    override fun insert(uri: Uri, values: ContentValues?): Uri? = null
    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<out String>?): Int = 0
    override fun update(
        uri: Uri,
        values: ContentValues?,
        selection: String?,
        selectionArgs: Array<out String>?,
    ): Int = 0
}

object SharedContainer {
    const val CHANNEL = "zebrapace/shared_container"

    /** Who may read ZebraPace's outbox, by package → allowed SHA-256 certs. */
    private const val ZEBRAUP = "com.paulina.zebraup"

    // Play Console → ZebraUp → App integrity → App signing key certificate.
    private const val ZEBRAUP_PLAY_SIGNING =
        "DB:49:50:81:6B:8A:B4:07:30:88:63:24:C8:99:86:72:A0:52:E4:77:9A:89:25:4A:B7:9D:88:2B:76:C4:F8:BB"

    // ~/.android/debug.keystore on the development Mac; only trusted when
    // this build of ZebraPace is itself a debug build.
    private const val DEBUG_KEY =
        "48:4F:16:3E:31:23:6A:CF:78:86:83:66:58:C0:21:B7:FA:58:AA:9D:40:88:D6:B5:CB:9F:D7:01:2B:05:AD:2F"

    private fun outboxFile(context: Context) = File(File(context.filesDir, "shared"), "outbox.json")

    fun writeOutbox(context: Context, json: String) {
        val file = outboxFile(context)
        file.parentFile?.mkdirs()
        val tmp = File(file.parentFile, "outbox.json.tmp")
        tmp.writeText(json)
        tmp.renameTo(file)
    }

    fun clearOutbox(context: Context) {
        outboxFile(context).delete()
    }

    fun readOutbox(context: Context): String? =
        outboxFile(context).takeIf { it.exists() }?.readText()

    fun callerAllowed(context: Context, uid: Int): Boolean {
        if (uid == Process.myUid()) return true
        val pm = context.packageManager
        val packages = pm.getPackagesForUid(uid) ?: return false
        val certs = buildList {
            add(ZEBRAUP_PLAY_SIGNING)
            if (isDebugBuild(context)) add(DEBUG_KEY)
        }.map { hexToBytes(it) }
        return packages.any { pkg -> pkg == ZEBRAUP && certs.any { hasCert(pm, pkg, it) } }
    }

    private fun isDebugBuild(context: Context) =
        context.applicationInfo.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0

    @Suppress("DEPRECATION")
    private fun hasCert(pm: PackageManager, pkg: String, sha256: ByteArray): Boolean {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                pm.hasSigningCertificate(pkg, sha256, PackageManager.CERT_INPUT_SHA256)
            } else {
                val sigs = pm.getPackageInfo(pkg, PackageManager.GET_SIGNATURES).signatures
                // Before Android 9 a package lists every signer; require all
                // of them to be the expected one.
                !sigs.isNullOrEmpty() && sigs.all {
                    MessageDigest.getInstance("SHA-256").digest(it.toByteArray()).contentEquals(sha256)
                }
            }
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }

    private fun hexToBytes(hex: String): ByteArray =
        hex.split(":").map { it.toInt(16).toByte() }.toByteArray()
}
