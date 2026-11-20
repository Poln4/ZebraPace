package com.paulina.zebrapace

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.work.CoroutineWorker
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkerParameters
import org.json.JSONObject
import java.time.Instant
import java.time.LocalDate
import java.time.ZoneId
import java.time.temporal.ChronoUnit
import java.util.concurrent.TimeUnit

/**
 * Pacing alerts while ZebraPace is closed. The Dart side
 * (lib/data/notifications/pacing_alert_bridge.dart) owns every rule about
 * the envelope; it hands over a snapshot of today's thresholds and the
 * already-localized notification text, and this side only compares
 * Health Connect's step total against it. iOS has the same contract in
 * ios/Runner/PacingAlertMonitor.swift.
 */
object PacingAlerts {
    const val CHANNEL = "zebrapace/pacing_alerts"
    private const val PREFS = "pacing_alerts"
    private const val SNAPSHOT_KEY = "snapshot"
    private const val WORK_NAME = "pacing_alert_check"
    private const val NOTIFICATION_CHANNEL_ID = "pacing_alerts"

    fun configure(context: Context, json: String) {
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        prefs.edit().putString(SNAPSHOT_KEY, json).apply()
        val snapshot = Snapshot.parse(json)
        val work = WorkManager.getInstance(context)
        if (snapshot?.enabled == true) {
            // 15 min is WorkManager's floor; Android may stretch it further
            // under Doze, which is fine for a gentle heads-up.
            val request = PeriodicWorkRequestBuilder<PacingAlertWorker>(15, TimeUnit.MINUTES).build()
            work.enqueueUniquePeriodicWork(WORK_NAME, ExistingPeriodicWorkPolicy.KEEP, request)
        } else {
            work.cancelUniqueWork(WORK_NAME)
        }
    }

    fun load(context: Context): Snapshot? =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .getString(SNAPSHOT_KEY, null)
            ?.let { Snapshot.parse(it) }

    /** Posts at most one goal and one caution alert per day. */
    fun maybeNotify(context: Context, snapshot: Snapshot, thresholds: Thresholds, steps: Long) {
        val today = LocalDate.now().toString()
        val prefs = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
        val cautionKey = "notified_${today}_caution"
        val goalKey = "notified_${today}_goal"
        val kind = when {
            steps > thresholds.caution && !prefs.getBoolean(cautionKey, false) -> "caution"
            steps >= thresholds.goal && !prefs.getBoolean(goalKey, false) &&
                !prefs.getBoolean(cautionKey, false) -> "goal"
            else -> return
        }
        if (!canPost(context)) return
        val (title, body) = if (kind == "caution") {
            snapshot.cautionTitle to snapshot.cautionBody
        } else {
            snapshot.goalTitle to snapshot.goalBody
        }
        ensureChannel(context, snapshot.channelName)
        val open = PendingIntent.getActivity(
            context,
            0,
            Intent(context, MainActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
        )
        val notification = NotificationCompat.Builder(context, NOTIFICATION_CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_stat_zebrapace)
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setContentIntent(open)
            .setAutoCancel(true)
            .build()
        try {
            NotificationManagerCompat.from(context)
                .notify(if (kind == "caution") 9002 else 9001, notification)
        } catch (e: SecurityException) {
            return
        }
        prefs.edit().apply {
            putBoolean(if (kind == "caution") cautionKey else goalKey, true)
            // Passing the caution line also covers the goal.
            if (kind == "caution") putBoolean(goalKey, true)
            // Keep only today's flags.
            prefs.all.keys
                .filter { it.startsWith("notified_") && !it.startsWith("notified_${today}_") }
                .forEach { remove(it) }
        }.apply()
    }

    private fun canPost(context: Context): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) !=
            PackageManager.PERMISSION_GRANTED
        ) return false
        return NotificationManagerCompat.from(context).areNotificationsEnabled()
    }

    private fun ensureChannel(context: Context, name: String) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val manager = context.getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(
            NotificationChannel(NOTIFICATION_CHANNEL_ID, name, NotificationManager.IMPORTANCE_DEFAULT),
        )
    }
}

data class Thresholds(val goal: Int, val caution: Int)

data class Snapshot(
    val enabled: Boolean,
    val date: String,
    val goalSteps: Int,
    val cautionSteps: Int,
    val baseGoalSteps: Int,
    val baseCautionSteps: Int,
    val skipToday: Boolean,
    val goalTitle: String,
    val goalBody: String,
    val cautionTitle: String,
    val cautionBody: String,
    val channelName: String,
) {
    /**
     * The snapshot's own day uses its thresholds (readiness already
     * applied). For up to [CARRY_DAYS] days after, while the app hasn't
     * been opened, the plain baseline envelope stands in — a baseline
     * barely moves in a day or two, but readiness and Rest/Flare are
     * day-specific, so they don't carry.
     */
    fun thresholdsFor(day: LocalDate): Thresholds? {
        if (!enabled) return null
        val snapDay = runCatching { LocalDate.parse(date) }.getOrNull() ?: return null
        val gap = ChronoUnit.DAYS.between(snapDay, day)
        val t = when {
            gap == 0L -> if (skipToday) null else Thresholds(goalSteps, cautionSteps)
            gap in 1..CARRY_DAYS -> Thresholds(baseGoalSteps, baseCautionSteps)
            else -> null
        }
        return t?.takeIf { it.goal > 0 && it.caution > 0 }
    }

    companion object {
        const val CARRY_DAYS = 2L

        fun parse(json: String): Snapshot? = runCatching {
            val o = JSONObject(json)
            Snapshot(
                enabled = o.optBoolean("enabled", false),
                date = o.optString("date"),
                goalSteps = o.optInt("goalSteps"),
                cautionSteps = o.optInt("cautionSteps"),
                baseGoalSteps = o.optInt("baseGoalSteps"),
                baseCautionSteps = o.optInt("baseCautionSteps"),
                skipToday = o.optBoolean("skipToday", true),
                goalTitle = o.optString("goalTitle"),
                goalBody = o.optString("goalBody"),
                cautionTitle = o.optString("cautionTitle"),
                cautionBody = o.optString("cautionBody"),
                channelName = o.optString("channelName", "Pacing alerts"),
            )
        }.getOrNull()
    }
}

class PacingAlertWorker(context: Context, params: WorkerParameters) :
    CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        val ctx = applicationContext
        val snapshot = PacingAlerts.load(ctx) ?: return Result.success()
        val thresholds = snapshot.thresholdsFor(LocalDate.now()) ?: return Result.success()
        if (HealthConnectClient.getSdkStatus(ctx) != HealthConnectClient.SDK_AVAILABLE) {
            return Result.success()
        }
        val client = HealthConnectClient.getOrCreate(ctx)
        val granted = client.permissionController.getGrantedPermissions()
        if (HealthPermission.getReadPermission(StepsRecord::class) !in granted) return Result.success()
        val start = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant()
        val steps = try {
            client.aggregate(
                AggregateRequest(
                    metrics = setOf(StepsRecord.COUNT_TOTAL),
                    timeRangeFilter = TimeRangeFilter.between(start, Instant.now()),
                ),
            )[StepsRecord.COUNT_TOTAL] ?: 0L
        } catch (e: SecurityException) {
            // Background reading not granted (Android 14+ asks separately).
            return Result.success()
        } catch (e: Exception) {
            return Result.success()
        }
        PacingAlerts.maybeNotify(ctx, snapshot, thresholds, steps)
        return Result.success()
    }
}
