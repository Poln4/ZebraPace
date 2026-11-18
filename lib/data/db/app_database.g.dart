// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyLogsTable extends DailyLogs
    with TableInfo<$DailyLogsTable, DailyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatPercentageMeta = const VerificationMeta(
    'fatPercentage',
  );
  @override
  late final GeneratedColumn<double> fatPercentage = GeneratedColumn<double>(
    'fat_percentage',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterMlRawMeta = const VerificationMeta(
    'waterMlRaw',
  );
  @override
  late final GeneratedColumn<int> waterMlRaw = GeneratedColumn<int>(
    'water_ml_raw',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _waterMlCreditMeta = const VerificationMeta(
    'waterMlCredit',
  );
  @override
  late final GeneratedColumn<double> waterMlCredit = GeneratedColumn<double>(
    'water_ml_credit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creatineGMeta = const VerificationMeta(
    'creatineG',
  );
  @override
  late final GeneratedColumn<double> creatineG = GeneratedColumn<double>(
    'creatine_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mentalStateMeta = const VerificationMeta(
    'mentalState',
  );
  @override
  late final GeneratedColumn<String> mentalState = GeneratedColumn<String>(
    'mental_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFeelingMeta = const VerificationMeta(
    'bodyFeeling',
  );
  @override
  late final GeneratedColumn<String> bodyFeeling = GeneratedColumn<String>(
    'body_feeling',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bracesUsedMeta = const VerificationMeta(
    'bracesUsed',
  );
  @override
  late final GeneratedColumn<String> bracesUsed = GeneratedColumn<String>(
    'braces_used',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _braceComfortMeta = const VerificationMeta(
    'braceComfort',
  );
  @override
  late final GeneratedColumn<int> braceComfort = GeneratedColumn<int>(
    'brace_comfort',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isRestDayMeta = const VerificationMeta(
    'isRestDay',
  );
  @override
  late final GeneratedColumn<bool> isRestDay = GeneratedColumn<bool>(
    'is_rest_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_rest_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFlareDayMeta = const VerificationMeta(
    'isFlareDay',
  );
  @override
  late final GeneratedColumn<bool> isFlareDay = GeneratedColumn<bool>(
    'is_flare_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_flare_day" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sleepHoursMeta = const VerificationMeta(
    'sleepHours',
  );
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
    'sleep_hours',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<String> sleepQuality = GeneratedColumn<String>(
    'sleep_quality',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepHeartRateMinMeta = const VerificationMeta(
    'sleepHeartRateMin',
  );
  @override
  late final GeneratedColumn<int> sleepHeartRateMin = GeneratedColumn<int>(
    'sleep_heart_rate_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepHeartRateMaxMeta = const VerificationMeta(
    'sleepHeartRateMax',
  );
  @override
  late final GeneratedColumn<int> sleepHeartRateMax = GeneratedColumn<int>(
    'sleep_heart_rate_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restingHeartRateMeta = const VerificationMeta(
    'restingHeartRate',
  );
  @override
  late final GeneratedColumn<int> restingHeartRate = GeneratedColumn<int>(
    'resting_heart_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrvMsMeta = const VerificationMeta('hrvMs');
  @override
  late final GeneratedColumn<double> hrvMs = GeneratedColumn<double>(
    'hrv_ms',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepsSourceMeta = const VerificationMeta(
    'stepsSource',
  );
  @override
  late final GeneratedColumn<String> stepsSource = GeneratedColumn<String>(
    'steps_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepSourceMeta = const VerificationMeta(
    'sleepSource',
  );
  @override
  late final GeneratedColumn<String> sleepSource = GeneratedColumn<String>(
    'sleep_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartSourceMeta = const VerificationMeta(
    'heartSource',
  );
  @override
  late final GeneratedColumn<String> heartSource = GeneratedColumn<String>(
    'heart_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remSleepMinMeta = const VerificationMeta(
    'remSleepMin',
  );
  @override
  late final GeneratedColumn<int> remSleepMin = GeneratedColumn<int>(
    'rem_sleep_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deepSleepMinMeta = const VerificationMeta(
    'deepSleepMin',
  );
  @override
  late final GeneratedColumn<int> deepSleepMin = GeneratedColumn<int>(
    'deep_sleep_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hadNightmaresMeta = const VerificationMeta(
    'hadNightmares',
  );
  @override
  late final GeneratedColumn<bool> hadNightmares = GeneratedColumn<bool>(
    'had_nightmares',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("had_nightmares" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    weightKg,
    heightCm,
    fatPercentage,
    waterMlRaw,
    waterMlCredit,
    proteinG,
    creatineG,
    mentalState,
    bodyFeeling,
    bracesUsed,
    braceComfort,
    steps,
    isRestDay,
    isFlareDay,
    sleepHours,
    sleepQuality,
    sleepHeartRateMin,
    sleepHeartRateMax,
    restingHeartRate,
    hrvMs,
    stepsSource,
    sleepSource,
    heartSource,
    remSleepMin,
    deepSleepMin,
    hadNightmares,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('fat_percentage')) {
      context.handle(
        _fatPercentageMeta,
        fatPercentage.isAcceptableOrUnknown(
          data['fat_percentage']!,
          _fatPercentageMeta,
        ),
      );
    }
    if (data.containsKey('water_ml_raw')) {
      context.handle(
        _waterMlRawMeta,
        waterMlRaw.isAcceptableOrUnknown(
          data['water_ml_raw']!,
          _waterMlRawMeta,
        ),
      );
    }
    if (data.containsKey('water_ml_credit')) {
      context.handle(
        _waterMlCreditMeta,
        waterMlCredit.isAcceptableOrUnknown(
          data['water_ml_credit']!,
          _waterMlCreditMeta,
        ),
      );
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    }
    if (data.containsKey('creatine_g')) {
      context.handle(
        _creatineGMeta,
        creatineG.isAcceptableOrUnknown(data['creatine_g']!, _creatineGMeta),
      );
    }
    if (data.containsKey('mental_state')) {
      context.handle(
        _mentalStateMeta,
        mentalState.isAcceptableOrUnknown(
          data['mental_state']!,
          _mentalStateMeta,
        ),
      );
    }
    if (data.containsKey('body_feeling')) {
      context.handle(
        _bodyFeelingMeta,
        bodyFeeling.isAcceptableOrUnknown(
          data['body_feeling']!,
          _bodyFeelingMeta,
        ),
      );
    }
    if (data.containsKey('braces_used')) {
      context.handle(
        _bracesUsedMeta,
        bracesUsed.isAcceptableOrUnknown(data['braces_used']!, _bracesUsedMeta),
      );
    }
    if (data.containsKey('brace_comfort')) {
      context.handle(
        _braceComfortMeta,
        braceComfort.isAcceptableOrUnknown(
          data['brace_comfort']!,
          _braceComfortMeta,
        ),
      );
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('is_rest_day')) {
      context.handle(
        _isRestDayMeta,
        isRestDay.isAcceptableOrUnknown(data['is_rest_day']!, _isRestDayMeta),
      );
    }
    if (data.containsKey('is_flare_day')) {
      context.handle(
        _isFlareDayMeta,
        isFlareDay.isAcceptableOrUnknown(
          data['is_flare_day']!,
          _isFlareDayMeta,
        ),
      );
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
        _sleepHoursMeta,
        sleepHours.isAcceptableOrUnknown(data['sleep_hours']!, _sleepHoursMeta),
      );
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    }
    if (data.containsKey('sleep_heart_rate_min')) {
      context.handle(
        _sleepHeartRateMinMeta,
        sleepHeartRateMin.isAcceptableOrUnknown(
          data['sleep_heart_rate_min']!,
          _sleepHeartRateMinMeta,
        ),
      );
    }
    if (data.containsKey('sleep_heart_rate_max')) {
      context.handle(
        _sleepHeartRateMaxMeta,
        sleepHeartRateMax.isAcceptableOrUnknown(
          data['sleep_heart_rate_max']!,
          _sleepHeartRateMaxMeta,
        ),
      );
    }
    if (data.containsKey('resting_heart_rate')) {
      context.handle(
        _restingHeartRateMeta,
        restingHeartRate.isAcceptableOrUnknown(
          data['resting_heart_rate']!,
          _restingHeartRateMeta,
        ),
      );
    }
    if (data.containsKey('hrv_ms')) {
      context.handle(
        _hrvMsMeta,
        hrvMs.isAcceptableOrUnknown(data['hrv_ms']!, _hrvMsMeta),
      );
    }
    if (data.containsKey('steps_source')) {
      context.handle(
        _stepsSourceMeta,
        stepsSource.isAcceptableOrUnknown(
          data['steps_source']!,
          _stepsSourceMeta,
        ),
      );
    }
    if (data.containsKey('sleep_source')) {
      context.handle(
        _sleepSourceMeta,
        sleepSource.isAcceptableOrUnknown(
          data['sleep_source']!,
          _sleepSourceMeta,
        ),
      );
    }
    if (data.containsKey('heart_source')) {
      context.handle(
        _heartSourceMeta,
        heartSource.isAcceptableOrUnknown(
          data['heart_source']!,
          _heartSourceMeta,
        ),
      );
    }
    if (data.containsKey('rem_sleep_min')) {
      context.handle(
        _remSleepMinMeta,
        remSleepMin.isAcceptableOrUnknown(
          data['rem_sleep_min']!,
          _remSleepMinMeta,
        ),
      );
    }
    if (data.containsKey('deep_sleep_min')) {
      context.handle(
        _deepSleepMinMeta,
        deepSleepMin.isAcceptableOrUnknown(
          data['deep_sleep_min']!,
          _deepSleepMinMeta,
        ),
      );
    }
    if (data.containsKey('had_nightmares')) {
      context.handle(
        _hadNightmaresMeta,
        hadNightmares.isAcceptableOrUnknown(
          data['had_nightmares']!,
          _hadNightmaresMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      fatPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_percentage'],
      ),
      waterMlRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_ml_raw'],
      )!,
      waterMlCredit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_ml_credit'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      )!,
      creatineG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}creatine_g'],
      )!,
      mentalState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mental_state'],
      ),
      bodyFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_feeling'],
      ),
      bracesUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}braces_used'],
      )!,
      braceComfort: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brace_comfort'],
      ),
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      isRestDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_rest_day'],
      )!,
      isFlareDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_flare_day'],
      )!,
      sleepHours: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sleep_hours'],
      ),
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sleep_quality'],
      ),
      sleepHeartRateMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_heart_rate_min'],
      ),
      sleepHeartRateMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_heart_rate_max'],
      ),
      restingHeartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}resting_heart_rate'],
      ),
      hrvMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hrv_ms'],
      ),
      stepsSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}steps_source'],
      ),
      sleepSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sleep_source'],
      ),
      heartSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}heart_source'],
      ),
      remSleepMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rem_sleep_min'],
      ),
      deepSleepMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deep_sleep_min'],
      ),
      hadNightmares: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}had_nightmares'],
      ),
    );
  }

  @override
  $DailyLogsTable createAlias(String alias) {
    return $DailyLogsTable(attachedDatabase, alias);
  }
}

class DailyLog extends DataClass implements Insertable<DailyLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final double? weightKg;
  final double? heightCm;
  final double? fatPercentage;

  /// Raw ml consumed today, independent of hydration-factor weighting.
  final int waterMlRaw;

  /// Hydration-adjusted credit (= sum of liquid_logs.hydrationMlCredit for
  /// the day). In app.py this was ambiguously named `water_ml` and actually
  /// stored this credit value, not raw ml — split into two explicit columns
  /// here on purpose.
  final double waterMlCredit;

  /// Was an IntColumn before schemaVersion 4 — widened to allow decimal
  /// grams (e.g. a half-scoop or a label's "17.5g") instead of rounding
  /// every entry to a whole gram.
  final double proteinG;
  final double creatineG;
  final String? mentalState;
  final String? bodyFeeling;

  /// JSON-encoded list of BraceUse.toJson() objects (type plus side or
  /// count, or a custom brace's id and name). Days logged before that hold
  /// plain BraceType.db strings, which BraceUse.fromJson still reads.
  /// (app.py stored this as a Python str(list)/eval() pair.)
  final String bracesUsed;
  final int? braceComfort;
  final int steps;
  final bool isRestDay;
  final bool isFlareDay;

  /// Added in schemaVersion 2 — see AppDatabase's MigrationStrategy.
  /// Total sleep duration in decimal hours (a "7h 30m" picker input becomes
  /// 7.5) — no separate minutes column needed.
  final double? sleepHours;
  final String? sleepQuality;
  final int? sleepHeartRateMin;
  final int? sleepHeartRateMax;

  /// Added in schemaVersion 5. Morning resting heart rate (bpm) and HRV
  /// (ms), pre-filled from Apple Health / Health Connect or typed in by hand
  /// (e.g. a finger-on-camera reading) for people without a watch.
  final int? restingHeartRate;
  final double? hrvMs;

  /// Added in schemaVersion 6. Where each Health-backed group came from:
  /// 'health' (synced) or 'manual' (typed, or a synced value edited). Sync
  /// never overwrites a 'manual' group; null means nothing recorded yet.
  /// steps; sleep = sleepHours + sleepHeartRateMin/Max; heart =
  /// restingHeartRate + hrvMs. sleepQuality is always the person's own.
  final String? stepsSource;
  final String? sleepSource;
  final String? heartSource;

  /// Added in schemaVersion 10. Minutes of REM and deep sleep (from Health
  /// when the tracker records stages, or typed in; part of the sleep group
  /// for sleepSource), and whether there were nightmares — a yes/no only,
  /// always the person's own, like sleepQuality. Null means not recorded.
  final int? remSleepMin;
  final int? deepSleepMin;
  final bool? hadNightmares;
  const DailyLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    this.weightKg,
    this.heightCm,
    this.fatPercentage,
    required this.waterMlRaw,
    required this.waterMlCredit,
    required this.proteinG,
    required this.creatineG,
    this.mentalState,
    this.bodyFeeling,
    required this.bracesUsed,
    this.braceComfort,
    required this.steps,
    required this.isRestDay,
    required this.isFlareDay,
    this.sleepHours,
    this.sleepQuality,
    this.sleepHeartRateMin,
    this.sleepHeartRateMax,
    this.restingHeartRate,
    this.hrvMs,
    this.stepsSource,
    this.sleepSource,
    this.heartSource,
    this.remSleepMin,
    this.deepSleepMin,
    this.hadNightmares,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || fatPercentage != null) {
      map['fat_percentage'] = Variable<double>(fatPercentage);
    }
    map['water_ml_raw'] = Variable<int>(waterMlRaw);
    map['water_ml_credit'] = Variable<double>(waterMlCredit);
    map['protein_g'] = Variable<double>(proteinG);
    map['creatine_g'] = Variable<double>(creatineG);
    if (!nullToAbsent || mentalState != null) {
      map['mental_state'] = Variable<String>(mentalState);
    }
    if (!nullToAbsent || bodyFeeling != null) {
      map['body_feeling'] = Variable<String>(bodyFeeling);
    }
    map['braces_used'] = Variable<String>(bracesUsed);
    if (!nullToAbsent || braceComfort != null) {
      map['brace_comfort'] = Variable<int>(braceComfort);
    }
    map['steps'] = Variable<int>(steps);
    map['is_rest_day'] = Variable<bool>(isRestDay);
    map['is_flare_day'] = Variable<bool>(isFlareDay);
    if (!nullToAbsent || sleepHours != null) {
      map['sleep_hours'] = Variable<double>(sleepHours);
    }
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<String>(sleepQuality);
    }
    if (!nullToAbsent || sleepHeartRateMin != null) {
      map['sleep_heart_rate_min'] = Variable<int>(sleepHeartRateMin);
    }
    if (!nullToAbsent || sleepHeartRateMax != null) {
      map['sleep_heart_rate_max'] = Variable<int>(sleepHeartRateMax);
    }
    if (!nullToAbsent || restingHeartRate != null) {
      map['resting_heart_rate'] = Variable<int>(restingHeartRate);
    }
    if (!nullToAbsent || hrvMs != null) {
      map['hrv_ms'] = Variable<double>(hrvMs);
    }
    if (!nullToAbsent || stepsSource != null) {
      map['steps_source'] = Variable<String>(stepsSource);
    }
    if (!nullToAbsent || sleepSource != null) {
      map['sleep_source'] = Variable<String>(sleepSource);
    }
    if (!nullToAbsent || heartSource != null) {
      map['heart_source'] = Variable<String>(heartSource);
    }
    if (!nullToAbsent || remSleepMin != null) {
      map['rem_sleep_min'] = Variable<int>(remSleepMin);
    }
    if (!nullToAbsent || deepSleepMin != null) {
      map['deep_sleep_min'] = Variable<int>(deepSleepMin);
    }
    if (!nullToAbsent || hadNightmares != null) {
      map['had_nightmares'] = Variable<bool>(hadNightmares);
    }
    return map;
  }

  DailyLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      fatPercentage: fatPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(fatPercentage),
      waterMlRaw: Value(waterMlRaw),
      waterMlCredit: Value(waterMlCredit),
      proteinG: Value(proteinG),
      creatineG: Value(creatineG),
      mentalState: mentalState == null && nullToAbsent
          ? const Value.absent()
          : Value(mentalState),
      bodyFeeling: bodyFeeling == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFeeling),
      bracesUsed: Value(bracesUsed),
      braceComfort: braceComfort == null && nullToAbsent
          ? const Value.absent()
          : Value(braceComfort),
      steps: Value(steps),
      isRestDay: Value(isRestDay),
      isFlareDay: Value(isFlareDay),
      sleepHours: sleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHours),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      sleepHeartRateMin: sleepHeartRateMin == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHeartRateMin),
      sleepHeartRateMax: sleepHeartRateMax == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHeartRateMax),
      restingHeartRate: restingHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(restingHeartRate),
      hrvMs: hrvMs == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvMs),
      stepsSource: stepsSource == null && nullToAbsent
          ? const Value.absent()
          : Value(stepsSource),
      sleepSource: sleepSource == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepSource),
      heartSource: heartSource == null && nullToAbsent
          ? const Value.absent()
          : Value(heartSource),
      remSleepMin: remSleepMin == null && nullToAbsent
          ? const Value.absent()
          : Value(remSleepMin),
      deepSleepMin: deepSleepMin == null && nullToAbsent
          ? const Value.absent()
          : Value(deepSleepMin),
      hadNightmares: hadNightmares == null && nullToAbsent
          ? const Value.absent()
          : Value(hadNightmares),
    );
  }

  factory DailyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      fatPercentage: serializer.fromJson<double?>(json['fatPercentage']),
      waterMlRaw: serializer.fromJson<int>(json['waterMlRaw']),
      waterMlCredit: serializer.fromJson<double>(json['waterMlCredit']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      creatineG: serializer.fromJson<double>(json['creatineG']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
      bracesUsed: serializer.fromJson<String>(json['bracesUsed']),
      braceComfort: serializer.fromJson<int?>(json['braceComfort']),
      steps: serializer.fromJson<int>(json['steps']),
      isRestDay: serializer.fromJson<bool>(json['isRestDay']),
      isFlareDay: serializer.fromJson<bool>(json['isFlareDay']),
      sleepHours: serializer.fromJson<double?>(json['sleepHours']),
      sleepQuality: serializer.fromJson<String?>(json['sleepQuality']),
      sleepHeartRateMin: serializer.fromJson<int?>(json['sleepHeartRateMin']),
      sleepHeartRateMax: serializer.fromJson<int?>(json['sleepHeartRateMax']),
      restingHeartRate: serializer.fromJson<int?>(json['restingHeartRate']),
      hrvMs: serializer.fromJson<double?>(json['hrvMs']),
      stepsSource: serializer.fromJson<String?>(json['stepsSource']),
      sleepSource: serializer.fromJson<String?>(json['sleepSource']),
      heartSource: serializer.fromJson<String?>(json['heartSource']),
      remSleepMin: serializer.fromJson<int?>(json['remSleepMin']),
      deepSleepMin: serializer.fromJson<int?>(json['deepSleepMin']),
      hadNightmares: serializer.fromJson<bool?>(json['hadNightmares']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'weightKg': serializer.toJson<double?>(weightKg),
      'heightCm': serializer.toJson<double?>(heightCm),
      'fatPercentage': serializer.toJson<double?>(fatPercentage),
      'waterMlRaw': serializer.toJson<int>(waterMlRaw),
      'waterMlCredit': serializer.toJson<double>(waterMlCredit),
      'proteinG': serializer.toJson<double>(proteinG),
      'creatineG': serializer.toJson<double>(creatineG),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
      'bracesUsed': serializer.toJson<String>(bracesUsed),
      'braceComfort': serializer.toJson<int?>(braceComfort),
      'steps': serializer.toJson<int>(steps),
      'isRestDay': serializer.toJson<bool>(isRestDay),
      'isFlareDay': serializer.toJson<bool>(isFlareDay),
      'sleepHours': serializer.toJson<double?>(sleepHours),
      'sleepQuality': serializer.toJson<String?>(sleepQuality),
      'sleepHeartRateMin': serializer.toJson<int?>(sleepHeartRateMin),
      'sleepHeartRateMax': serializer.toJson<int?>(sleepHeartRateMax),
      'restingHeartRate': serializer.toJson<int?>(restingHeartRate),
      'hrvMs': serializer.toJson<double?>(hrvMs),
      'stepsSource': serializer.toJson<String?>(stepsSource),
      'sleepSource': serializer.toJson<String?>(sleepSource),
      'heartSource': serializer.toJson<String?>(heartSource),
      'remSleepMin': serializer.toJson<int?>(remSleepMin),
      'deepSleepMin': serializer.toJson<int?>(deepSleepMin),
      'hadNightmares': serializer.toJson<bool?>(hadNightmares),
    };
  }

  DailyLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    Value<double?> weightKg = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> fatPercentage = const Value.absent(),
    int? waterMlRaw,
    double? waterMlCredit,
    double? proteinG,
    double? creatineG,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
    String? bracesUsed,
    Value<int?> braceComfort = const Value.absent(),
    int? steps,
    bool? isRestDay,
    bool? isFlareDay,
    Value<double?> sleepHours = const Value.absent(),
    Value<String?> sleepQuality = const Value.absent(),
    Value<int?> sleepHeartRateMin = const Value.absent(),
    Value<int?> sleepHeartRateMax = const Value.absent(),
    Value<int?> restingHeartRate = const Value.absent(),
    Value<double?> hrvMs = const Value.absent(),
    Value<String?> stepsSource = const Value.absent(),
    Value<String?> sleepSource = const Value.absent(),
    Value<String?> heartSource = const Value.absent(),
    Value<int?> remSleepMin = const Value.absent(),
    Value<int?> deepSleepMin = const Value.absent(),
    Value<bool?> hadNightmares = const Value.absent(),
  }) => DailyLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    fatPercentage: fatPercentage.present
        ? fatPercentage.value
        : this.fatPercentage,
    waterMlRaw: waterMlRaw ?? this.waterMlRaw,
    waterMlCredit: waterMlCredit ?? this.waterMlCredit,
    proteinG: proteinG ?? this.proteinG,
    creatineG: creatineG ?? this.creatineG,
    mentalState: mentalState.present ? mentalState.value : this.mentalState,
    bodyFeeling: bodyFeeling.present ? bodyFeeling.value : this.bodyFeeling,
    bracesUsed: bracesUsed ?? this.bracesUsed,
    braceComfort: braceComfort.present ? braceComfort.value : this.braceComfort,
    steps: steps ?? this.steps,
    isRestDay: isRestDay ?? this.isRestDay,
    isFlareDay: isFlareDay ?? this.isFlareDay,
    sleepHours: sleepHours.present ? sleepHours.value : this.sleepHours,
    sleepQuality: sleepQuality.present ? sleepQuality.value : this.sleepQuality,
    sleepHeartRateMin: sleepHeartRateMin.present
        ? sleepHeartRateMin.value
        : this.sleepHeartRateMin,
    sleepHeartRateMax: sleepHeartRateMax.present
        ? sleepHeartRateMax.value
        : this.sleepHeartRateMax,
    restingHeartRate: restingHeartRate.present
        ? restingHeartRate.value
        : this.restingHeartRate,
    hrvMs: hrvMs.present ? hrvMs.value : this.hrvMs,
    stepsSource: stepsSource.present ? stepsSource.value : this.stepsSource,
    sleepSource: sleepSource.present ? sleepSource.value : this.sleepSource,
    heartSource: heartSource.present ? heartSource.value : this.heartSource,
    remSleepMin: remSleepMin.present ? remSleepMin.value : this.remSleepMin,
    deepSleepMin: deepSleepMin.present ? deepSleepMin.value : this.deepSleepMin,
    hadNightmares: hadNightmares.present
        ? hadNightmares.value
        : this.hadNightmares,
  );
  DailyLog copyWithCompanion(DailyLogsCompanion data) {
    return DailyLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      fatPercentage: data.fatPercentage.present
          ? data.fatPercentage.value
          : this.fatPercentage,
      waterMlRaw: data.waterMlRaw.present
          ? data.waterMlRaw.value
          : this.waterMlRaw,
      waterMlCredit: data.waterMlCredit.present
          ? data.waterMlCredit.value
          : this.waterMlCredit,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      creatineG: data.creatineG.present ? data.creatineG.value : this.creatineG,
      mentalState: data.mentalState.present
          ? data.mentalState.value
          : this.mentalState,
      bodyFeeling: data.bodyFeeling.present
          ? data.bodyFeeling.value
          : this.bodyFeeling,
      bracesUsed: data.bracesUsed.present
          ? data.bracesUsed.value
          : this.bracesUsed,
      braceComfort: data.braceComfort.present
          ? data.braceComfort.value
          : this.braceComfort,
      steps: data.steps.present ? data.steps.value : this.steps,
      isRestDay: data.isRestDay.present ? data.isRestDay.value : this.isRestDay,
      isFlareDay: data.isFlareDay.present
          ? data.isFlareDay.value
          : this.isFlareDay,
      sleepHours: data.sleepHours.present
          ? data.sleepHours.value
          : this.sleepHours,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      sleepHeartRateMin: data.sleepHeartRateMin.present
          ? data.sleepHeartRateMin.value
          : this.sleepHeartRateMin,
      sleepHeartRateMax: data.sleepHeartRateMax.present
          ? data.sleepHeartRateMax.value
          : this.sleepHeartRateMax,
      restingHeartRate: data.restingHeartRate.present
          ? data.restingHeartRate.value
          : this.restingHeartRate,
      hrvMs: data.hrvMs.present ? data.hrvMs.value : this.hrvMs,
      stepsSource: data.stepsSource.present
          ? data.stepsSource.value
          : this.stepsSource,
      sleepSource: data.sleepSource.present
          ? data.sleepSource.value
          : this.sleepSource,
      heartSource: data.heartSource.present
          ? data.heartSource.value
          : this.heartSource,
      remSleepMin: data.remSleepMin.present
          ? data.remSleepMin.value
          : this.remSleepMin,
      deepSleepMin: data.deepSleepMin.present
          ? data.deepSleepMin.value
          : this.deepSleepMin,
      hadNightmares: data.hadNightmares.present
          ? data.hadNightmares.value
          : this.hadNightmares,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('fatPercentage: $fatPercentage, ')
          ..write('waterMlRaw: $waterMlRaw, ')
          ..write('waterMlCredit: $waterMlCredit, ')
          ..write('proteinG: $proteinG, ')
          ..write('creatineG: $creatineG, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('bracesUsed: $bracesUsed, ')
          ..write('braceComfort: $braceComfort, ')
          ..write('steps: $steps, ')
          ..write('isRestDay: $isRestDay, ')
          ..write('isFlareDay: $isFlareDay, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('sleepHeartRateMin: $sleepHeartRateMin, ')
          ..write('sleepHeartRateMax: $sleepHeartRateMax, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('stepsSource: $stepsSource, ')
          ..write('sleepSource: $sleepSource, ')
          ..write('heartSource: $heartSource, ')
          ..write('remSleepMin: $remSleepMin, ')
          ..write('deepSleepMin: $deepSleepMin, ')
          ..write('hadNightmares: $hadNightmares')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    updatedAt,
    deletedAt,
    id,
    date,
    weightKg,
    heightCm,
    fatPercentage,
    waterMlRaw,
    waterMlCredit,
    proteinG,
    creatineG,
    mentalState,
    bodyFeeling,
    bracesUsed,
    braceComfort,
    steps,
    isRestDay,
    isFlareDay,
    sleepHours,
    sleepQuality,
    sleepHeartRateMin,
    sleepHeartRateMax,
    restingHeartRate,
    hrvMs,
    stepsSource,
    sleepSource,
    heartSource,
    remSleepMin,
    deepSleepMin,
    hadNightmares,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.heightCm == this.heightCm &&
          other.fatPercentage == this.fatPercentage &&
          other.waterMlRaw == this.waterMlRaw &&
          other.waterMlCredit == this.waterMlCredit &&
          other.proteinG == this.proteinG &&
          other.creatineG == this.creatineG &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling &&
          other.bracesUsed == this.bracesUsed &&
          other.braceComfort == this.braceComfort &&
          other.steps == this.steps &&
          other.isRestDay == this.isRestDay &&
          other.isFlareDay == this.isFlareDay &&
          other.sleepHours == this.sleepHours &&
          other.sleepQuality == this.sleepQuality &&
          other.sleepHeartRateMin == this.sleepHeartRateMin &&
          other.sleepHeartRateMax == this.sleepHeartRateMax &&
          other.restingHeartRate == this.restingHeartRate &&
          other.hrvMs == this.hrvMs &&
          other.stepsSource == this.stepsSource &&
          other.sleepSource == this.sleepSource &&
          other.heartSource == this.heartSource &&
          other.remSleepMin == this.remSleepMin &&
          other.deepSleepMin == this.deepSleepMin &&
          other.hadNightmares == this.hadNightmares);
}

class DailyLogsCompanion extends UpdateCompanion<DailyLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<double?> weightKg;
  final Value<double?> heightCm;
  final Value<double?> fatPercentage;
  final Value<int> waterMlRaw;
  final Value<double> waterMlCredit;
  final Value<double> proteinG;
  final Value<double> creatineG;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<String> bracesUsed;
  final Value<int?> braceComfort;
  final Value<int> steps;
  final Value<bool> isRestDay;
  final Value<bool> isFlareDay;
  final Value<double?> sleepHours;
  final Value<String?> sleepQuality;
  final Value<int?> sleepHeartRateMin;
  final Value<int?> sleepHeartRateMax;
  final Value<int?> restingHeartRate;
  final Value<double?> hrvMs;
  final Value<String?> stepsSource;
  final Value<String?> sleepSource;
  final Value<String?> heartSource;
  final Value<int?> remSleepMin;
  final Value<int?> deepSleepMin;
  final Value<bool?> hadNightmares;
  final Value<int> rowid;
  const DailyLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.fatPercentage = const Value.absent(),
    this.waterMlRaw = const Value.absent(),
    this.waterMlCredit = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.creatineG = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.bracesUsed = const Value.absent(),
    this.braceComfort = const Value.absent(),
    this.steps = const Value.absent(),
    this.isRestDay = const Value.absent(),
    this.isFlareDay = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.sleepHeartRateMin = const Value.absent(),
    this.sleepHeartRateMax = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.stepsSource = const Value.absent(),
    this.sleepSource = const Value.absent(),
    this.heartSource = const Value.absent(),
    this.remSleepMin = const Value.absent(),
    this.deepSleepMin = const Value.absent(),
    this.hadNightmares = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.fatPercentage = const Value.absent(),
    this.waterMlRaw = const Value.absent(),
    this.waterMlCredit = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.creatineG = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.bracesUsed = const Value.absent(),
    this.braceComfort = const Value.absent(),
    this.steps = const Value.absent(),
    this.isRestDay = const Value.absent(),
    this.isFlareDay = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.sleepHeartRateMin = const Value.absent(),
    this.sleepHeartRateMax = const Value.absent(),
    this.restingHeartRate = const Value.absent(),
    this.hrvMs = const Value.absent(),
    this.stepsSource = const Value.absent(),
    this.sleepSource = const Value.absent(),
    this.heartSource = const Value.absent(),
    this.remSleepMin = const Value.absent(),
    this.deepSleepMin = const Value.absent(),
    this.hadNightmares = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date);
  static Insertable<DailyLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<double>? heightCm,
    Expression<double>? fatPercentage,
    Expression<int>? waterMlRaw,
    Expression<double>? waterMlCredit,
    Expression<double>? proteinG,
    Expression<double>? creatineG,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? bracesUsed,
    Expression<int>? braceComfort,
    Expression<int>? steps,
    Expression<bool>? isRestDay,
    Expression<bool>? isFlareDay,
    Expression<double>? sleepHours,
    Expression<String>? sleepQuality,
    Expression<int>? sleepHeartRateMin,
    Expression<int>? sleepHeartRateMax,
    Expression<int>? restingHeartRate,
    Expression<double>? hrvMs,
    Expression<String>? stepsSource,
    Expression<String>? sleepSource,
    Expression<String>? heartSource,
    Expression<int>? remSleepMin,
    Expression<int>? deepSleepMin,
    Expression<bool>? hadNightmares,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (fatPercentage != null) 'fat_percentage': fatPercentage,
      if (waterMlRaw != null) 'water_ml_raw': waterMlRaw,
      if (waterMlCredit != null) 'water_ml_credit': waterMlCredit,
      if (proteinG != null) 'protein_g': proteinG,
      if (creatineG != null) 'creatine_g': creatineG,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (bracesUsed != null) 'braces_used': bracesUsed,
      if (braceComfort != null) 'brace_comfort': braceComfort,
      if (steps != null) 'steps': steps,
      if (isRestDay != null) 'is_rest_day': isRestDay,
      if (isFlareDay != null) 'is_flare_day': isFlareDay,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (sleepHeartRateMin != null) 'sleep_heart_rate_min': sleepHeartRateMin,
      if (sleepHeartRateMax != null) 'sleep_heart_rate_max': sleepHeartRateMax,
      if (restingHeartRate != null) 'resting_heart_rate': restingHeartRate,
      if (hrvMs != null) 'hrv_ms': hrvMs,
      if (stepsSource != null) 'steps_source': stepsSource,
      if (sleepSource != null) 'sleep_source': sleepSource,
      if (heartSource != null) 'heart_source': heartSource,
      if (remSleepMin != null) 'rem_sleep_min': remSleepMin,
      if (deepSleepMin != null) 'deep_sleep_min': deepSleepMin,
      if (hadNightmares != null) 'had_nightmares': hadNightmares,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<double?>? weightKg,
    Value<double?>? heightCm,
    Value<double?>? fatPercentage,
    Value<int>? waterMlRaw,
    Value<double>? waterMlCredit,
    Value<double>? proteinG,
    Value<double>? creatineG,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<String>? bracesUsed,
    Value<int?>? braceComfort,
    Value<int>? steps,
    Value<bool>? isRestDay,
    Value<bool>? isFlareDay,
    Value<double?>? sleepHours,
    Value<String?>? sleepQuality,
    Value<int?>? sleepHeartRateMin,
    Value<int?>? sleepHeartRateMax,
    Value<int?>? restingHeartRate,
    Value<double?>? hrvMs,
    Value<String?>? stepsSource,
    Value<String?>? sleepSource,
    Value<String?>? heartSource,
    Value<int?>? remSleepMin,
    Value<int?>? deepSleepMin,
    Value<bool?>? hadNightmares,
    Value<int>? rowid,
  }) {
    return DailyLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      fatPercentage: fatPercentage ?? this.fatPercentage,
      waterMlRaw: waterMlRaw ?? this.waterMlRaw,
      waterMlCredit: waterMlCredit ?? this.waterMlCredit,
      proteinG: proteinG ?? this.proteinG,
      creatineG: creatineG ?? this.creatineG,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      bracesUsed: bracesUsed ?? this.bracesUsed,
      braceComfort: braceComfort ?? this.braceComfort,
      steps: steps ?? this.steps,
      isRestDay: isRestDay ?? this.isRestDay,
      isFlareDay: isFlareDay ?? this.isFlareDay,
      sleepHours: sleepHours ?? this.sleepHours,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      sleepHeartRateMin: sleepHeartRateMin ?? this.sleepHeartRateMin,
      sleepHeartRateMax: sleepHeartRateMax ?? this.sleepHeartRateMax,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      hrvMs: hrvMs ?? this.hrvMs,
      stepsSource: stepsSource ?? this.stepsSource,
      sleepSource: sleepSource ?? this.sleepSource,
      heartSource: heartSource ?? this.heartSource,
      remSleepMin: remSleepMin ?? this.remSleepMin,
      deepSleepMin: deepSleepMin ?? this.deepSleepMin,
      hadNightmares: hadNightmares ?? this.hadNightmares,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (fatPercentage.present) {
      map['fat_percentage'] = Variable<double>(fatPercentage.value);
    }
    if (waterMlRaw.present) {
      map['water_ml_raw'] = Variable<int>(waterMlRaw.value);
    }
    if (waterMlCredit.present) {
      map['water_ml_credit'] = Variable<double>(waterMlCredit.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (creatineG.present) {
      map['creatine_g'] = Variable<double>(creatineG.value);
    }
    if (mentalState.present) {
      map['mental_state'] = Variable<String>(mentalState.value);
    }
    if (bodyFeeling.present) {
      map['body_feeling'] = Variable<String>(bodyFeeling.value);
    }
    if (bracesUsed.present) {
      map['braces_used'] = Variable<String>(bracesUsed.value);
    }
    if (braceComfort.present) {
      map['brace_comfort'] = Variable<int>(braceComfort.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (isRestDay.present) {
      map['is_rest_day'] = Variable<bool>(isRestDay.value);
    }
    if (isFlareDay.present) {
      map['is_flare_day'] = Variable<bool>(isFlareDay.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<String>(sleepQuality.value);
    }
    if (sleepHeartRateMin.present) {
      map['sleep_heart_rate_min'] = Variable<int>(sleepHeartRateMin.value);
    }
    if (sleepHeartRateMax.present) {
      map['sleep_heart_rate_max'] = Variable<int>(sleepHeartRateMax.value);
    }
    if (restingHeartRate.present) {
      map['resting_heart_rate'] = Variable<int>(restingHeartRate.value);
    }
    if (hrvMs.present) {
      map['hrv_ms'] = Variable<double>(hrvMs.value);
    }
    if (stepsSource.present) {
      map['steps_source'] = Variable<String>(stepsSource.value);
    }
    if (sleepSource.present) {
      map['sleep_source'] = Variable<String>(sleepSource.value);
    }
    if (heartSource.present) {
      map['heart_source'] = Variable<String>(heartSource.value);
    }
    if (remSleepMin.present) {
      map['rem_sleep_min'] = Variable<int>(remSleepMin.value);
    }
    if (deepSleepMin.present) {
      map['deep_sleep_min'] = Variable<int>(deepSleepMin.value);
    }
    if (hadNightmares.present) {
      map['had_nightmares'] = Variable<bool>(hadNightmares.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('fatPercentage: $fatPercentage, ')
          ..write('waterMlRaw: $waterMlRaw, ')
          ..write('waterMlCredit: $waterMlCredit, ')
          ..write('proteinG: $proteinG, ')
          ..write('creatineG: $creatineG, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('bracesUsed: $bracesUsed, ')
          ..write('braceComfort: $braceComfort, ')
          ..write('steps: $steps, ')
          ..write('isRestDay: $isRestDay, ')
          ..write('isFlareDay: $isFlareDay, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('sleepHeartRateMin: $sleepHeartRateMin, ')
          ..write('sleepHeartRateMax: $sleepHeartRateMax, ')
          ..write('restingHeartRate: $restingHeartRate, ')
          ..write('hrvMs: $hrvMs, ')
          ..write('stepsSource: $stepsSource, ')
          ..write('sleepSource: $sleepSource, ')
          ..write('heartSource: $heartSource, ')
          ..write('remSleepMin: $remSleepMin, ')
          ..write('deepSleepMin: $deepSleepMin, ')
          ..write('hadNightmares: $hadNightmares, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityNameMeta = const VerificationMeta(
    'activityName',
  );
  @override
  late final GeneratedColumn<String> activityName = GeneratedColumn<String>(
    'activity_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extraWeightKgMeta = const VerificationMeta(
    'extraWeightKg',
  );
  @override
  late final GeneratedColumn<double> extraWeightKg = GeneratedColumn<double>(
    'extra_weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mentalStateMeta = const VerificationMeta(
    'mentalState',
  );
  @override
  late final GeneratedColumn<String> mentalState = GeneratedColumn<String>(
    'mental_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFeelingMeta = const VerificationMeta(
    'bodyFeeling',
  );
  @override
  late final GeneratedColumn<String> bodyFeeling = GeneratedColumn<String>(
    'body_feeling',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _healthkitUuidMeta = const VerificationMeta(
    'healthkitUuid',
  );
  @override
  late final GeneratedColumn<String> healthkitUuid = GeneratedColumn<String>(
    'healthkit_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _metsAvgMeta = const VerificationMeta(
    'metsAvg',
  );
  @override
  late final GeneratedColumn<double> metsAvg = GeneratedColumn<double>(
    'mets_avg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeEnergyKcalMeta = const VerificationMeta(
    'activeEnergyKcal',
  );
  @override
  late final GeneratedColumn<double> activeEnergyKcal = GeneratedColumn<double>(
    'active_energy_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMinBpmMeta = const VerificationMeta(
    'heartRateMinBpm',
  );
  @override
  late final GeneratedColumn<int> heartRateMinBpm = GeneratedColumn<int>(
    'heart_rate_min_bpm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMaxBpmMeta = const VerificationMeta(
    'heartRateMaxBpm',
  );
  @override
  late final GeneratedColumn<int> heartRateMaxBpm = GeneratedColumn<int>(
    'heart_rate_max_bpm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    activityName,
    durationMin,
    extraWeightKg,
    mentalState,
    bodyFeeling,
    source,
    healthkitUuid,
    metsAvg,
    activeEnergyKcal,
    heartRateMinBpm,
    heartRateMaxBpm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('activity_name')) {
      context.handle(
        _activityNameMeta,
        activityName.isAcceptableOrUnknown(
          data['activity_name']!,
          _activityNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityNameMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('extra_weight_kg')) {
      context.handle(
        _extraWeightKgMeta,
        extraWeightKg.isAcceptableOrUnknown(
          data['extra_weight_kg']!,
          _extraWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('mental_state')) {
      context.handle(
        _mentalStateMeta,
        mentalState.isAcceptableOrUnknown(
          data['mental_state']!,
          _mentalStateMeta,
        ),
      );
    }
    if (data.containsKey('body_feeling')) {
      context.handle(
        _bodyFeelingMeta,
        bodyFeeling.isAcceptableOrUnknown(
          data['body_feeling']!,
          _bodyFeelingMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('healthkit_uuid')) {
      context.handle(
        _healthkitUuidMeta,
        healthkitUuid.isAcceptableOrUnknown(
          data['healthkit_uuid']!,
          _healthkitUuidMeta,
        ),
      );
    }
    if (data.containsKey('mets_avg')) {
      context.handle(
        _metsAvgMeta,
        metsAvg.isAcceptableOrUnknown(data['mets_avg']!, _metsAvgMeta),
      );
    }
    if (data.containsKey('active_energy_kcal')) {
      context.handle(
        _activeEnergyKcalMeta,
        activeEnergyKcal.isAcceptableOrUnknown(
          data['active_energy_kcal']!,
          _activeEnergyKcalMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_min_bpm')) {
      context.handle(
        _heartRateMinBpmMeta,
        heartRateMinBpm.isAcceptableOrUnknown(
          data['heart_rate_min_bpm']!,
          _heartRateMinBpmMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_max_bpm')) {
      context.handle(
        _heartRateMaxBpmMeta,
        heartRateMaxBpm.isAcceptableOrUnknown(
          data['heart_rate_max_bpm']!,
          _heartRateMaxBpmMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      activityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_name'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      )!,
      extraWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}extra_weight_kg'],
      )!,
      mentalState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mental_state'],
      ),
      bodyFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_feeling'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      healthkitUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}healthkit_uuid'],
      ),
      metsAvg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mets_avg'],
      ),
      activeEnergyKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}active_energy_kcal'],
      ),
      heartRateMinBpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_min_bpm'],
      ),
      heartRateMaxBpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_max_bpm'],
      ),
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String activityName;
  final int durationMin;
  final double extraWeightKg;
  final String? mentalState;
  final String? bodyFeeling;

  /// 'manual' or 'healthkit' — see MetsService / HealthKit import flow (Phase 3).
  final String source;

  /// HKWorkout UUID, when imported from HealthKit. Unique so re-scanning
  /// HealthKit never double-imports the same workout.
  final String? healthkitUuid;
  final double? metsAvg;
  final double? activeEnergyKcal;

  /// Heart rate range (bpm) during the activity — manually entered, or
  /// pulled from HealthKit's HEART_RATE samples within the workout's time
  /// window when imported. Mirrors DailyLogs' sleepHeartRateMin/Max.
  final int? heartRateMinBpm;
  final int? heartRateMaxBpm;
  const Activity({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.activityName,
    required this.durationMin,
    required this.extraWeightKg,
    this.mentalState,
    this.bodyFeeling,
    required this.source,
    this.healthkitUuid,
    this.metsAvg,
    this.activeEnergyKcal,
    this.heartRateMinBpm,
    this.heartRateMaxBpm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['activity_name'] = Variable<String>(activityName);
    map['duration_min'] = Variable<int>(durationMin);
    map['extra_weight_kg'] = Variable<double>(extraWeightKg);
    if (!nullToAbsent || mentalState != null) {
      map['mental_state'] = Variable<String>(mentalState);
    }
    if (!nullToAbsent || bodyFeeling != null) {
      map['body_feeling'] = Variable<String>(bodyFeeling);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || healthkitUuid != null) {
      map['healthkit_uuid'] = Variable<String>(healthkitUuid);
    }
    if (!nullToAbsent || metsAvg != null) {
      map['mets_avg'] = Variable<double>(metsAvg);
    }
    if (!nullToAbsent || activeEnergyKcal != null) {
      map['active_energy_kcal'] = Variable<double>(activeEnergyKcal);
    }
    if (!nullToAbsent || heartRateMinBpm != null) {
      map['heart_rate_min_bpm'] = Variable<int>(heartRateMinBpm);
    }
    if (!nullToAbsent || heartRateMaxBpm != null) {
      map['heart_rate_max_bpm'] = Variable<int>(heartRateMaxBpm);
    }
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      activityName: Value(activityName),
      durationMin: Value(durationMin),
      extraWeightKg: Value(extraWeightKg),
      mentalState: mentalState == null && nullToAbsent
          ? const Value.absent()
          : Value(mentalState),
      bodyFeeling: bodyFeeling == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFeeling),
      source: Value(source),
      healthkitUuid: healthkitUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(healthkitUuid),
      metsAvg: metsAvg == null && nullToAbsent
          ? const Value.absent()
          : Value(metsAvg),
      activeEnergyKcal: activeEnergyKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(activeEnergyKcal),
      heartRateMinBpm: heartRateMinBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMinBpm),
      heartRateMaxBpm: heartRateMaxBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMaxBpm),
    );
  }

  factory Activity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      activityName: serializer.fromJson<String>(json['activityName']),
      durationMin: serializer.fromJson<int>(json['durationMin']),
      extraWeightKg: serializer.fromJson<double>(json['extraWeightKg']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
      source: serializer.fromJson<String>(json['source']),
      healthkitUuid: serializer.fromJson<String?>(json['healthkitUuid']),
      metsAvg: serializer.fromJson<double?>(json['metsAvg']),
      activeEnergyKcal: serializer.fromJson<double?>(json['activeEnergyKcal']),
      heartRateMinBpm: serializer.fromJson<int?>(json['heartRateMinBpm']),
      heartRateMaxBpm: serializer.fromJson<int?>(json['heartRateMaxBpm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'activityName': serializer.toJson<String>(activityName),
      'durationMin': serializer.toJson<int>(durationMin),
      'extraWeightKg': serializer.toJson<double>(extraWeightKg),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
      'source': serializer.toJson<String>(source),
      'healthkitUuid': serializer.toJson<String?>(healthkitUuid),
      'metsAvg': serializer.toJson<double?>(metsAvg),
      'activeEnergyKcal': serializer.toJson<double?>(activeEnergyKcal),
      'heartRateMinBpm': serializer.toJson<int?>(heartRateMinBpm),
      'heartRateMaxBpm': serializer.toJson<int?>(heartRateMaxBpm),
    };
  }

  Activity copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? activityName,
    int? durationMin,
    double? extraWeightKg,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
    String? source,
    Value<String?> healthkitUuid = const Value.absent(),
    Value<double?> metsAvg = const Value.absent(),
    Value<double?> activeEnergyKcal = const Value.absent(),
    Value<int?> heartRateMinBpm = const Value.absent(),
    Value<int?> heartRateMaxBpm = const Value.absent(),
  }) => Activity(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    activityName: activityName ?? this.activityName,
    durationMin: durationMin ?? this.durationMin,
    extraWeightKg: extraWeightKg ?? this.extraWeightKg,
    mentalState: mentalState.present ? mentalState.value : this.mentalState,
    bodyFeeling: bodyFeeling.present ? bodyFeeling.value : this.bodyFeeling,
    source: source ?? this.source,
    healthkitUuid: healthkitUuid.present
        ? healthkitUuid.value
        : this.healthkitUuid,
    metsAvg: metsAvg.present ? metsAvg.value : this.metsAvg,
    activeEnergyKcal: activeEnergyKcal.present
        ? activeEnergyKcal.value
        : this.activeEnergyKcal,
    heartRateMinBpm: heartRateMinBpm.present
        ? heartRateMinBpm.value
        : this.heartRateMinBpm,
    heartRateMaxBpm: heartRateMaxBpm.present
        ? heartRateMaxBpm.value
        : this.heartRateMaxBpm,
  );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      activityName: data.activityName.present
          ? data.activityName.value
          : this.activityName,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      extraWeightKg: data.extraWeightKg.present
          ? data.extraWeightKg.value
          : this.extraWeightKg,
      mentalState: data.mentalState.present
          ? data.mentalState.value
          : this.mentalState,
      bodyFeeling: data.bodyFeeling.present
          ? data.bodyFeeling.value
          : this.bodyFeeling,
      source: data.source.present ? data.source.value : this.source,
      healthkitUuid: data.healthkitUuid.present
          ? data.healthkitUuid.value
          : this.healthkitUuid,
      metsAvg: data.metsAvg.present ? data.metsAvg.value : this.metsAvg,
      activeEnergyKcal: data.activeEnergyKcal.present
          ? data.activeEnergyKcal.value
          : this.activeEnergyKcal,
      heartRateMinBpm: data.heartRateMinBpm.present
          ? data.heartRateMinBpm.value
          : this.heartRateMinBpm,
      heartRateMaxBpm: data.heartRateMaxBpm.present
          ? data.heartRateMaxBpm.value
          : this.heartRateMaxBpm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('activityName: $activityName, ')
          ..write('durationMin: $durationMin, ')
          ..write('extraWeightKg: $extraWeightKg, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('source: $source, ')
          ..write('healthkitUuid: $healthkitUuid, ')
          ..write('metsAvg: $metsAvg, ')
          ..write('activeEnergyKcal: $activeEnergyKcal, ')
          ..write('heartRateMinBpm: $heartRateMinBpm, ')
          ..write('heartRateMaxBpm: $heartRateMaxBpm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    activityName,
    durationMin,
    extraWeightKg,
    mentalState,
    bodyFeeling,
    source,
    healthkitUuid,
    metsAvg,
    activeEnergyKcal,
    heartRateMinBpm,
    heartRateMaxBpm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.activityName == this.activityName &&
          other.durationMin == this.durationMin &&
          other.extraWeightKg == this.extraWeightKg &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling &&
          other.source == this.source &&
          other.healthkitUuid == this.healthkitUuid &&
          other.metsAvg == this.metsAvg &&
          other.activeEnergyKcal == this.activeEnergyKcal &&
          other.heartRateMinBpm == this.heartRateMinBpm &&
          other.heartRateMaxBpm == this.heartRateMaxBpm);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> activityName;
  final Value<int> durationMin;
  final Value<double> extraWeightKg;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<String> source;
  final Value<String?> healthkitUuid;
  final Value<double?> metsAvg;
  final Value<double?> activeEnergyKcal;
  final Value<int?> heartRateMinBpm;
  final Value<int?> heartRateMaxBpm;
  final Value<int> rowid;
  const ActivitiesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.activityName = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.extraWeightKg = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.source = const Value.absent(),
    this.healthkitUuid = const Value.absent(),
    this.metsAvg = const Value.absent(),
    this.activeEnergyKcal = const Value.absent(),
    this.heartRateMinBpm = const Value.absent(),
    this.heartRateMaxBpm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String activityName,
    required int durationMin,
    this.extraWeightKg = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.source = const Value.absent(),
    this.healthkitUuid = const Value.absent(),
    this.metsAvg = const Value.absent(),
    this.activeEnergyKcal = const Value.absent(),
    this.heartRateMinBpm = const Value.absent(),
    this.heartRateMaxBpm = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       activityName = Value(activityName),
       durationMin = Value(durationMin);
  static Insertable<Activity> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? activityName,
    Expression<int>? durationMin,
    Expression<double>? extraWeightKg,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? source,
    Expression<String>? healthkitUuid,
    Expression<double>? metsAvg,
    Expression<double>? activeEnergyKcal,
    Expression<int>? heartRateMinBpm,
    Expression<int>? heartRateMaxBpm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (activityName != null) 'activity_name': activityName,
      if (durationMin != null) 'duration_min': durationMin,
      if (extraWeightKg != null) 'extra_weight_kg': extraWeightKg,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (source != null) 'source': source,
      if (healthkitUuid != null) 'healthkit_uuid': healthkitUuid,
      if (metsAvg != null) 'mets_avg': metsAvg,
      if (activeEnergyKcal != null) 'active_energy_kcal': activeEnergyKcal,
      if (heartRateMinBpm != null) 'heart_rate_min_bpm': heartRateMinBpm,
      if (heartRateMaxBpm != null) 'heart_rate_max_bpm': heartRateMaxBpm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitiesCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? activityName,
    Value<int>? durationMin,
    Value<double>? extraWeightKg,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<String>? source,
    Value<String?>? healthkitUuid,
    Value<double?>? metsAvg,
    Value<double?>? activeEnergyKcal,
    Value<int?>? heartRateMinBpm,
    Value<int?>? heartRateMaxBpm,
    Value<int>? rowid,
  }) {
    return ActivitiesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      activityName: activityName ?? this.activityName,
      durationMin: durationMin ?? this.durationMin,
      extraWeightKg: extraWeightKg ?? this.extraWeightKg,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      source: source ?? this.source,
      healthkitUuid: healthkitUuid ?? this.healthkitUuid,
      metsAvg: metsAvg ?? this.metsAvg,
      activeEnergyKcal: activeEnergyKcal ?? this.activeEnergyKcal,
      heartRateMinBpm: heartRateMinBpm ?? this.heartRateMinBpm,
      heartRateMaxBpm: heartRateMaxBpm ?? this.heartRateMaxBpm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (activityName.present) {
      map['activity_name'] = Variable<String>(activityName.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (extraWeightKg.present) {
      map['extra_weight_kg'] = Variable<double>(extraWeightKg.value);
    }
    if (mentalState.present) {
      map['mental_state'] = Variable<String>(mentalState.value);
    }
    if (bodyFeeling.present) {
      map['body_feeling'] = Variable<String>(bodyFeeling.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (healthkitUuid.present) {
      map['healthkit_uuid'] = Variable<String>(healthkitUuid.value);
    }
    if (metsAvg.present) {
      map['mets_avg'] = Variable<double>(metsAvg.value);
    }
    if (activeEnergyKcal.present) {
      map['active_energy_kcal'] = Variable<double>(activeEnergyKcal.value);
    }
    if (heartRateMinBpm.present) {
      map['heart_rate_min_bpm'] = Variable<int>(heartRateMinBpm.value);
    }
    if (heartRateMaxBpm.present) {
      map['heart_rate_max_bpm'] = Variable<int>(heartRateMaxBpm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('activityName: $activityName, ')
          ..write('durationMin: $durationMin, ')
          ..write('extraWeightKg: $extraWeightKg, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('source: $source, ')
          ..write('healthkitUuid: $healthkitUuid, ')
          ..write('metsAvg: $metsAvg, ')
          ..write('activeEnergyKcal: $activeEnergyKcal, ')
          ..write('heartRateMinBpm: $heartRateMinBpm, ')
          ..write('heartRateMaxBpm: $heartRateMaxBpm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CalisthenicsTable extends Calisthenics
    with TableInfo<$CalisthenicsTable, Calisthenic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalisthenicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseMeta = const VerificationMeta(
    'exercise',
  );
  @override
  late final GeneratedColumn<String> exercise = GeneratedColumn<String>(
    'exercise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressionMeta = const VerificationMeta(
    'progression',
  );
  @override
  late final GeneratedColumn<String> progression = GeneratedColumn<String>(
    'progression',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setValuesMeta = const VerificationMeta(
    'setValues',
  );
  @override
  late final GeneratedColumn<String> setValues = GeneratedColumn<String>(
    'set_values',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('reps'),
  );
  static const VerificationMeta _comfortScoreMeta = const VerificationMeta(
    'comfortScore',
  );
  @override
  late final GeneratedColumn<double> comfortScore = GeneratedColumn<double>(
    'comfort_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mentalStateMeta = const VerificationMeta(
    'mentalState',
  );
  @override
  late final GeneratedColumn<String> mentalState = GeneratedColumn<String>(
    'mental_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFeelingMeta = const VerificationMeta(
    'bodyFeeling',
  );
  @override
  late final GeneratedColumn<String> bodyFeeling = GeneratedColumn<String>(
    'body_feeling',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contractionModeMeta = const VerificationMeta(
    'contractionMode',
  );
  @override
  late final GeneratedColumn<String> contractionMode = GeneratedColumn<String>(
    'contraction_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMinBpmMeta = const VerificationMeta(
    'heartRateMinBpm',
  );
  @override
  late final GeneratedColumn<int> heartRateMinBpm = GeneratedColumn<int>(
    'heart_rate_min_bpm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMaxBpmMeta = const VerificationMeta(
    'heartRateMaxBpm',
  );
  @override
  late final GeneratedColumn<int> heartRateMaxBpm = GeneratedColumn<int>(
    'heart_rate_max_bpm',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    exercise,
    progression,
    sets,
    reps,
    setValues,
    unit,
    comfortScore,
    mentalState,
    bodyFeeling,
    contractionMode,
    heartRateMinBpm,
    heartRateMaxBpm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calisthenics';
  @override
  VerificationContext validateIntegrity(
    Insertable<Calisthenic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('exercise')) {
      context.handle(
        _exerciseMeta,
        exercise.isAcceptableOrUnknown(data['exercise']!, _exerciseMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseMeta);
    }
    if (data.containsKey('progression')) {
      context.handle(
        _progressionMeta,
        progression.isAcceptableOrUnknown(
          data['progression']!,
          _progressionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_progressionMeta);
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    } else if (isInserting) {
      context.missing(_setsMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('set_values')) {
      context.handle(
        _setValuesMeta,
        setValues.isAcceptableOrUnknown(data['set_values']!, _setValuesMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('comfort_score')) {
      context.handle(
        _comfortScoreMeta,
        comfortScore.isAcceptableOrUnknown(
          data['comfort_score']!,
          _comfortScoreMeta,
        ),
      );
    }
    if (data.containsKey('mental_state')) {
      context.handle(
        _mentalStateMeta,
        mentalState.isAcceptableOrUnknown(
          data['mental_state']!,
          _mentalStateMeta,
        ),
      );
    }
    if (data.containsKey('body_feeling')) {
      context.handle(
        _bodyFeelingMeta,
        bodyFeeling.isAcceptableOrUnknown(
          data['body_feeling']!,
          _bodyFeelingMeta,
        ),
      );
    }
    if (data.containsKey('contraction_mode')) {
      context.handle(
        _contractionModeMeta,
        contractionMode.isAcceptableOrUnknown(
          data['contraction_mode']!,
          _contractionModeMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_min_bpm')) {
      context.handle(
        _heartRateMinBpmMeta,
        heartRateMinBpm.isAcceptableOrUnknown(
          data['heart_rate_min_bpm']!,
          _heartRateMinBpmMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_max_bpm')) {
      context.handle(
        _heartRateMaxBpmMeta,
        heartRateMaxBpm.isAcceptableOrUnknown(
          data['heart_rate_max_bpm']!,
          _heartRateMaxBpmMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Calisthenic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Calisthenic(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      exercise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise'],
      )!,
      progression: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}progression'],
      )!,
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      setValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_values'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      comfortScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}comfort_score'],
      )!,
      mentalState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mental_state'],
      ),
      bodyFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_feeling'],
      ),
      contractionMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contraction_mode'],
      ),
      heartRateMinBpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_min_bpm'],
      ),
      heartRateMaxBpm: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_max_bpm'],
      ),
    );
  }

  @override
  $CalisthenicsTable createAlias(String alias) {
    return $CalisthenicsTable(attachedDatabase, alias);
  }
}

class Calisthenic extends DataClass implements Insertable<Calisthenic> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String exercise;
  final String progression;

  /// Set count and best set — kept filled for older readers (exports,
  /// app.py-era tooling); [setValues] is the source of truth.
  final int sets;
  final int reps;

  /// Each set's reps or seconds, as a JSON int list, e.g. `[30,20,23]`.
  /// Null on rows logged before v7, which read as `sets` × `reps`.
  final String? setValues;

  /// `reps` or `seconds` — see SetUnit.
  final String unit;

  /// 1.0-5.0 comfort slider value — the only comfort field that matters.
  /// app.py's original also had a dead/unused legacy `comfortable` boolean
  /// column; deliberately not ported.
  final double comfortScore;
  final String? mentalState;
  final String? bodyFeeling;
  final String? contractionMode;

  /// Heart rate range (bpm) during the set — manually entered. Mirrors
  /// DailyLogs' sleepHeartRateMin/Max and Activities' heartRateMin/MaxBpm.
  final int? heartRateMinBpm;
  final int? heartRateMaxBpm;
  const Calisthenic({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.exercise,
    required this.progression,
    required this.sets,
    required this.reps,
    this.setValues,
    required this.unit,
    required this.comfortScore,
    this.mentalState,
    this.bodyFeeling,
    this.contractionMode,
    this.heartRateMinBpm,
    this.heartRateMaxBpm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['exercise'] = Variable<String>(exercise);
    map['progression'] = Variable<String>(progression);
    map['sets'] = Variable<int>(sets);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || setValues != null) {
      map['set_values'] = Variable<String>(setValues);
    }
    map['unit'] = Variable<String>(unit);
    map['comfort_score'] = Variable<double>(comfortScore);
    if (!nullToAbsent || mentalState != null) {
      map['mental_state'] = Variable<String>(mentalState);
    }
    if (!nullToAbsent || bodyFeeling != null) {
      map['body_feeling'] = Variable<String>(bodyFeeling);
    }
    if (!nullToAbsent || contractionMode != null) {
      map['contraction_mode'] = Variable<String>(contractionMode);
    }
    if (!nullToAbsent || heartRateMinBpm != null) {
      map['heart_rate_min_bpm'] = Variable<int>(heartRateMinBpm);
    }
    if (!nullToAbsent || heartRateMaxBpm != null) {
      map['heart_rate_max_bpm'] = Variable<int>(heartRateMaxBpm);
    }
    return map;
  }

  CalisthenicsCompanion toCompanion(bool nullToAbsent) {
    return CalisthenicsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      exercise: Value(exercise),
      progression: Value(progression),
      sets: Value(sets),
      reps: Value(reps),
      setValues: setValues == null && nullToAbsent
          ? const Value.absent()
          : Value(setValues),
      unit: Value(unit),
      comfortScore: Value(comfortScore),
      mentalState: mentalState == null && nullToAbsent
          ? const Value.absent()
          : Value(mentalState),
      bodyFeeling: bodyFeeling == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFeeling),
      contractionMode: contractionMode == null && nullToAbsent
          ? const Value.absent()
          : Value(contractionMode),
      heartRateMinBpm: heartRateMinBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMinBpm),
      heartRateMaxBpm: heartRateMaxBpm == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMaxBpm),
    );
  }

  factory Calisthenic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Calisthenic(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      exercise: serializer.fromJson<String>(json['exercise']),
      progression: serializer.fromJson<String>(json['progression']),
      sets: serializer.fromJson<int>(json['sets']),
      reps: serializer.fromJson<int>(json['reps']),
      setValues: serializer.fromJson<String?>(json['setValues']),
      unit: serializer.fromJson<String>(json['unit']),
      comfortScore: serializer.fromJson<double>(json['comfortScore']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
      contractionMode: serializer.fromJson<String?>(json['contractionMode']),
      heartRateMinBpm: serializer.fromJson<int?>(json['heartRateMinBpm']),
      heartRateMaxBpm: serializer.fromJson<int?>(json['heartRateMaxBpm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'exercise': serializer.toJson<String>(exercise),
      'progression': serializer.toJson<String>(progression),
      'sets': serializer.toJson<int>(sets),
      'reps': serializer.toJson<int>(reps),
      'setValues': serializer.toJson<String?>(setValues),
      'unit': serializer.toJson<String>(unit),
      'comfortScore': serializer.toJson<double>(comfortScore),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
      'contractionMode': serializer.toJson<String?>(contractionMode),
      'heartRateMinBpm': serializer.toJson<int?>(heartRateMinBpm),
      'heartRateMaxBpm': serializer.toJson<int?>(heartRateMaxBpm),
    };
  }

  Calisthenic copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? exercise,
    String? progression,
    int? sets,
    int? reps,
    Value<String?> setValues = const Value.absent(),
    String? unit,
    double? comfortScore,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
    Value<String?> contractionMode = const Value.absent(),
    Value<int?> heartRateMinBpm = const Value.absent(),
    Value<int?> heartRateMaxBpm = const Value.absent(),
  }) => Calisthenic(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    exercise: exercise ?? this.exercise,
    progression: progression ?? this.progression,
    sets: sets ?? this.sets,
    reps: reps ?? this.reps,
    setValues: setValues.present ? setValues.value : this.setValues,
    unit: unit ?? this.unit,
    comfortScore: comfortScore ?? this.comfortScore,
    mentalState: mentalState.present ? mentalState.value : this.mentalState,
    bodyFeeling: bodyFeeling.present ? bodyFeeling.value : this.bodyFeeling,
    contractionMode: contractionMode.present
        ? contractionMode.value
        : this.contractionMode,
    heartRateMinBpm: heartRateMinBpm.present
        ? heartRateMinBpm.value
        : this.heartRateMinBpm,
    heartRateMaxBpm: heartRateMaxBpm.present
        ? heartRateMaxBpm.value
        : this.heartRateMaxBpm,
  );
  Calisthenic copyWithCompanion(CalisthenicsCompanion data) {
    return Calisthenic(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      exercise: data.exercise.present ? data.exercise.value : this.exercise,
      progression: data.progression.present
          ? data.progression.value
          : this.progression,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      setValues: data.setValues.present ? data.setValues.value : this.setValues,
      unit: data.unit.present ? data.unit.value : this.unit,
      comfortScore: data.comfortScore.present
          ? data.comfortScore.value
          : this.comfortScore,
      mentalState: data.mentalState.present
          ? data.mentalState.value
          : this.mentalState,
      bodyFeeling: data.bodyFeeling.present
          ? data.bodyFeeling.value
          : this.bodyFeeling,
      contractionMode: data.contractionMode.present
          ? data.contractionMode.value
          : this.contractionMode,
      heartRateMinBpm: data.heartRateMinBpm.present
          ? data.heartRateMinBpm.value
          : this.heartRateMinBpm,
      heartRateMaxBpm: data.heartRateMaxBpm.present
          ? data.heartRateMaxBpm.value
          : this.heartRateMaxBpm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Calisthenic(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exercise: $exercise, ')
          ..write('progression: $progression, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('setValues: $setValues, ')
          ..write('unit: $unit, ')
          ..write('comfortScore: $comfortScore, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('contractionMode: $contractionMode, ')
          ..write('heartRateMinBpm: $heartRateMinBpm, ')
          ..write('heartRateMaxBpm: $heartRateMaxBpm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    exercise,
    progression,
    sets,
    reps,
    setValues,
    unit,
    comfortScore,
    mentalState,
    bodyFeeling,
    contractionMode,
    heartRateMinBpm,
    heartRateMaxBpm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Calisthenic &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.exercise == this.exercise &&
          other.progression == this.progression &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.setValues == this.setValues &&
          other.unit == this.unit &&
          other.comfortScore == this.comfortScore &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling &&
          other.contractionMode == this.contractionMode &&
          other.heartRateMinBpm == this.heartRateMinBpm &&
          other.heartRateMaxBpm == this.heartRateMaxBpm);
}

class CalisthenicsCompanion extends UpdateCompanion<Calisthenic> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> exercise;
  final Value<String> progression;
  final Value<int> sets;
  final Value<int> reps;
  final Value<String?> setValues;
  final Value<String> unit;
  final Value<double> comfortScore;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<String?> contractionMode;
  final Value<int?> heartRateMinBpm;
  final Value<int?> heartRateMaxBpm;
  final Value<int> rowid;
  const CalisthenicsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.exercise = const Value.absent(),
    this.progression = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.setValues = const Value.absent(),
    this.unit = const Value.absent(),
    this.comfortScore = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.contractionMode = const Value.absent(),
    this.heartRateMinBpm = const Value.absent(),
    this.heartRateMaxBpm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalisthenicsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String exercise,
    required String progression,
    required int sets,
    required int reps,
    this.setValues = const Value.absent(),
    this.unit = const Value.absent(),
    this.comfortScore = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.contractionMode = const Value.absent(),
    this.heartRateMinBpm = const Value.absent(),
    this.heartRateMaxBpm = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       exercise = Value(exercise),
       progression = Value(progression),
       sets = Value(sets),
       reps = Value(reps);
  static Insertable<Calisthenic> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? exercise,
    Expression<String>? progression,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<String>? setValues,
    Expression<String>? unit,
    Expression<double>? comfortScore,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? contractionMode,
    Expression<int>? heartRateMinBpm,
    Expression<int>? heartRateMaxBpm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (exercise != null) 'exercise': exercise,
      if (progression != null) 'progression': progression,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (setValues != null) 'set_values': setValues,
      if (unit != null) 'unit': unit,
      if (comfortScore != null) 'comfort_score': comfortScore,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (contractionMode != null) 'contraction_mode': contractionMode,
      if (heartRateMinBpm != null) 'heart_rate_min_bpm': heartRateMinBpm,
      if (heartRateMaxBpm != null) 'heart_rate_max_bpm': heartRateMaxBpm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalisthenicsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? exercise,
    Value<String>? progression,
    Value<int>? sets,
    Value<int>? reps,
    Value<String?>? setValues,
    Value<String>? unit,
    Value<double>? comfortScore,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<String?>? contractionMode,
    Value<int?>? heartRateMinBpm,
    Value<int?>? heartRateMaxBpm,
    Value<int>? rowid,
  }) {
    return CalisthenicsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      exercise: exercise ?? this.exercise,
      progression: progression ?? this.progression,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      setValues: setValues ?? this.setValues,
      unit: unit ?? this.unit,
      comfortScore: comfortScore ?? this.comfortScore,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      contractionMode: contractionMode ?? this.contractionMode,
      heartRateMinBpm: heartRateMinBpm ?? this.heartRateMinBpm,
      heartRateMaxBpm: heartRateMaxBpm ?? this.heartRateMaxBpm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (exercise.present) {
      map['exercise'] = Variable<String>(exercise.value);
    }
    if (progression.present) {
      map['progression'] = Variable<String>(progression.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (setValues.present) {
      map['set_values'] = Variable<String>(setValues.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (comfortScore.present) {
      map['comfort_score'] = Variable<double>(comfortScore.value);
    }
    if (mentalState.present) {
      map['mental_state'] = Variable<String>(mentalState.value);
    }
    if (bodyFeeling.present) {
      map['body_feeling'] = Variable<String>(bodyFeeling.value);
    }
    if (contractionMode.present) {
      map['contraction_mode'] = Variable<String>(contractionMode.value);
    }
    if (heartRateMinBpm.present) {
      map['heart_rate_min_bpm'] = Variable<int>(heartRateMinBpm.value);
    }
    if (heartRateMaxBpm.present) {
      map['heart_rate_max_bpm'] = Variable<int>(heartRateMaxBpm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalisthenicsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('exercise: $exercise, ')
          ..write('progression: $progression, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('setValues: $setValues, ')
          ..write('unit: $unit, ')
          ..write('comfortScore: $comfortScore, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('contractionMode: $contractionMode, ')
          ..write('heartRateMinBpm: $heartRateMinBpm, ')
          ..write('heartRateMaxBpm: $heartRateMaxBpm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TherapiesTable extends Therapies
    with TableInfo<$TherapiesTable, Therapy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TherapiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _therapyNameMeta = const VerificationMeta(
    'therapyName',
  );
  @override
  late final GeneratedColumn<String> therapyName = GeneratedColumn<String>(
    'therapy_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mentalStateMeta = const VerificationMeta(
    'mentalState',
  );
  @override
  late final GeneratedColumn<String> mentalState = GeneratedColumn<String>(
    'mental_state',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFeelingMeta = const VerificationMeta(
    'bodyFeeling',
  );
  @override
  late final GeneratedColumn<String> bodyFeeling = GeneratedColumn<String>(
    'body_feeling',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    therapyName,
    durationMin,
    mentalState,
    bodyFeeling,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'therapies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Therapy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('therapy_name')) {
      context.handle(
        _therapyNameMeta,
        therapyName.isAcceptableOrUnknown(
          data['therapy_name']!,
          _therapyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_therapyNameMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('mental_state')) {
      context.handle(
        _mentalStateMeta,
        mentalState.isAcceptableOrUnknown(
          data['mental_state']!,
          _mentalStateMeta,
        ),
      );
    }
    if (data.containsKey('body_feeling')) {
      context.handle(
        _bodyFeelingMeta,
        bodyFeeling.isAcceptableOrUnknown(
          data['body_feeling']!,
          _bodyFeelingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Therapy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Therapy(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      therapyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}therapy_name'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      )!,
      mentalState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mental_state'],
      ),
      bodyFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_feeling'],
      ),
    );
  }

  @override
  $TherapiesTable createAlias(String alias) {
    return $TherapiesTable(attachedDatabase, alias);
  }
}

class Therapy extends DataClass implements Insertable<Therapy> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String therapyName;
  final int durationMin;
  final String? mentalState;
  final String? bodyFeeling;
  const Therapy({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.therapyName,
    required this.durationMin,
    this.mentalState,
    this.bodyFeeling,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['therapy_name'] = Variable<String>(therapyName);
    map['duration_min'] = Variable<int>(durationMin);
    if (!nullToAbsent || mentalState != null) {
      map['mental_state'] = Variable<String>(mentalState);
    }
    if (!nullToAbsent || bodyFeeling != null) {
      map['body_feeling'] = Variable<String>(bodyFeeling);
    }
    return map;
  }

  TherapiesCompanion toCompanion(bool nullToAbsent) {
    return TherapiesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      therapyName: Value(therapyName),
      durationMin: Value(durationMin),
      mentalState: mentalState == null && nullToAbsent
          ? const Value.absent()
          : Value(mentalState),
      bodyFeeling: bodyFeeling == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFeeling),
    );
  }

  factory Therapy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Therapy(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      therapyName: serializer.fromJson<String>(json['therapyName']),
      durationMin: serializer.fromJson<int>(json['durationMin']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'therapyName': serializer.toJson<String>(therapyName),
      'durationMin': serializer.toJson<int>(durationMin),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
    };
  }

  Therapy copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? therapyName,
    int? durationMin,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
  }) => Therapy(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    therapyName: therapyName ?? this.therapyName,
    durationMin: durationMin ?? this.durationMin,
    mentalState: mentalState.present ? mentalState.value : this.mentalState,
    bodyFeeling: bodyFeeling.present ? bodyFeeling.value : this.bodyFeeling,
  );
  Therapy copyWithCompanion(TherapiesCompanion data) {
    return Therapy(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      therapyName: data.therapyName.present
          ? data.therapyName.value
          : this.therapyName,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      mentalState: data.mentalState.present
          ? data.mentalState.value
          : this.mentalState,
      bodyFeeling: data.bodyFeeling.present
          ? data.bodyFeeling.value
          : this.bodyFeeling,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Therapy(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('therapyName: $therapyName, ')
          ..write('durationMin: $durationMin, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    therapyName,
    durationMin,
    mentalState,
    bodyFeeling,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Therapy &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.therapyName == this.therapyName &&
          other.durationMin == this.durationMin &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling);
}

class TherapiesCompanion extends UpdateCompanion<Therapy> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> therapyName;
  final Value<int> durationMin;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<int> rowid;
  const TherapiesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.therapyName = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TherapiesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String therapyName,
    required int durationMin,
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       therapyName = Value(therapyName),
       durationMin = Value(durationMin);
  static Insertable<Therapy> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? therapyName,
    Expression<int>? durationMin,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (therapyName != null) 'therapy_name': therapyName,
      if (durationMin != null) 'duration_min': durationMin,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TherapiesCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? therapyName,
    Value<int>? durationMin,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<int>? rowid,
  }) {
    return TherapiesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      therapyName: therapyName ?? this.therapyName,
      durationMin: durationMin ?? this.durationMin,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (therapyName.present) {
      map['therapy_name'] = Variable<String>(therapyName.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (mentalState.present) {
      map['mental_state'] = Variable<String>(mentalState.value);
    }
    if (bodyFeeling.present) {
      map['body_feeling'] = Variable<String>(bodyFeeling.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TherapiesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('therapyName: $therapyName, ')
          ..write('durationMin: $durationMin, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LiquidLogsTable extends LiquidLogs
    with TableInfo<$LiquidLogsTable, LiquidLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LiquidLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _drinkTypeMeta = const VerificationMeta(
    'drinkType',
  );
  @override
  late final GeneratedColumn<String> drinkType = GeneratedColumn<String>(
    'drink_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customDrinkLabelMeta = const VerificationMeta(
    'customDrinkLabel',
  );
  @override
  late final GeneratedColumn<String> customDrinkLabel = GeneratedColumn<String>(
    'custom_drink_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMlRawMeta = const VerificationMeta(
    'amountMlRaw',
  );
  @override
  late final GeneratedColumn<int> amountMlRaw = GeneratedColumn<int>(
    'amount_ml_raw',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hydrationMlCreditMeta = const VerificationMeta(
    'hydrationMlCredit',
  );
  @override
  late final GeneratedColumn<double> hydrationMlCredit =
      GeneratedColumn<double>(
        'hydration_ml_credit',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    drinkType,
    customDrinkLabel,
    amountMlRaw,
    hydrationMlCredit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liquid_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LiquidLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('drink_type')) {
      context.handle(
        _drinkTypeMeta,
        drinkType.isAcceptableOrUnknown(data['drink_type']!, _drinkTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_drinkTypeMeta);
    }
    if (data.containsKey('custom_drink_label')) {
      context.handle(
        _customDrinkLabelMeta,
        customDrinkLabel.isAcceptableOrUnknown(
          data['custom_drink_label']!,
          _customDrinkLabelMeta,
        ),
      );
    }
    if (data.containsKey('amount_ml_raw')) {
      context.handle(
        _amountMlRawMeta,
        amountMlRaw.isAcceptableOrUnknown(
          data['amount_ml_raw']!,
          _amountMlRawMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMlRawMeta);
    }
    if (data.containsKey('hydration_ml_credit')) {
      context.handle(
        _hydrationMlCreditMeta,
        hydrationMlCredit.isAcceptableOrUnknown(
          data['hydration_ml_credit']!,
          _hydrationMlCreditMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hydrationMlCreditMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LiquidLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LiquidLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      drinkType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drink_type'],
      )!,
      customDrinkLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_drink_label'],
      ),
      amountMlRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_ml_raw'],
      )!,
      hydrationMlCredit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hydration_ml_credit'],
      )!,
    );
  }

  @override
  $LiquidLogsTable createAlias(String alias) {
    return $LiquidLogsTable(attachedDatabase, alias);
  }
}

class LiquidLog extends DataClass implements Insertable<LiquidLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String drinkType;

  /// For DrinkType.other, the user's custom-typed label is stored here too
  /// (drinkType stays 'other' for factor lookup; this holds the free-text name).
  final String? customDrinkLabel;
  final int amountMlRaw;

  /// = amountMlRaw * DrinkType.hydrationFactor, computed at write time.
  final double hydrationMlCredit;
  const LiquidLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.drinkType,
    this.customDrinkLabel,
    required this.amountMlRaw,
    required this.hydrationMlCredit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['drink_type'] = Variable<String>(drinkType);
    if (!nullToAbsent || customDrinkLabel != null) {
      map['custom_drink_label'] = Variable<String>(customDrinkLabel);
    }
    map['amount_ml_raw'] = Variable<int>(amountMlRaw);
    map['hydration_ml_credit'] = Variable<double>(hydrationMlCredit);
    return map;
  }

  LiquidLogsCompanion toCompanion(bool nullToAbsent) {
    return LiquidLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      drinkType: Value(drinkType),
      customDrinkLabel: customDrinkLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(customDrinkLabel),
      amountMlRaw: Value(amountMlRaw),
      hydrationMlCredit: Value(hydrationMlCredit),
    );
  }

  factory LiquidLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LiquidLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      drinkType: serializer.fromJson<String>(json['drinkType']),
      customDrinkLabel: serializer.fromJson<String?>(json['customDrinkLabel']),
      amountMlRaw: serializer.fromJson<int>(json['amountMlRaw']),
      hydrationMlCredit: serializer.fromJson<double>(json['hydrationMlCredit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'drinkType': serializer.toJson<String>(drinkType),
      'customDrinkLabel': serializer.toJson<String?>(customDrinkLabel),
      'amountMlRaw': serializer.toJson<int>(amountMlRaw),
      'hydrationMlCredit': serializer.toJson<double>(hydrationMlCredit),
    };
  }

  LiquidLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? drinkType,
    Value<String?> customDrinkLabel = const Value.absent(),
    int? amountMlRaw,
    double? hydrationMlCredit,
  }) => LiquidLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    drinkType: drinkType ?? this.drinkType,
    customDrinkLabel: customDrinkLabel.present
        ? customDrinkLabel.value
        : this.customDrinkLabel,
    amountMlRaw: amountMlRaw ?? this.amountMlRaw,
    hydrationMlCredit: hydrationMlCredit ?? this.hydrationMlCredit,
  );
  LiquidLog copyWithCompanion(LiquidLogsCompanion data) {
    return LiquidLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      drinkType: data.drinkType.present ? data.drinkType.value : this.drinkType,
      customDrinkLabel: data.customDrinkLabel.present
          ? data.customDrinkLabel.value
          : this.customDrinkLabel,
      amountMlRaw: data.amountMlRaw.present
          ? data.amountMlRaw.value
          : this.amountMlRaw,
      hydrationMlCredit: data.hydrationMlCredit.present
          ? data.hydrationMlCredit.value
          : this.hydrationMlCredit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LiquidLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('drinkType: $drinkType, ')
          ..write('customDrinkLabel: $customDrinkLabel, ')
          ..write('amountMlRaw: $amountMlRaw, ')
          ..write('hydrationMlCredit: $hydrationMlCredit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    drinkType,
    customDrinkLabel,
    amountMlRaw,
    hydrationMlCredit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LiquidLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.drinkType == this.drinkType &&
          other.customDrinkLabel == this.customDrinkLabel &&
          other.amountMlRaw == this.amountMlRaw &&
          other.hydrationMlCredit == this.hydrationMlCredit);
}

class LiquidLogsCompanion extends UpdateCompanion<LiquidLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> drinkType;
  final Value<String?> customDrinkLabel;
  final Value<int> amountMlRaw;
  final Value<double> hydrationMlCredit;
  final Value<int> rowid;
  const LiquidLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.drinkType = const Value.absent(),
    this.customDrinkLabel = const Value.absent(),
    this.amountMlRaw = const Value.absent(),
    this.hydrationMlCredit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LiquidLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String drinkType,
    this.customDrinkLabel = const Value.absent(),
    required int amountMlRaw,
    required double hydrationMlCredit,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       drinkType = Value(drinkType),
       amountMlRaw = Value(amountMlRaw),
       hydrationMlCredit = Value(hydrationMlCredit);
  static Insertable<LiquidLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? drinkType,
    Expression<String>? customDrinkLabel,
    Expression<int>? amountMlRaw,
    Expression<double>? hydrationMlCredit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (drinkType != null) 'drink_type': drinkType,
      if (customDrinkLabel != null) 'custom_drink_label': customDrinkLabel,
      if (amountMlRaw != null) 'amount_ml_raw': amountMlRaw,
      if (hydrationMlCredit != null) 'hydration_ml_credit': hydrationMlCredit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LiquidLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? drinkType,
    Value<String?>? customDrinkLabel,
    Value<int>? amountMlRaw,
    Value<double>? hydrationMlCredit,
    Value<int>? rowid,
  }) {
    return LiquidLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      drinkType: drinkType ?? this.drinkType,
      customDrinkLabel: customDrinkLabel ?? this.customDrinkLabel,
      amountMlRaw: amountMlRaw ?? this.amountMlRaw,
      hydrationMlCredit: hydrationMlCredit ?? this.hydrationMlCredit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (drinkType.present) {
      map['drink_type'] = Variable<String>(drinkType.value);
    }
    if (customDrinkLabel.present) {
      map['custom_drink_label'] = Variable<String>(customDrinkLabel.value);
    }
    if (amountMlRaw.present) {
      map['amount_ml_raw'] = Variable<int>(amountMlRaw.value);
    }
    if (hydrationMlCredit.present) {
      map['hydration_ml_credit'] = Variable<double>(hydrationMlCredit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LiquidLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('drinkType: $drinkType, ')
          ..write('customDrinkLabel: $customDrinkLabel, ')
          ..write('amountMlRaw: $amountMlRaw, ')
          ..write('hydrationMlCredit: $hydrationMlCredit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  final String updatedAt;
  const Setting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? value, String? updatedAt}) => Setting(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeatherCacheTable extends WeatherCache
    with TableInfo<$WeatherCacheTable, WeatherCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tempCMeta = const VerificationMeta('tempC');
  @override
  late final GeneratedColumn<double> tempC = GeneratedColumn<double>(
    'temp_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _humidityPctMeta = const VerificationMeta(
    'humidityPct',
  );
  @override
  late final GeneratedColumn<double> humidityPct = GeneratedColumn<double>(
    'humidity_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureHpaMeta = const VerificationMeta(
    'pressureHpa',
  );
  @override
  late final GeneratedColumn<double> pressureHpa = GeneratedColumn<double>(
    'pressure_hpa',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    lat,
    lon,
    tempC,
    humidityPct,
    pressureHpa,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('temp_c')) {
      context.handle(
        _tempCMeta,
        tempC.isAcceptableOrUnknown(data['temp_c']!, _tempCMeta),
      );
    }
    if (data.containsKey('humidity_pct')) {
      context.handle(
        _humidityPctMeta,
        humidityPct.isAcceptableOrUnknown(
          data['humidity_pct']!,
          _humidityPctMeta,
        ),
      );
    }
    if (data.containsKey('pressure_hpa')) {
      context.handle(
        _pressureHpaMeta,
        pressureHpa.isAcceptableOrUnknown(
          data['pressure_hpa']!,
          _pressureHpaMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, lat, lon};
  @override
  WeatherCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherCacheData(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      tempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temp_c'],
      ),
      humidityPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}humidity_pct'],
      ),
      pressureHpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_hpa'],
      ),
    );
  }

  @override
  $WeatherCacheTable createAlias(String alias) {
    return $WeatherCacheTable(attachedDatabase, alias);
  }
}

class WeatherCacheData extends DataClass
    implements Insertable<WeatherCacheData> {
  final String date;
  final double lat;
  final double lon;
  final double? tempC;
  final double? humidityPct;
  final double? pressureHpa;
  const WeatherCacheData({
    required this.date,
    required this.lat,
    required this.lon,
    this.tempC,
    this.humidityPct,
    this.pressureHpa,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    if (!nullToAbsent || tempC != null) {
      map['temp_c'] = Variable<double>(tempC);
    }
    if (!nullToAbsent || humidityPct != null) {
      map['humidity_pct'] = Variable<double>(humidityPct);
    }
    if (!nullToAbsent || pressureHpa != null) {
      map['pressure_hpa'] = Variable<double>(pressureHpa);
    }
    return map;
  }

  WeatherCacheCompanion toCompanion(bool nullToAbsent) {
    return WeatherCacheCompanion(
      date: Value(date),
      lat: Value(lat),
      lon: Value(lon),
      tempC: tempC == null && nullToAbsent
          ? const Value.absent()
          : Value(tempC),
      humidityPct: humidityPct == null && nullToAbsent
          ? const Value.absent()
          : Value(humidityPct),
      pressureHpa: pressureHpa == null && nullToAbsent
          ? const Value.absent()
          : Value(pressureHpa),
    );
  }

  factory WeatherCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherCacheData(
      date: serializer.fromJson<String>(json['date']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      tempC: serializer.fromJson<double?>(json['tempC']),
      humidityPct: serializer.fromJson<double?>(json['humidityPct']),
      pressureHpa: serializer.fromJson<double?>(json['pressureHpa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'tempC': serializer.toJson<double?>(tempC),
      'humidityPct': serializer.toJson<double?>(humidityPct),
      'pressureHpa': serializer.toJson<double?>(pressureHpa),
    };
  }

  WeatherCacheData copyWith({
    String? date,
    double? lat,
    double? lon,
    Value<double?> tempC = const Value.absent(),
    Value<double?> humidityPct = const Value.absent(),
    Value<double?> pressureHpa = const Value.absent(),
  }) => WeatherCacheData(
    date: date ?? this.date,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    tempC: tempC.present ? tempC.value : this.tempC,
    humidityPct: humidityPct.present ? humidityPct.value : this.humidityPct,
    pressureHpa: pressureHpa.present ? pressureHpa.value : this.pressureHpa,
  );
  WeatherCacheData copyWithCompanion(WeatherCacheCompanion data) {
    return WeatherCacheData(
      date: data.date.present ? data.date.value : this.date,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      tempC: data.tempC.present ? data.tempC.value : this.tempC,
      humidityPct: data.humidityPct.present
          ? data.humidityPct.value
          : this.humidityPct,
      pressureHpa: data.pressureHpa.present
          ? data.pressureHpa.value
          : this.pressureHpa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCacheData(')
          ..write('date: $date, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('tempC: $tempC, ')
          ..write('humidityPct: $humidityPct, ')
          ..write('pressureHpa: $pressureHpa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, lat, lon, tempC, humidityPct, pressureHpa);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherCacheData &&
          other.date == this.date &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.tempC == this.tempC &&
          other.humidityPct == this.humidityPct &&
          other.pressureHpa == this.pressureHpa);
}

class WeatherCacheCompanion extends UpdateCompanion<WeatherCacheData> {
  final Value<String> date;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double?> tempC;
  final Value<double?> humidityPct;
  final Value<double?> pressureHpa;
  final Value<int> rowid;
  const WeatherCacheCompanion({
    this.date = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.tempC = const Value.absent(),
    this.humidityPct = const Value.absent(),
    this.pressureHpa = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeatherCacheCompanion.insert({
    required String date,
    required double lat,
    required double lon,
    this.tempC = const Value.absent(),
    this.humidityPct = const Value.absent(),
    this.pressureHpa = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       lat = Value(lat),
       lon = Value(lon);
  static Insertable<WeatherCacheData> custom({
    Expression<String>? date,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? tempC,
    Expression<double>? humidityPct,
    Expression<double>? pressureHpa,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (tempC != null) 'temp_c': tempC,
      if (humidityPct != null) 'humidity_pct': humidityPct,
      if (pressureHpa != null) 'pressure_hpa': pressureHpa,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeatherCacheCompanion copyWith({
    Value<String>? date,
    Value<double>? lat,
    Value<double>? lon,
    Value<double?>? tempC,
    Value<double?>? humidityPct,
    Value<double?>? pressureHpa,
    Value<int>? rowid,
  }) {
    return WeatherCacheCompanion(
      date: date ?? this.date,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      tempC: tempC ?? this.tempC,
      humidityPct: humidityPct ?? this.humidityPct,
      pressureHpa: pressureHpa ?? this.pressureHpa,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (tempC.present) {
      map['temp_c'] = Variable<double>(tempC.value);
    }
    if (humidityPct.present) {
      map['humidity_pct'] = Variable<double>(humidityPct.value);
    }
    if (pressureHpa.present) {
      map['pressure_hpa'] = Variable<double>(pressureHpa.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCacheCompanion(')
          ..write('date: $date, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('tempC: $tempC, ')
          ..write('humidityPct: $humidityPct, ')
          ..write('pressureHpa: $pressureHpa, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SorenessChecksTable extends SorenessChecks
    with TableInfo<$SorenessChecksTable, SorenessCheck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SorenessChecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _onsetMeta = const VerificationMeta('onset');
  @override
  late final GeneratedColumn<String> onset = GeneratedColumn<String>(
    'onset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spreadMeta = const VerificationMeta('spread');
  @override
  late final GeneratedColumn<String> spread = GeneratedColumn<String>(
    'spread',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trendMeta = const VerificationMeta('trend');
  @override
  late final GeneratedColumn<String> trend = GeneratedColumn<String>(
    'trend',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verdictMeta = const VerificationMeta(
    'verdict',
  );
  @override
  late final GeneratedColumn<String> verdict = GeneratedColumn<String>(
    'verdict',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _verdictLabelMeta = const VerificationMeta(
    'verdictLabel',
  );
  @override
  late final GeneratedColumn<String> verdictLabel = GeneratedColumn<String>(
    'verdict_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    onset,
    spread,
    trend,
    verdict,
    verdictLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soreness_checks';
  @override
  VerificationContext validateIntegrity(
    Insertable<SorenessCheck> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('onset')) {
      context.handle(
        _onsetMeta,
        onset.isAcceptableOrUnknown(data['onset']!, _onsetMeta),
      );
    } else if (isInserting) {
      context.missing(_onsetMeta);
    }
    if (data.containsKey('spread')) {
      context.handle(
        _spreadMeta,
        spread.isAcceptableOrUnknown(data['spread']!, _spreadMeta),
      );
    } else if (isInserting) {
      context.missing(_spreadMeta);
    }
    if (data.containsKey('trend')) {
      context.handle(
        _trendMeta,
        trend.isAcceptableOrUnknown(data['trend']!, _trendMeta),
      );
    } else if (isInserting) {
      context.missing(_trendMeta);
    }
    if (data.containsKey('verdict')) {
      context.handle(
        _verdictMeta,
        verdict.isAcceptableOrUnknown(data['verdict']!, _verdictMeta),
      );
    } else if (isInserting) {
      context.missing(_verdictMeta);
    }
    if (data.containsKey('verdict_label')) {
      context.handle(
        _verdictLabelMeta,
        verdictLabel.isAcceptableOrUnknown(
          data['verdict_label']!,
          _verdictLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_verdictLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SorenessCheck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SorenessCheck(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      onset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}onset'],
      )!,
      spread: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spread'],
      )!,
      trend: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trend'],
      )!,
      verdict: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verdict'],
      )!,
      verdictLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verdict_label'],
      )!,
    );
  }

  @override
  $SorenessChecksTable createAlias(String alias) {
    return $SorenessChecksTable(attachedDatabase, alias);
  }
}

class SorenessCheck extends DataClass implements Insertable<SorenessCheck> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String onset;
  final String spread;
  final String trend;
  final String verdict;
  final String verdictLabel;
  const SorenessCheck({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.onset,
    required this.spread,
    required this.trend,
    required this.verdict,
    required this.verdictLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['onset'] = Variable<String>(onset);
    map['spread'] = Variable<String>(spread);
    map['trend'] = Variable<String>(trend);
    map['verdict'] = Variable<String>(verdict);
    map['verdict_label'] = Variable<String>(verdictLabel);
    return map;
  }

  SorenessChecksCompanion toCompanion(bool nullToAbsent) {
    return SorenessChecksCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      onset: Value(onset),
      spread: Value(spread),
      trend: Value(trend),
      verdict: Value(verdict),
      verdictLabel: Value(verdictLabel),
    );
  }

  factory SorenessCheck.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SorenessCheck(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      onset: serializer.fromJson<String>(json['onset']),
      spread: serializer.fromJson<String>(json['spread']),
      trend: serializer.fromJson<String>(json['trend']),
      verdict: serializer.fromJson<String>(json['verdict']),
      verdictLabel: serializer.fromJson<String>(json['verdictLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'onset': serializer.toJson<String>(onset),
      'spread': serializer.toJson<String>(spread),
      'trend': serializer.toJson<String>(trend),
      'verdict': serializer.toJson<String>(verdict),
      'verdictLabel': serializer.toJson<String>(verdictLabel),
    };
  }

  SorenessCheck copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? onset,
    String? spread,
    String? trend,
    String? verdict,
    String? verdictLabel,
  }) => SorenessCheck(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    onset: onset ?? this.onset,
    spread: spread ?? this.spread,
    trend: trend ?? this.trend,
    verdict: verdict ?? this.verdict,
    verdictLabel: verdictLabel ?? this.verdictLabel,
  );
  SorenessCheck copyWithCompanion(SorenessChecksCompanion data) {
    return SorenessCheck(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      onset: data.onset.present ? data.onset.value : this.onset,
      spread: data.spread.present ? data.spread.value : this.spread,
      trend: data.trend.present ? data.trend.value : this.trend,
      verdict: data.verdict.present ? data.verdict.value : this.verdict,
      verdictLabel: data.verdictLabel.present
          ? data.verdictLabel.value
          : this.verdictLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SorenessCheck(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('onset: $onset, ')
          ..write('spread: $spread, ')
          ..write('trend: $trend, ')
          ..write('verdict: $verdict, ')
          ..write('verdictLabel: $verdictLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    onset,
    spread,
    trend,
    verdict,
    verdictLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SorenessCheck &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.onset == this.onset &&
          other.spread == this.spread &&
          other.trend == this.trend &&
          other.verdict == this.verdict &&
          other.verdictLabel == this.verdictLabel);
}

class SorenessChecksCompanion extends UpdateCompanion<SorenessCheck> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> onset;
  final Value<String> spread;
  final Value<String> trend;
  final Value<String> verdict;
  final Value<String> verdictLabel;
  final Value<int> rowid;
  const SorenessChecksCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.onset = const Value.absent(),
    this.spread = const Value.absent(),
    this.trend = const Value.absent(),
    this.verdict = const Value.absent(),
    this.verdictLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SorenessChecksCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String onset,
    required String spread,
    required String trend,
    required String verdict,
    required String verdictLabel,
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       onset = Value(onset),
       spread = Value(spread),
       trend = Value(trend),
       verdict = Value(verdict),
       verdictLabel = Value(verdictLabel);
  static Insertable<SorenessCheck> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? onset,
    Expression<String>? spread,
    Expression<String>? trend,
    Expression<String>? verdict,
    Expression<String>? verdictLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (onset != null) 'onset': onset,
      if (spread != null) 'spread': spread,
      if (trend != null) 'trend': trend,
      if (verdict != null) 'verdict': verdict,
      if (verdictLabel != null) 'verdict_label': verdictLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SorenessChecksCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? onset,
    Value<String>? spread,
    Value<String>? trend,
    Value<String>? verdict,
    Value<String>? verdictLabel,
    Value<int>? rowid,
  }) {
    return SorenessChecksCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      onset: onset ?? this.onset,
      spread: spread ?? this.spread,
      trend: trend ?? this.trend,
      verdict: verdict ?? this.verdict,
      verdictLabel: verdictLabel ?? this.verdictLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (onset.present) {
      map['onset'] = Variable<String>(onset.value);
    }
    if (spread.present) {
      map['spread'] = Variable<String>(spread.value);
    }
    if (trend.present) {
      map['trend'] = Variable<String>(trend.value);
    }
    if (verdict.present) {
      map['verdict'] = Variable<String>(verdict.value);
    }
    if (verdictLabel.present) {
      map['verdict_label'] = Variable<String>(verdictLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SorenessChecksCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('onset: $onset, ')
          ..write('spread: $spread, ')
          ..write('trend: $trend, ')
          ..write('verdict: $verdict, ')
          ..write('verdictLabel: $verdictLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckinsTable extends Checkins with TableInfo<$CheckinsTable, Checkin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<String> loggedAt = GeneratedColumn<String>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mentalStateMeta = const VerificationMeta(
    'mentalState',
  );
  @override
  late final GeneratedColumn<String> mentalState = GeneratedColumn<String>(
    'mental_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyFeelingMeta = const VerificationMeta(
    'bodyFeeling',
  );
  @override
  late final GeneratedColumn<String> bodyFeeling = GeneratedColumn<String>(
    'body_feeling',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    loggedAt,
    mentalState,
    bodyFeeling,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checkins';
  @override
  VerificationContext validateIntegrity(
    Insertable<Checkin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('mental_state')) {
      context.handle(
        _mentalStateMeta,
        mentalState.isAcceptableOrUnknown(
          data['mental_state']!,
          _mentalStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mentalStateMeta);
    }
    if (data.containsKey('body_feeling')) {
      context.handle(
        _bodyFeelingMeta,
        bodyFeeling.isAcceptableOrUnknown(
          data['body_feeling']!,
          _bodyFeelingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bodyFeelingMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Checkin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Checkin(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logged_at'],
      )!,
      mentalState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mental_state'],
      )!,
      bodyFeeling: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_feeling'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
    );
  }

  @override
  $CheckinsTable createAlias(String alias) {
    return $CheckinsTable(attachedDatabase, alias);
  }
}

class Checkin extends DataClass implements Insertable<Checkin> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String date;
  final String loggedAt;
  final String mentalState;
  final String bodyFeeling;
  final String note;
  const Checkin({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.loggedAt,
    required this.mentalState,
    required this.bodyFeeling,
    required this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['logged_at'] = Variable<String>(loggedAt);
    map['mental_state'] = Variable<String>(mentalState);
    map['body_feeling'] = Variable<String>(bodyFeeling);
    map['note'] = Variable<String>(note);
    return map;
  }

  CheckinsCompanion toCompanion(bool nullToAbsent) {
    return CheckinsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      loggedAt: Value(loggedAt),
      mentalState: Value(mentalState),
      bodyFeeling: Value(bodyFeeling),
      note: Value(note),
    );
  }

  factory Checkin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Checkin(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      loggedAt: serializer.fromJson<String>(json['loggedAt']),
      mentalState: serializer.fromJson<String>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String>(json['bodyFeeling']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'loggedAt': serializer.toJson<String>(loggedAt),
      'mentalState': serializer.toJson<String>(mentalState),
      'bodyFeeling': serializer.toJson<String>(bodyFeeling),
      'note': serializer.toJson<String>(note),
    };
  }

  Checkin copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? loggedAt,
    String? mentalState,
    String? bodyFeeling,
    String? note,
  }) => Checkin(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    loggedAt: loggedAt ?? this.loggedAt,
    mentalState: mentalState ?? this.mentalState,
    bodyFeeling: bodyFeeling ?? this.bodyFeeling,
    note: note ?? this.note,
  );
  Checkin copyWithCompanion(CheckinsCompanion data) {
    return Checkin(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      mentalState: data.mentalState.present
          ? data.mentalState.value
          : this.mentalState,
      bodyFeeling: data.bodyFeeling.present
          ? data.bodyFeeling.value
          : this.bodyFeeling,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Checkin(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    loggedAt,
    mentalState,
    bodyFeeling,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Checkin &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.loggedAt == this.loggedAt &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling &&
          other.note == this.note);
}

class CheckinsCompanion extends UpdateCompanion<Checkin> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> loggedAt;
  final Value<String> mentalState;
  final Value<String> bodyFeeling;
  final Value<String> note;
  final Value<int> rowid;
  const CheckinsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckinsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String loggedAt,
    required String mentalState,
    required String bodyFeeling,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       loggedAt = Value(loggedAt),
       mentalState = Value(mentalState),
       bodyFeeling = Value(bodyFeeling);
  static Insertable<Checkin> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? loggedAt,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckinsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? loggedAt,
    Value<String>? mentalState,
    Value<String>? bodyFeeling,
    Value<String>? note,
    Value<int>? rowid,
  }) {
    return CheckinsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      loggedAt: loggedAt ?? this.loggedAt,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<String>(loggedAt.value);
    }
    if (mentalState.present) {
      map['mental_state'] = Variable<String>(mentalState.value);
    }
    if (bodyFeeling.present) {
      map['body_feeling'] = Variable<String>(bodyFeeling.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckinsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InjuriesTable extends Injuries with TableInfo<$InjuriesTable, Injury> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InjuriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateStartedMeta = const VerificationMeta(
    'dateStarted',
  );
  @override
  late final GeneratedColumn<String> dateStarted = GeneratedColumn<String>(
    'date_started',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zoneMeta = const VerificationMeta('zone');
  @override
  late final GeneratedColumn<String> zone = GeneratedColumn<String>(
    'zone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _resolvedAtMeta = const VerificationMeta(
    'resolvedAt',
  );
  @override
  late final GeneratedColumn<String> resolvedAt = GeneratedColumn<String>(
    'resolved_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stillPainfulMeta = const VerificationMeta(
    'stillPainful',
  );
  @override
  late final GeneratedColumn<bool> stillPainful = GeneratedColumn<bool>(
    'still_painful',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("still_painful" IN (0, 1))',
    ),
  );
  static const VerificationMeta _comparedToUsualMeta = const VerificationMeta(
    'comparedToUsual',
  );
  @override
  late final GeneratedColumn<String> comparedToUsual = GeneratedColumn<String>(
    'compared_to_usual',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    dateStarted,
    zone,
    kind,
    type,
    note,
    resolvedAt,
    stillPainful,
    comparedToUsual,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'injuries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Injury> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date_started')) {
      context.handle(
        _dateStartedMeta,
        dateStarted.isAcceptableOrUnknown(
          data['date_started']!,
          _dateStartedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateStartedMeta);
    }
    if (data.containsKey('zone')) {
      context.handle(
        _zoneMeta,
        zone.isAcceptableOrUnknown(data['zone']!, _zoneMeta),
      );
    } else if (isInserting) {
      context.missing(_zoneMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
        _resolvedAtMeta,
        resolvedAt.isAcceptableOrUnknown(data['resolved_at']!, _resolvedAtMeta),
      );
    }
    if (data.containsKey('still_painful')) {
      context.handle(
        _stillPainfulMeta,
        stillPainful.isAcceptableOrUnknown(
          data['still_painful']!,
          _stillPainfulMeta,
        ),
      );
    }
    if (data.containsKey('compared_to_usual')) {
      context.handle(
        _comparedToUsualMeta,
        comparedToUsual.isAcceptableOrUnknown(
          data['compared_to_usual']!,
          _comparedToUsualMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Injury map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Injury(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dateStarted: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_started'],
      )!,
      zone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zone'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      resolvedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolved_at'],
      ),
      stillPainful: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}still_painful'],
      ),
      comparedToUsual: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}compared_to_usual'],
      ),
    );
  }

  @override
  $InjuriesTable createAlias(String alias) {
    return $InjuriesTable(attachedDatabase, alias);
  }
}

class Injury extends DataClass implements Insertable<Injury> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String dateStarted;
  final String zone;
  final String kind;
  final String type;
  final String note;
  final String? resolvedAt;
  final bool? stillPainful;
  final String? comparedToUsual;
  const Injury({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.dateStarted,
    required this.zone,
    required this.kind,
    required this.type,
    required this.note,
    this.resolvedAt,
    this.stillPainful,
    this.comparedToUsual,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date_started'] = Variable<String>(dateStarted);
    map['zone'] = Variable<String>(zone);
    map['kind'] = Variable<String>(kind);
    map['type'] = Variable<String>(type);
    map['note'] = Variable<String>(note);
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<String>(resolvedAt);
    }
    if (!nullToAbsent || stillPainful != null) {
      map['still_painful'] = Variable<bool>(stillPainful);
    }
    if (!nullToAbsent || comparedToUsual != null) {
      map['compared_to_usual'] = Variable<String>(comparedToUsual);
    }
    return map;
  }

  InjuriesCompanion toCompanion(bool nullToAbsent) {
    return InjuriesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      dateStarted: Value(dateStarted),
      zone: Value(zone),
      kind: Value(kind),
      type: Value(type),
      note: Value(note),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      stillPainful: stillPainful == null && nullToAbsent
          ? const Value.absent()
          : Value(stillPainful),
      comparedToUsual: comparedToUsual == null && nullToAbsent
          ? const Value.absent()
          : Value(comparedToUsual),
    );
  }

  factory Injury.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Injury(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      dateStarted: serializer.fromJson<String>(json['dateStarted']),
      zone: serializer.fromJson<String>(json['zone']),
      kind: serializer.fromJson<String>(json['kind']),
      type: serializer.fromJson<String>(json['type']),
      note: serializer.fromJson<String>(json['note']),
      resolvedAt: serializer.fromJson<String?>(json['resolvedAt']),
      stillPainful: serializer.fromJson<bool?>(json['stillPainful']),
      comparedToUsual: serializer.fromJson<String?>(json['comparedToUsual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'dateStarted': serializer.toJson<String>(dateStarted),
      'zone': serializer.toJson<String>(zone),
      'kind': serializer.toJson<String>(kind),
      'type': serializer.toJson<String>(type),
      'note': serializer.toJson<String>(note),
      'resolvedAt': serializer.toJson<String?>(resolvedAt),
      'stillPainful': serializer.toJson<bool?>(stillPainful),
      'comparedToUsual': serializer.toJson<String?>(comparedToUsual),
    };
  }

  Injury copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? dateStarted,
    String? zone,
    String? kind,
    String? type,
    String? note,
    Value<String?> resolvedAt = const Value.absent(),
    Value<bool?> stillPainful = const Value.absent(),
    Value<String?> comparedToUsual = const Value.absent(),
  }) => Injury(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    dateStarted: dateStarted ?? this.dateStarted,
    zone: zone ?? this.zone,
    kind: kind ?? this.kind,
    type: type ?? this.type,
    note: note ?? this.note,
    resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
    stillPainful: stillPainful.present ? stillPainful.value : this.stillPainful,
    comparedToUsual: comparedToUsual.present
        ? comparedToUsual.value
        : this.comparedToUsual,
  );
  Injury copyWithCompanion(InjuriesCompanion data) {
    return Injury(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      dateStarted: data.dateStarted.present
          ? data.dateStarted.value
          : this.dateStarted,
      zone: data.zone.present ? data.zone.value : this.zone,
      kind: data.kind.present ? data.kind.value : this.kind,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      resolvedAt: data.resolvedAt.present
          ? data.resolvedAt.value
          : this.resolvedAt,
      stillPainful: data.stillPainful.present
          ? data.stillPainful.value
          : this.stillPainful,
      comparedToUsual: data.comparedToUsual.present
          ? data.comparedToUsual.value
          : this.comparedToUsual,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Injury(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('dateStarted: $dateStarted, ')
          ..write('zone: $zone, ')
          ..write('kind: $kind, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('stillPainful: $stillPainful, ')
          ..write('comparedToUsual: $comparedToUsual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    dateStarted,
    zone,
    kind,
    type,
    note,
    resolvedAt,
    stillPainful,
    comparedToUsual,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Injury &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.dateStarted == this.dateStarted &&
          other.zone == this.zone &&
          other.kind == this.kind &&
          other.type == this.type &&
          other.note == this.note &&
          other.resolvedAt == this.resolvedAt &&
          other.stillPainful == this.stillPainful &&
          other.comparedToUsual == this.comparedToUsual);
}

class InjuriesCompanion extends UpdateCompanion<Injury> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> dateStarted;
  final Value<String> zone;
  final Value<String> kind;
  final Value<String> type;
  final Value<String> note;
  final Value<String?> resolvedAt;
  final Value<bool?> stillPainful;
  final Value<String?> comparedToUsual;
  final Value<int> rowid;
  const InjuriesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.dateStarted = const Value.absent(),
    this.zone = const Value.absent(),
    this.kind = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.stillPainful = const Value.absent(),
    this.comparedToUsual = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InjuriesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String dateStarted,
    required String zone,
    required String kind,
    required String type,
    this.note = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.stillPainful = const Value.absent(),
    this.comparedToUsual = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       dateStarted = Value(dateStarted),
       zone = Value(zone),
       kind = Value(kind),
       type = Value(type);
  static Insertable<Injury> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? dateStarted,
    Expression<String>? zone,
    Expression<String>? kind,
    Expression<String>? type,
    Expression<String>? note,
    Expression<String>? resolvedAt,
    Expression<bool>? stillPainful,
    Expression<String>? comparedToUsual,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (dateStarted != null) 'date_started': dateStarted,
      if (zone != null) 'zone': zone,
      if (kind != null) 'kind': kind,
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (stillPainful != null) 'still_painful': stillPainful,
      if (comparedToUsual != null) 'compared_to_usual': comparedToUsual,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InjuriesCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? dateStarted,
    Value<String>? zone,
    Value<String>? kind,
    Value<String>? type,
    Value<String>? note,
    Value<String?>? resolvedAt,
    Value<bool?>? stillPainful,
    Value<String?>? comparedToUsual,
    Value<int>? rowid,
  }) {
    return InjuriesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      dateStarted: dateStarted ?? this.dateStarted,
      zone: zone ?? this.zone,
      kind: kind ?? this.kind,
      type: type ?? this.type,
      note: note ?? this.note,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      stillPainful: stillPainful ?? this.stillPainful,
      comparedToUsual: comparedToUsual ?? this.comparedToUsual,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dateStarted.present) {
      map['date_started'] = Variable<String>(dateStarted.value);
    }
    if (zone.present) {
      map['zone'] = Variable<String>(zone.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<String>(resolvedAt.value);
    }
    if (stillPainful.present) {
      map['still_painful'] = Variable<bool>(stillPainful.value);
    }
    if (comparedToUsual.present) {
      map['compared_to_usual'] = Variable<String>(comparedToUsual.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InjuriesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('dateStarted: $dateStarted, ')
          ..write('zone: $zone, ')
          ..write('kind: $kind, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('stillPainful: $stillPainful, ')
          ..write('comparedToUsual: $comparedToUsual, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingPlansTable extends TrainingPlans
    with TableInfo<$TrainingPlansTable, TrainingPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<String> startDate = GeneratedColumn<String>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weeksMeta = const VerificationMeta('weeks');
  @override
  late final GeneratedColumn<int> weeks = GeneratedColumn<int>(
    'weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(12),
  );
  static const VerificationMeta _weeklyCeilingMinMeta = const VerificationMeta(
    'weeklyCeilingMin',
  );
  @override
  late final GeneratedColumn<int> weeklyCeilingMin = GeneratedColumn<int>(
    'weekly_ceiling_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _floorNoteMeta = const VerificationMeta(
    'floorNote',
  );
  @override
  late final GeneratedColumn<String> floorNote = GeneratedColumn<String>(
    'floor_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPhaseIdMeta = const VerificationMeta(
    'currentPhaseId',
  );
  @override
  late final GeneratedColumn<String> currentPhaseId = GeneratedColumn<String>(
    'current_phase_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _testWeeksMeta = const VerificationMeta(
    'testWeeks',
  );
  @override
  late final GeneratedColumn<String> testWeeks = GeneratedColumn<String>(
    'test_weeks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    name,
    startDate,
    weeks,
    weeklyCeilingMin,
    floorNote,
    currentPhaseId,
    testWeeks,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('weeks')) {
      context.handle(
        _weeksMeta,
        weeks.isAcceptableOrUnknown(data['weeks']!, _weeksMeta),
      );
    }
    if (data.containsKey('weekly_ceiling_min')) {
      context.handle(
        _weeklyCeilingMinMeta,
        weeklyCeilingMin.isAcceptableOrUnknown(
          data['weekly_ceiling_min']!,
          _weeklyCeilingMinMeta,
        ),
      );
    }
    if (data.containsKey('floor_note')) {
      context.handle(
        _floorNoteMeta,
        floorNote.isAcceptableOrUnknown(data['floor_note']!, _floorNoteMeta),
      );
    }
    if (data.containsKey('current_phase_id')) {
      context.handle(
        _currentPhaseIdMeta,
        currentPhaseId.isAcceptableOrUnknown(
          data['current_phase_id']!,
          _currentPhaseIdMeta,
        ),
      );
    }
    if (data.containsKey('test_weeks')) {
      context.handle(
        _testWeeksMeta,
        testWeeks.isAcceptableOrUnknown(data['test_weeks']!, _testWeeksMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingPlan(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_date'],
      )!,
      weeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weeks'],
      )!,
      weeklyCeilingMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekly_ceiling_min'],
      ),
      floorNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}floor_note'],
      ),
      currentPhaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_phase_id'],
      ),
      testWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_weeks'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $TrainingPlansTable createAlias(String alias) {
    return $TrainingPlansTable(attachedDatabase, alias);
  }
}

class TrainingPlan extends DataClass implements Insertable<TrainingPlan> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String name;

  /// yyyy-MM-dd; week 1 is the week this date falls in.
  final String startDate;
  final int weeks;

  /// Minutes per week (all logged movement counts toward it), set by the
  /// person. Null = no ceiling shown.
  final int? weeklyCeilingMin;

  /// The daily floor, in the person's words (e.g. "10 calf raises…").
  final String? floorNote;
  final String? currentPhaseId;

  /// Plan weeks to retake the baseline tests, comma-separated (e.g. "1,6,12").
  final String? testWeeks;
  final bool isActive;
  const TrainingPlan({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.startDate,
    required this.weeks,
    this.weeklyCeilingMin,
    this.floorNote,
    this.currentPhaseId,
    this.testWeeks,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_date'] = Variable<String>(startDate);
    map['weeks'] = Variable<int>(weeks);
    if (!nullToAbsent || weeklyCeilingMin != null) {
      map['weekly_ceiling_min'] = Variable<int>(weeklyCeilingMin);
    }
    if (!nullToAbsent || floorNote != null) {
      map['floor_note'] = Variable<String>(floorNote);
    }
    if (!nullToAbsent || currentPhaseId != null) {
      map['current_phase_id'] = Variable<String>(currentPhaseId);
    }
    if (!nullToAbsent || testWeeks != null) {
      map['test_weeks'] = Variable<String>(testWeeks);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  TrainingPlansCompanion toCompanion(bool nullToAbsent) {
    return TrainingPlansCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      startDate: Value(startDate),
      weeks: Value(weeks),
      weeklyCeilingMin: weeklyCeilingMin == null && nullToAbsent
          ? const Value.absent()
          : Value(weeklyCeilingMin),
      floorNote: floorNote == null && nullToAbsent
          ? const Value.absent()
          : Value(floorNote),
      currentPhaseId: currentPhaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentPhaseId),
      testWeeks: testWeeks == null && nullToAbsent
          ? const Value.absent()
          : Value(testWeeks),
      isActive: Value(isActive),
    );
  }

  factory TrainingPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingPlan(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<String>(json['startDate']),
      weeks: serializer.fromJson<int>(json['weeks']),
      weeklyCeilingMin: serializer.fromJson<int?>(json['weeklyCeilingMin']),
      floorNote: serializer.fromJson<String?>(json['floorNote']),
      currentPhaseId: serializer.fromJson<String?>(json['currentPhaseId']),
      testWeeks: serializer.fromJson<String?>(json['testWeeks']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<String>(startDate),
      'weeks': serializer.toJson<int>(weeks),
      'weeklyCeilingMin': serializer.toJson<int?>(weeklyCeilingMin),
      'floorNote': serializer.toJson<String?>(floorNote),
      'currentPhaseId': serializer.toJson<String?>(currentPhaseId),
      'testWeeks': serializer.toJson<String?>(testWeeks),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  TrainingPlan copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? startDate,
    int? weeks,
    Value<int?> weeklyCeilingMin = const Value.absent(),
    Value<String?> floorNote = const Value.absent(),
    Value<String?> currentPhaseId = const Value.absent(),
    Value<String?> testWeeks = const Value.absent(),
    bool? isActive,
  }) => TrainingPlan(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    startDate: startDate ?? this.startDate,
    weeks: weeks ?? this.weeks,
    weeklyCeilingMin: weeklyCeilingMin.present
        ? weeklyCeilingMin.value
        : this.weeklyCeilingMin,
    floorNote: floorNote.present ? floorNote.value : this.floorNote,
    currentPhaseId: currentPhaseId.present
        ? currentPhaseId.value
        : this.currentPhaseId,
    testWeeks: testWeeks.present ? testWeeks.value : this.testWeeks,
    isActive: isActive ?? this.isActive,
  );
  TrainingPlan copyWithCompanion(TrainingPlansCompanion data) {
    return TrainingPlan(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      weeks: data.weeks.present ? data.weeks.value : this.weeks,
      weeklyCeilingMin: data.weeklyCeilingMin.present
          ? data.weeklyCeilingMin.value
          : this.weeklyCeilingMin,
      floorNote: data.floorNote.present ? data.floorNote.value : this.floorNote,
      currentPhaseId: data.currentPhaseId.present
          ? data.currentPhaseId.value
          : this.currentPhaseId,
      testWeeks: data.testWeeks.present ? data.testWeeks.value : this.testWeeks,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingPlan(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('weeklyCeilingMin: $weeklyCeilingMin, ')
          ..write('floorNote: $floorNote, ')
          ..write('currentPhaseId: $currentPhaseId, ')
          ..write('testWeeks: $testWeeks, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    name,
    startDate,
    weeks,
    weeklyCeilingMin,
    floorNote,
    currentPhaseId,
    testWeeks,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingPlan &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.weeks == this.weeks &&
          other.weeklyCeilingMin == this.weeklyCeilingMin &&
          other.floorNote == this.floorNote &&
          other.currentPhaseId == this.currentPhaseId &&
          other.testWeeks == this.testWeeks &&
          other.isActive == this.isActive);
}

class TrainingPlansCompanion extends UpdateCompanion<TrainingPlan> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> startDate;
  final Value<int> weeks;
  final Value<int?> weeklyCeilingMin;
  final Value<String?> floorNote;
  final Value<String?> currentPhaseId;
  final Value<String?> testWeeks;
  final Value<bool> isActive;
  final Value<int> rowid;
  const TrainingPlansCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.weeks = const Value.absent(),
    this.weeklyCeilingMin = const Value.absent(),
    this.floorNote = const Value.absent(),
    this.currentPhaseId = const Value.absent(),
    this.testWeeks = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingPlansCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String startDate,
    this.weeks = const Value.absent(),
    this.weeklyCeilingMin = const Value.absent(),
    this.floorNote = const Value.absent(),
    this.currentPhaseId = const Value.absent(),
    this.testWeeks = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       startDate = Value(startDate);
  static Insertable<TrainingPlan> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? startDate,
    Expression<int>? weeks,
    Expression<int>? weeklyCeilingMin,
    Expression<String>? floorNote,
    Expression<String>? currentPhaseId,
    Expression<String>? testWeeks,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (weeks != null) 'weeks': weeks,
      if (weeklyCeilingMin != null) 'weekly_ceiling_min': weeklyCeilingMin,
      if (floorNote != null) 'floor_note': floorNote,
      if (currentPhaseId != null) 'current_phase_id': currentPhaseId,
      if (testWeeks != null) 'test_weeks': testWeeks,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingPlansCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? startDate,
    Value<int>? weeks,
    Value<int?>? weeklyCeilingMin,
    Value<String?>? floorNote,
    Value<String?>? currentPhaseId,
    Value<String?>? testWeeks,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return TrainingPlansCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      weeks: weeks ?? this.weeks,
      weeklyCeilingMin: weeklyCeilingMin ?? this.weeklyCeilingMin,
      floorNote: floorNote ?? this.floorNote,
      currentPhaseId: currentPhaseId ?? this.currentPhaseId,
      testWeeks: testWeeks ?? this.testWeeks,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<String>(startDate.value);
    }
    if (weeks.present) {
      map['weeks'] = Variable<int>(weeks.value);
    }
    if (weeklyCeilingMin.present) {
      map['weekly_ceiling_min'] = Variable<int>(weeklyCeilingMin.value);
    }
    if (floorNote.present) {
      map['floor_note'] = Variable<String>(floorNote.value);
    }
    if (currentPhaseId.present) {
      map['current_phase_id'] = Variable<String>(currentPhaseId.value);
    }
    if (testWeeks.present) {
      map['test_weeks'] = Variable<String>(testWeeks.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingPlansCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('weeks: $weeks, ')
          ..write('weeklyCeilingMin: $weeklyCeilingMin, ')
          ..write('floorNote: $floorNote, ')
          ..write('currentPhaseId: $currentPhaseId, ')
          ..write('testWeeks: $testWeeks, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanPhasesTable extends PlanPhases
    with TableInfo<$PlanPhasesTable, PlanPhase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanPhasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _effortMeta = const VerificationMeta('effort');
  @override
  late final GeneratedColumn<String> effort = GeneratedColumn<String>(
    'effort',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cardioMeta = const VerificationMeta('cardio');
  @override
  late final GeneratedColumn<String> cardio = GeneratedColumn<String>(
    'cardio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gateMeta = const VerificationMeta('gate');
  @override
  late final GeneratedColumn<String> gate = GeneratedColumn<String>(
    'gate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    planId,
    position,
    name,
    goal,
    effort,
    cardio,
    gate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_phases';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanPhase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    }
    if (data.containsKey('effort')) {
      context.handle(
        _effortMeta,
        effort.isAcceptableOrUnknown(data['effort']!, _effortMeta),
      );
    }
    if (data.containsKey('cardio')) {
      context.handle(
        _cardioMeta,
        cardio.isAcceptableOrUnknown(data['cardio']!, _cardioMeta),
      );
    }
    if (data.containsKey('gate')) {
      context.handle(
        _gateMeta,
        gate.isAcceptableOrUnknown(data['gate']!, _gateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanPhase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanPhase(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      ),
      effort: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effort'],
      ),
      cardio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cardio'],
      ),
      gate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gate'],
      ),
    );
  }

  @override
  $PlanPhasesTable createAlias(String alias) {
    return $PlanPhasesTable(attachedDatabase, alias);
  }
}

class PlanPhase extends DataClass implements Insertable<PlanPhase> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String planId;
  final int position;
  final String name;
  final String? goal;
  final String? effort;
  final String? cardio;

  /// What has to be true before moving on, in the person's words.
  final String? gate;
  const PlanPhase({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.goal,
    this.effort,
    this.cardio,
    this.gate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || goal != null) {
      map['goal'] = Variable<String>(goal);
    }
    if (!nullToAbsent || effort != null) {
      map['effort'] = Variable<String>(effort);
    }
    if (!nullToAbsent || cardio != null) {
      map['cardio'] = Variable<String>(cardio);
    }
    if (!nullToAbsent || gate != null) {
      map['gate'] = Variable<String>(gate);
    }
    return map;
  }

  PlanPhasesCompanion toCompanion(bool nullToAbsent) {
    return PlanPhasesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      planId: Value(planId),
      position: Value(position),
      name: Value(name),
      goal: goal == null && nullToAbsent ? const Value.absent() : Value(goal),
      effort: effort == null && nullToAbsent
          ? const Value.absent()
          : Value(effort),
      cardio: cardio == null && nullToAbsent
          ? const Value.absent()
          : Value(cardio),
      gate: gate == null && nullToAbsent ? const Value.absent() : Value(gate),
    );
  }

  factory PlanPhase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanPhase(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      goal: serializer.fromJson<String?>(json['goal']),
      effort: serializer.fromJson<String?>(json['effort']),
      cardio: serializer.fromJson<String?>(json['cardio']),
      gate: serializer.fromJson<String?>(json['gate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'goal': serializer.toJson<String?>(goal),
      'effort': serializer.toJson<String?>(effort),
      'cardio': serializer.toJson<String?>(cardio),
      'gate': serializer.toJson<String?>(gate),
    };
  }

  PlanPhase copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? planId,
    int? position,
    String? name,
    Value<String?> goal = const Value.absent(),
    Value<String?> effort = const Value.absent(),
    Value<String?> cardio = const Value.absent(),
    Value<String?> gate = const Value.absent(),
  }) => PlanPhase(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    position: position ?? this.position,
    name: name ?? this.name,
    goal: goal.present ? goal.value : this.goal,
    effort: effort.present ? effort.value : this.effort,
    cardio: cardio.present ? cardio.value : this.cardio,
    gate: gate.present ? gate.value : this.gate,
  );
  PlanPhase copyWithCompanion(PlanPhasesCompanion data) {
    return PlanPhase(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      goal: data.goal.present ? data.goal.value : this.goal,
      effort: data.effort.present ? data.effort.value : this.effort,
      cardio: data.cardio.present ? data.cardio.value : this.cardio,
      gate: data.gate.present ? data.gate.value : this.gate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanPhase(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('effort: $effort, ')
          ..write('cardio: $cardio, ')
          ..write('gate: $gate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    planId,
    position,
    name,
    goal,
    effort,
    cardio,
    gate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanPhase &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.position == this.position &&
          other.name == this.name &&
          other.goal == this.goal &&
          other.effort == this.effort &&
          other.cardio == this.cardio &&
          other.gate == this.gate);
}

class PlanPhasesCompanion extends UpdateCompanion<PlanPhase> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<int> position;
  final Value<String> name;
  final Value<String?> goal;
  final Value<String?> effort;
  final Value<String?> cardio;
  final Value<String?> gate;
  final Value<int> rowid;
  const PlanPhasesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.goal = const Value.absent(),
    this.effort = const Value.absent(),
    this.cardio = const Value.absent(),
    this.gate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanPhasesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String planId,
    required int position,
    required String name,
    this.goal = const Value.absent(),
    this.effort = const Value.absent(),
    this.cardio = const Value.absent(),
    this.gate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       planId = Value(planId),
       position = Value(position),
       name = Value(name);
  static Insertable<PlanPhase> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? goal,
    Expression<String>? effort,
    Expression<String>? cardio,
    Expression<String>? gate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (goal != null) 'goal': goal,
      if (effort != null) 'effort': effort,
      if (cardio != null) 'cardio': cardio,
      if (gate != null) 'gate': gate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanPhasesCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<int>? position,
    Value<String>? name,
    Value<String?>? goal,
    Value<String?>? effort,
    Value<String?>? cardio,
    Value<String?>? gate,
    Value<int>? rowid,
  }) {
    return PlanPhasesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      position: position ?? this.position,
      name: name ?? this.name,
      goal: goal ?? this.goal,
      effort: effort ?? this.effort,
      cardio: cardio ?? this.cardio,
      gate: gate ?? this.gate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (effort.present) {
      map['effort'] = Variable<String>(effort.value);
    }
    if (cardio.present) {
      map['cardio'] = Variable<String>(cardio.value);
    }
    if (gate.present) {
      map['gate'] = Variable<String>(gate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanPhasesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('goal: $goal, ')
          ..write('effort: $effort, ')
          ..write('cardio: $cardio, ')
          ..write('gate: $gate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanSessionsTable extends PlanSessions
    with TableInfo<$PlanSessionsTable, PlanSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lowDayNoteMeta = const VerificationMeta(
    'lowDayNote',
  );
  @override
  late final GeneratedColumn<String> lowDayNote = GeneratedColumn<String>(
    'low_day_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCardioMeta = const VerificationMeta(
    'isCardio',
  );
  @override
  late final GeneratedColumn<bool> isCardio = GeneratedColumn<bool>(
    'is_cardio',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cardio" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    planId,
    position,
    name,
    weekday,
    durationMin,
    lowDayNote,
    isCardio,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    }
    if (data.containsKey('low_day_note')) {
      context.handle(
        _lowDayNoteMeta,
        lowDayNote.isAcceptableOrUnknown(
          data['low_day_note']!,
          _lowDayNoteMeta,
        ),
      );
    }
    if (data.containsKey('is_cardio')) {
      context.handle(
        _isCardioMeta,
        isCardio.isAcceptableOrUnknown(data['is_cardio']!, _isCardioMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanSession(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      ),
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      ),
      lowDayNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}low_day_note'],
      ),
      isCardio: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_cardio'],
      )!,
    );
  }

  @override
  $PlanSessionsTable createAlias(String alias) {
    return $PlanSessionsTable(attachedDatabase, alias);
  }
}

class PlanSession extends DataClass implements Insertable<PlanSession> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String planId;
  final int position;
  final String name;

  /// 1 = Monday … 7 = Sunday (DateTime.weekday). Null = any day.
  final int? weekday;
  final int? durationMin;

  /// What this session shrinks to on a low day, in the person's words.
  final String? lowDayNote;

  /// Cardio sessions also save an Activity row, so METs, PEM charts and
  /// activity challenges see them without logging twice.
  final bool isCardio;
  const PlanSession({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.weekday,
    this.durationMin,
    this.lowDayNote,
    required this.isCardio,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || weekday != null) {
      map['weekday'] = Variable<int>(weekday);
    }
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    if (!nullToAbsent || lowDayNote != null) {
      map['low_day_note'] = Variable<String>(lowDayNote);
    }
    map['is_cardio'] = Variable<bool>(isCardio);
    return map;
  }

  PlanSessionsCompanion toCompanion(bool nullToAbsent) {
    return PlanSessionsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      planId: Value(planId),
      position: Value(position),
      name: Value(name),
      weekday: weekday == null && nullToAbsent
          ? const Value.absent()
          : Value(weekday),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      lowDayNote: lowDayNote == null && nullToAbsent
          ? const Value.absent()
          : Value(lowDayNote),
      isCardio: Value(isCardio),
    );
  }

  factory PlanSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanSession(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      weekday: serializer.fromJson<int?>(json['weekday']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
      lowDayNote: serializer.fromJson<String?>(json['lowDayNote']),
      isCardio: serializer.fromJson<bool>(json['isCardio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'weekday': serializer.toJson<int?>(weekday),
      'durationMin': serializer.toJson<int?>(durationMin),
      'lowDayNote': serializer.toJson<String?>(lowDayNote),
      'isCardio': serializer.toJson<bool>(isCardio),
    };
  }

  PlanSession copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? planId,
    int? position,
    String? name,
    Value<int?> weekday = const Value.absent(),
    Value<int?> durationMin = const Value.absent(),
    Value<String?> lowDayNote = const Value.absent(),
    bool? isCardio,
  }) => PlanSession(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    position: position ?? this.position,
    name: name ?? this.name,
    weekday: weekday.present ? weekday.value : this.weekday,
    durationMin: durationMin.present ? durationMin.value : this.durationMin,
    lowDayNote: lowDayNote.present ? lowDayNote.value : this.lowDayNote,
    isCardio: isCardio ?? this.isCardio,
  );
  PlanSession copyWithCompanion(PlanSessionsCompanion data) {
    return PlanSession(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      lowDayNote: data.lowDayNote.present
          ? data.lowDayNote.value
          : this.lowDayNote,
      isCardio: data.isCardio.present ? data.isCardio.value : this.isCardio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanSession(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('weekday: $weekday, ')
          ..write('durationMin: $durationMin, ')
          ..write('lowDayNote: $lowDayNote, ')
          ..write('isCardio: $isCardio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    planId,
    position,
    name,
    weekday,
    durationMin,
    lowDayNote,
    isCardio,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanSession &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.position == this.position &&
          other.name == this.name &&
          other.weekday == this.weekday &&
          other.durationMin == this.durationMin &&
          other.lowDayNote == this.lowDayNote &&
          other.isCardio == this.isCardio);
}

class PlanSessionsCompanion extends UpdateCompanion<PlanSession> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<int> position;
  final Value<String> name;
  final Value<int?> weekday;
  final Value<int?> durationMin;
  final Value<String?> lowDayNote;
  final Value<bool> isCardio;
  final Value<int> rowid;
  const PlanSessionsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.weekday = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.lowDayNote = const Value.absent(),
    this.isCardio = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanSessionsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String planId,
    required int position,
    required String name,
    this.weekday = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.lowDayNote = const Value.absent(),
    this.isCardio = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       planId = Value(planId),
       position = Value(position),
       name = Value(name);
  static Insertable<PlanSession> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<int>? weekday,
    Expression<int>? durationMin,
    Expression<String>? lowDayNote,
    Expression<bool>? isCardio,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (weekday != null) 'weekday': weekday,
      if (durationMin != null) 'duration_min': durationMin,
      if (lowDayNote != null) 'low_day_note': lowDayNote,
      if (isCardio != null) 'is_cardio': isCardio,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanSessionsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<int>? position,
    Value<String>? name,
    Value<int?>? weekday,
    Value<int?>? durationMin,
    Value<String?>? lowDayNote,
    Value<bool>? isCardio,
    Value<int>? rowid,
  }) {
    return PlanSessionsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      position: position ?? this.position,
      name: name ?? this.name,
      weekday: weekday ?? this.weekday,
      durationMin: durationMin ?? this.durationMin,
      lowDayNote: lowDayNote ?? this.lowDayNote,
      isCardio: isCardio ?? this.isCardio,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (lowDayNote.present) {
      map['low_day_note'] = Variable<String>(lowDayNote.value);
    }
    if (isCardio.present) {
      map['is_cardio'] = Variable<bool>(isCardio.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanSessionsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('weekday: $weekday, ')
          ..write('durationMin: $durationMin, ')
          ..write('lowDayNote: $lowDayNote, ')
          ..write('isCardio: $isCardio, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanExercisesTable extends PlanExercises
    with TableInfo<$PlanExercisesTable, PlanExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cueMeta = const VerificationMeta('cue');
  @override
  late final GeneratedColumn<String> cue = GeneratedColumn<String>(
    'cue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentStepIdMeta = const VerificationMeta(
    'currentStepId',
  );
  @override
  late final GeneratedColumn<String> currentStepId = GeneratedColumn<String>(
    'current_step_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepChangedOnMeta = const VerificationMeta(
    'stepChangedOn',
  );
  @override
  late final GeneratedColumn<String> stepChangedOn = GeneratedColumn<String>(
    'step_changed_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    sessionId,
    position,
    name,
    cue,
    currentStepId,
    stepChangedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cue')) {
      context.handle(
        _cueMeta,
        cue.isAcceptableOrUnknown(data['cue']!, _cueMeta),
      );
    }
    if (data.containsKey('current_step_id')) {
      context.handle(
        _currentStepIdMeta,
        currentStepId.isAcceptableOrUnknown(
          data['current_step_id']!,
          _currentStepIdMeta,
        ),
      );
    }
    if (data.containsKey('step_changed_on')) {
      context.handle(
        _stepChangedOnMeta,
        stepChangedOn.isAcceptableOrUnknown(
          data['step_changed_on']!,
          _stepChangedOnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanExercise(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cue'],
      ),
      currentStepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_step_id'],
      ),
      stepChangedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_changed_on'],
      ),
    );
  }

  @override
  $PlanExercisesTable createAlias(String alias) {
    return $PlanExercisesTable(attachedDatabase, alias);
  }
}

class PlanExercise extends DataClass implements Insertable<PlanExercise> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String sessionId;
  final int position;
  final String name;
  final String? cue;
  final String? currentStepId;

  /// yyyy-MM-dd of the last step change — the plan allows one change a week.
  final String? stepChangedOn;
  const PlanExercise({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.sessionId,
    required this.position,
    required this.name,
    this.cue,
    this.currentStepId,
    this.stepChangedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || cue != null) {
      map['cue'] = Variable<String>(cue);
    }
    if (!nullToAbsent || currentStepId != null) {
      map['current_step_id'] = Variable<String>(currentStepId);
    }
    if (!nullToAbsent || stepChangedOn != null) {
      map['step_changed_on'] = Variable<String>(stepChangedOn);
    }
    return map;
  }

  PlanExercisesCompanion toCompanion(bool nullToAbsent) {
    return PlanExercisesCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      sessionId: Value(sessionId),
      position: Value(position),
      name: Value(name),
      cue: cue == null && nullToAbsent ? const Value.absent() : Value(cue),
      currentStepId: currentStepId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentStepId),
      stepChangedOn: stepChangedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(stepChangedOn),
    );
  }

  factory PlanExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanExercise(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      cue: serializer.fromJson<String?>(json['cue']),
      currentStepId: serializer.fromJson<String?>(json['currentStepId']),
      stepChangedOn: serializer.fromJson<String?>(json['stepChangedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'cue': serializer.toJson<String?>(cue),
      'currentStepId': serializer.toJson<String?>(currentStepId),
      'stepChangedOn': serializer.toJson<String?>(stepChangedOn),
    };
  }

  PlanExercise copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? sessionId,
    int? position,
    String? name,
    Value<String?> cue = const Value.absent(),
    Value<String?> currentStepId = const Value.absent(),
    Value<String?> stepChangedOn = const Value.absent(),
  }) => PlanExercise(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    position: position ?? this.position,
    name: name ?? this.name,
    cue: cue.present ? cue.value : this.cue,
    currentStepId: currentStepId.present
        ? currentStepId.value
        : this.currentStepId,
    stepChangedOn: stepChangedOn.present
        ? stepChangedOn.value
        : this.stepChangedOn,
  );
  PlanExercise copyWithCompanion(PlanExercisesCompanion data) {
    return PlanExercise(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      cue: data.cue.present ? data.cue.value : this.cue,
      currentStepId: data.currentStepId.present
          ? data.currentStepId.value
          : this.currentStepId,
      stepChangedOn: data.stepChangedOn.present
          ? data.stepChangedOn.value
          : this.stepChangedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanExercise(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('cue: $cue, ')
          ..write('currentStepId: $currentStepId, ')
          ..write('stepChangedOn: $stepChangedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    sessionId,
    position,
    name,
    cue,
    currentStepId,
    stepChangedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanExercise &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.position == this.position &&
          other.name == this.name &&
          other.cue == this.cue &&
          other.currentStepId == this.currentStepId &&
          other.stepChangedOn == this.stepChangedOn);
}

class PlanExercisesCompanion extends UpdateCompanion<PlanExercise> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> sessionId;
  final Value<int> position;
  final Value<String> name;
  final Value<String?> cue;
  final Value<String?> currentStepId;
  final Value<String?> stepChangedOn;
  final Value<int> rowid;
  const PlanExercisesCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.cue = const Value.absent(),
    this.currentStepId = const Value.absent(),
    this.stepChangedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanExercisesCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String sessionId,
    required int position,
    required String name,
    this.cue = const Value.absent(),
    this.currentStepId = const Value.absent(),
    this.stepChangedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       sessionId = Value(sessionId),
       position = Value(position),
       name = Value(name);
  static Insertable<PlanExercise> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? cue,
    Expression<String>? currentStepId,
    Expression<String>? stepChangedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (cue != null) 'cue': cue,
      if (currentStepId != null) 'current_step_id': currentStepId,
      if (stepChangedOn != null) 'step_changed_on': stepChangedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanExercisesCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? sessionId,
    Value<int>? position,
    Value<String>? name,
    Value<String?>? cue,
    Value<String?>? currentStepId,
    Value<String?>? stepChangedOn,
    Value<int>? rowid,
  }) {
    return PlanExercisesCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      position: position ?? this.position,
      name: name ?? this.name,
      cue: cue ?? this.cue,
      currentStepId: currentStepId ?? this.currentStepId,
      stepChangedOn: stepChangedOn ?? this.stepChangedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cue.present) {
      map['cue'] = Variable<String>(cue.value);
    }
    if (currentStepId.present) {
      map['current_step_id'] = Variable<String>(currentStepId.value);
    }
    if (stepChangedOn.present) {
      map['step_changed_on'] = Variable<String>(stepChangedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanExercisesCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('cue: $cue, ')
          ..write('currentStepId: $currentStepId, ')
          ..write('stepChangedOn: $stepChangedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanStepsTable extends PlanSteps
    with TableInfo<$PlanStepsTable, PlanStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<String> dose = GeneratedColumn<String>(
    'dose',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('reps'),
  );
  static const VerificationMeta _needsClearanceMeta = const VerificationMeta(
    'needsClearance',
  );
  @override
  late final GeneratedColumn<bool> needsClearance = GeneratedColumn<bool>(
    'needs_clearance',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_clearance" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _clearedOnMeta = const VerificationMeta(
    'clearedOn',
  );
  @override
  late final GeneratedColumn<String> clearedOn = GeneratedColumn<String>(
    'cleared_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    exerciseId,
    position,
    name,
    dose,
    unit,
    needsClearance,
    clearedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('needs_clearance')) {
      context.handle(
        _needsClearanceMeta,
        needsClearance.isAcceptableOrUnknown(
          data['needs_clearance']!,
          _needsClearanceMeta,
        ),
      );
    }
    if (data.containsKey('cleared_on')) {
      context.handle(
        _clearedOnMeta,
        clearedOn.isAcceptableOrUnknown(data['cleared_on']!, _clearedOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanStep(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose'],
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      needsClearance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_clearance'],
      )!,
      clearedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cleared_on'],
      ),
    );
  }

  @override
  $PlanStepsTable createAlias(String alias) {
    return $PlanStepsTable(attachedDatabase, alias);
  }
}

class PlanStep extends DataClass implements Insertable<PlanStep> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String exerciseId;
  final int position;
  final String name;

  /// Free text, e.g. "1→3 × 4–6".
  final String? dose;

  /// `reps` or `seconds` — see SetUnit.
  final String unit;

  /// Waits for a physio (or other clinician) sign-off before it unlocks.
  final bool needsClearance;
  final String? clearedOn;
  const PlanStep({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.exerciseId,
    required this.position,
    required this.name,
    this.dose,
    required this.unit,
    required this.needsClearance,
    this.clearedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dose != null) {
      map['dose'] = Variable<String>(dose);
    }
    map['unit'] = Variable<String>(unit);
    map['needs_clearance'] = Variable<bool>(needsClearance);
    if (!nullToAbsent || clearedOn != null) {
      map['cleared_on'] = Variable<String>(clearedOn);
    }
    return map;
  }

  PlanStepsCompanion toCompanion(bool nullToAbsent) {
    return PlanStepsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      exerciseId: Value(exerciseId),
      position: Value(position),
      name: Value(name),
      dose: dose == null && nullToAbsent ? const Value.absent() : Value(dose),
      unit: Value(unit),
      needsClearance: Value(needsClearance),
      clearedOn: clearedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(clearedOn),
    );
  }

  factory PlanStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanStep(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      dose: serializer.fromJson<String?>(json['dose']),
      unit: serializer.fromJson<String>(json['unit']),
      needsClearance: serializer.fromJson<bool>(json['needsClearance']),
      clearedOn: serializer.fromJson<String?>(json['clearedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'dose': serializer.toJson<String?>(dose),
      'unit': serializer.toJson<String>(unit),
      'needsClearance': serializer.toJson<bool>(needsClearance),
      'clearedOn': serializer.toJson<String?>(clearedOn),
    };
  }

  PlanStep copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? exerciseId,
    int? position,
    String? name,
    Value<String?> dose = const Value.absent(),
    String? unit,
    bool? needsClearance,
    Value<String?> clearedOn = const Value.absent(),
  }) => PlanStep(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    name: name ?? this.name,
    dose: dose.present ? dose.value : this.dose,
    unit: unit ?? this.unit,
    needsClearance: needsClearance ?? this.needsClearance,
    clearedOn: clearedOn.present ? clearedOn.value : this.clearedOn,
  );
  PlanStep copyWithCompanion(PlanStepsCompanion data) {
    return PlanStep(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      dose: data.dose.present ? data.dose.value : this.dose,
      unit: data.unit.present ? data.unit.value : this.unit,
      needsClearance: data.needsClearance.present
          ? data.needsClearance.value
          : this.needsClearance,
      clearedOn: data.clearedOn.present ? data.clearedOn.value : this.clearedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanStep(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('unit: $unit, ')
          ..write('needsClearance: $needsClearance, ')
          ..write('clearedOn: $clearedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    exerciseId,
    position,
    name,
    dose,
    unit,
    needsClearance,
    clearedOn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanStep &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.name == this.name &&
          other.dose == this.dose &&
          other.unit == this.unit &&
          other.needsClearance == this.needsClearance &&
          other.clearedOn == this.clearedOn);
}

class PlanStepsCompanion extends UpdateCompanion<PlanStep> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<String> name;
  final Value<String?> dose;
  final Value<String> unit;
  final Value<bool> needsClearance;
  final Value<String?> clearedOn;
  final Value<int> rowid;
  const PlanStepsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.dose = const Value.absent(),
    this.unit = const Value.absent(),
    this.needsClearance = const Value.absent(),
    this.clearedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanStepsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String exerciseId,
    required int position,
    required String name,
    this.dose = const Value.absent(),
    this.unit = const Value.absent(),
    this.needsClearance = const Value.absent(),
    this.clearedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       exerciseId = Value(exerciseId),
       position = Value(position),
       name = Value(name);
  static Insertable<PlanStep> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? dose,
    Expression<String>? unit,
    Expression<bool>? needsClearance,
    Expression<String>? clearedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (dose != null) 'dose': dose,
      if (unit != null) 'unit': unit,
      if (needsClearance != null) 'needs_clearance': needsClearance,
      if (clearedOn != null) 'cleared_on': clearedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanStepsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<String>? name,
    Value<String?>? dose,
    Value<String>? unit,
    Value<bool>? needsClearance,
    Value<String?>? clearedOn,
    Value<int>? rowid,
  }) {
    return PlanStepsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      name: name ?? this.name,
      dose: dose ?? this.dose,
      unit: unit ?? this.unit,
      needsClearance: needsClearance ?? this.needsClearance,
      clearedOn: clearedOn ?? this.clearedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dose.present) {
      map['dose'] = Variable<String>(dose.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (needsClearance.present) {
      map['needs_clearance'] = Variable<bool>(needsClearance.value);
    }
    if (clearedOn.present) {
      map['cleared_on'] = Variable<String>(clearedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanStepsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('dose: $dose, ')
          ..write('unit: $unit, ')
          ..write('needsClearance: $needsClearance, ')
          ..write('clearedOn: $clearedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanSessionLogsTable extends PlanSessionLogs
    with TableInfo<$PlanSessionLogsTable, PlanSessionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanSessionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextMorningMeta = const VerificationMeta(
    'nextMorning',
  );
  @override
  late final GeneratedColumn<String> nextMorning = GeneratedColumn<String>(
    'next_morning',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    planId,
    sessionId,
    date,
    mode,
    durationMin,
    nextMorning,
    activityId,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_session_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanSessionLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    }
    if (data.containsKey('next_morning')) {
      context.handle(
        _nextMorningMeta,
        nextMorning.isAcceptableOrUnknown(
          data['next_morning']!,
          _nextMorningMeta,
        ),
      );
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanSessionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanSessionLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      ),
      nextMorning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}next_morning'],
      ),
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PlanSessionLogsTable createAlias(String alias) {
    return $PlanSessionLogsTable(attachedDatabase, alias);
  }
}

class PlanSessionLog extends DataClass implements Insertable<PlanSessionLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String planId;

  /// Null for a floor-only day with no session picked.
  final String? sessionId;
  final String date;

  /// full | lowDay | floor — see PlanSessionMode. All count equally.
  final String mode;
  final int? durationMin;

  /// Answered the morning after: settled | higher | pem — see NextMorning.
  final String? nextMorning;

  /// The Activity row a cardio session also wrote, deleted together.
  final String? activityId;
  final String? note;
  const PlanSessionLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.planId,
    this.sessionId,
    required this.date,
    required this.mode,
    this.durationMin,
    this.nextMorning,
    this.activityId,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    if (!nullToAbsent || sessionId != null) {
      map['session_id'] = Variable<String>(sessionId);
    }
    map['date'] = Variable<String>(date);
    map['mode'] = Variable<String>(mode);
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    if (!nullToAbsent || nextMorning != null) {
      map['next_morning'] = Variable<String>(nextMorning);
    }
    if (!nullToAbsent || activityId != null) {
      map['activity_id'] = Variable<String>(activityId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PlanSessionLogsCompanion toCompanion(bool nullToAbsent) {
    return PlanSessionLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      planId: Value(planId),
      sessionId: sessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionId),
      date: Value(date),
      mode: Value(mode),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      nextMorning: nextMorning == null && nullToAbsent
          ? const Value.absent()
          : Value(nextMorning),
      activityId: activityId == null && nullToAbsent
          ? const Value.absent()
          : Value(activityId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PlanSessionLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanSessionLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      sessionId: serializer.fromJson<String?>(json['sessionId']),
      date: serializer.fromJson<String>(json['date']),
      mode: serializer.fromJson<String>(json['mode']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
      nextMorning: serializer.fromJson<String?>(json['nextMorning']),
      activityId: serializer.fromJson<String?>(json['activityId']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'sessionId': serializer.toJson<String?>(sessionId),
      'date': serializer.toJson<String>(date),
      'mode': serializer.toJson<String>(mode),
      'durationMin': serializer.toJson<int?>(durationMin),
      'nextMorning': serializer.toJson<String?>(nextMorning),
      'activityId': serializer.toJson<String?>(activityId),
      'note': serializer.toJson<String?>(note),
    };
  }

  PlanSessionLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? planId,
    Value<String?> sessionId = const Value.absent(),
    String? date,
    String? mode,
    Value<int?> durationMin = const Value.absent(),
    Value<String?> nextMorning = const Value.absent(),
    Value<String?> activityId = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => PlanSessionLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    sessionId: sessionId.present ? sessionId.value : this.sessionId,
    date: date ?? this.date,
    mode: mode ?? this.mode,
    durationMin: durationMin.present ? durationMin.value : this.durationMin,
    nextMorning: nextMorning.present ? nextMorning.value : this.nextMorning,
    activityId: activityId.present ? activityId.value : this.activityId,
    note: note.present ? note.value : this.note,
  );
  PlanSessionLog copyWithCompanion(PlanSessionLogsCompanion data) {
    return PlanSessionLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      date: data.date.present ? data.date.value : this.date,
      mode: data.mode.present ? data.mode.value : this.mode,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      nextMorning: data.nextMorning.present
          ? data.nextMorning.value
          : this.nextMorning,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanSessionLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('sessionId: $sessionId, ')
          ..write('date: $date, ')
          ..write('mode: $mode, ')
          ..write('durationMin: $durationMin, ')
          ..write('nextMorning: $nextMorning, ')
          ..write('activityId: $activityId, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    planId,
    sessionId,
    date,
    mode,
    durationMin,
    nextMorning,
    activityId,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanSessionLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.sessionId == this.sessionId &&
          other.date == this.date &&
          other.mode == this.mode &&
          other.durationMin == this.durationMin &&
          other.nextMorning == this.nextMorning &&
          other.activityId == this.activityId &&
          other.note == this.note);
}

class PlanSessionLogsCompanion extends UpdateCompanion<PlanSessionLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<String?> sessionId;
  final Value<String> date;
  final Value<String> mode;
  final Value<int?> durationMin;
  final Value<String?> nextMorning;
  final Value<String?> activityId;
  final Value<String?> note;
  final Value<int> rowid;
  const PlanSessionLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.date = const Value.absent(),
    this.mode = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.nextMorning = const Value.absent(),
    this.activityId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanSessionLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String planId,
    this.sessionId = const Value.absent(),
    required String date,
    required String mode,
    this.durationMin = const Value.absent(),
    this.nextMorning = const Value.absent(),
    this.activityId = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       planId = Value(planId),
       date = Value(date),
       mode = Value(mode);
  static Insertable<PlanSessionLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? sessionId,
    Expression<String>? date,
    Expression<String>? mode,
    Expression<int>? durationMin,
    Expression<String>? nextMorning,
    Expression<String>? activityId,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (sessionId != null) 'session_id': sessionId,
      if (date != null) 'date': date,
      if (mode != null) 'mode': mode,
      if (durationMin != null) 'duration_min': durationMin,
      if (nextMorning != null) 'next_morning': nextMorning,
      if (activityId != null) 'activity_id': activityId,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanSessionLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<String?>? sessionId,
    Value<String>? date,
    Value<String>? mode,
    Value<int?>? durationMin,
    Value<String?>? nextMorning,
    Value<String?>? activityId,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return PlanSessionLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      sessionId: sessionId ?? this.sessionId,
      date: date ?? this.date,
      mode: mode ?? this.mode,
      durationMin: durationMin ?? this.durationMin,
      nextMorning: nextMorning ?? this.nextMorning,
      activityId: activityId ?? this.activityId,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (nextMorning.present) {
      map['next_morning'] = Variable<String>(nextMorning.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanSessionLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('sessionId: $sessionId, ')
          ..write('date: $date, ')
          ..write('mode: $mode, ')
          ..write('durationMin: $durationMin, ')
          ..write('nextMorning: $nextMorning, ')
          ..write('activityId: $activityId, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanSetLogsTable extends PlanSetLogs
    with TableInfo<$PlanSetLogsTable, PlanSetLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanSetLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionLogIdMeta = const VerificationMeta(
    'sessionLogId',
  );
  @override
  late final GeneratedColumn<String> sessionLogId = GeneratedColumn<String>(
    'session_log_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<String> stepId = GeneratedColumn<String>(
    'step_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setValuesMeta = const VerificationMeta(
    'setValues',
  );
  @override
  late final GeneratedColumn<String> setValues = GeneratedColumn<String>(
    'set_values',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('reps'),
  );
  static const VerificationMeta _painMeta = const VerificationMeta('pain');
  @override
  late final GeneratedColumn<int> pain = GeneratedColumn<int>(
    'pain',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sharpMeta = const VerificationMeta('sharp');
  @override
  late final GeneratedColumn<bool> sharp = GeneratedColumn<bool>(
    'sharp',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sharp" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    sessionLogId,
    exerciseId,
    stepId,
    setValues,
    unit,
    pain,
    sharp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_set_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanSetLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_log_id')) {
      context.handle(
        _sessionLogIdMeta,
        sessionLogId.isAcceptableOrUnknown(
          data['session_log_id']!,
          _sessionLogIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionLogIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(
        _stepIdMeta,
        stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('set_values')) {
      context.handle(
        _setValuesMeta,
        setValues.isAcceptableOrUnknown(data['set_values']!, _setValuesMeta),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('pain')) {
      context.handle(
        _painMeta,
        pain.isAcceptableOrUnknown(data['pain']!, _painMeta),
      );
    }
    if (data.containsKey('sharp')) {
      context.handle(
        _sharpMeta,
        sharp.isAcceptableOrUnknown(data['sharp']!, _sharpMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanSetLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanSetLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_log_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      stepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_id'],
      )!,
      setValues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_values'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      pain: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pain'],
      ),
      sharp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sharp'],
      )!,
    );
  }

  @override
  $PlanSetLogsTable createAlias(String alias) {
    return $PlanSetLogsTable(attachedDatabase, alias);
  }
}

class PlanSetLog extends DataClass implements Insertable<PlanSetLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String sessionLogId;
  final String exerciseId;
  final String stepId;

  /// Each set's reps or seconds, as a JSON int list, e.g. `[8,8,6]`.
  final String setValues;
  final String unit;

  /// Highest pain during the exercise, 0–10 (pain-monitoring model).
  final int? pain;

  /// Sharp, catching or giving way — always "too much", whatever the number.
  final bool sharp;
  const PlanSetLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.sessionLogId,
    required this.exerciseId,
    required this.stepId,
    required this.setValues,
    required this.unit,
    this.pain,
    required this.sharp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['session_log_id'] = Variable<String>(sessionLogId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['step_id'] = Variable<String>(stepId);
    map['set_values'] = Variable<String>(setValues);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || pain != null) {
      map['pain'] = Variable<int>(pain);
    }
    map['sharp'] = Variable<bool>(sharp);
    return map;
  }

  PlanSetLogsCompanion toCompanion(bool nullToAbsent) {
    return PlanSetLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      sessionLogId: Value(sessionLogId),
      exerciseId: Value(exerciseId),
      stepId: Value(stepId),
      setValues: Value(setValues),
      unit: Value(unit),
      pain: pain == null && nullToAbsent ? const Value.absent() : Value(pain),
      sharp: Value(sharp),
    );
  }

  factory PlanSetLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanSetLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      sessionLogId: serializer.fromJson<String>(json['sessionLogId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      stepId: serializer.fromJson<String>(json['stepId']),
      setValues: serializer.fromJson<String>(json['setValues']),
      unit: serializer.fromJson<String>(json['unit']),
      pain: serializer.fromJson<int?>(json['pain']),
      sharp: serializer.fromJson<bool>(json['sharp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'sessionLogId': serializer.toJson<String>(sessionLogId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'stepId': serializer.toJson<String>(stepId),
      'setValues': serializer.toJson<String>(setValues),
      'unit': serializer.toJson<String>(unit),
      'pain': serializer.toJson<int?>(pain),
      'sharp': serializer.toJson<bool>(sharp),
    };
  }

  PlanSetLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? sessionLogId,
    String? exerciseId,
    String? stepId,
    String? setValues,
    String? unit,
    Value<int?> pain = const Value.absent(),
    bool? sharp,
  }) => PlanSetLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    sessionLogId: sessionLogId ?? this.sessionLogId,
    exerciseId: exerciseId ?? this.exerciseId,
    stepId: stepId ?? this.stepId,
    setValues: setValues ?? this.setValues,
    unit: unit ?? this.unit,
    pain: pain.present ? pain.value : this.pain,
    sharp: sharp ?? this.sharp,
  );
  PlanSetLog copyWithCompanion(PlanSetLogsCompanion data) {
    return PlanSetLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      sessionLogId: data.sessionLogId.present
          ? data.sessionLogId.value
          : this.sessionLogId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      setValues: data.setValues.present ? data.setValues.value : this.setValues,
      unit: data.unit.present ? data.unit.value : this.unit,
      pain: data.pain.present ? data.pain.value : this.pain,
      sharp: data.sharp.present ? data.sharp.value : this.sharp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanSetLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sessionLogId: $sessionLogId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('stepId: $stepId, ')
          ..write('setValues: $setValues, ')
          ..write('unit: $unit, ')
          ..write('pain: $pain, ')
          ..write('sharp: $sharp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    sessionLogId,
    exerciseId,
    stepId,
    setValues,
    unit,
    pain,
    sharp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanSetLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.sessionLogId == this.sessionLogId &&
          other.exerciseId == this.exerciseId &&
          other.stepId == this.stepId &&
          other.setValues == this.setValues &&
          other.unit == this.unit &&
          other.pain == this.pain &&
          other.sharp == this.sharp);
}

class PlanSetLogsCompanion extends UpdateCompanion<PlanSetLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> sessionLogId;
  final Value<String> exerciseId;
  final Value<String> stepId;
  final Value<String> setValues;
  final Value<String> unit;
  final Value<int?> pain;
  final Value<bool> sharp;
  final Value<int> rowid;
  const PlanSetLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.sessionLogId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.setValues = const Value.absent(),
    this.unit = const Value.absent(),
    this.pain = const Value.absent(),
    this.sharp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanSetLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String sessionLogId,
    required String exerciseId,
    required String stepId,
    this.setValues = const Value.absent(),
    this.unit = const Value.absent(),
    this.pain = const Value.absent(),
    this.sharp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       sessionLogId = Value(sessionLogId),
       exerciseId = Value(exerciseId),
       stepId = Value(stepId);
  static Insertable<PlanSetLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? sessionLogId,
    Expression<String>? exerciseId,
    Expression<String>? stepId,
    Expression<String>? setValues,
    Expression<String>? unit,
    Expression<int>? pain,
    Expression<bool>? sharp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (sessionLogId != null) 'session_log_id': sessionLogId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (stepId != null) 'step_id': stepId,
      if (setValues != null) 'set_values': setValues,
      if (unit != null) 'unit': unit,
      if (pain != null) 'pain': pain,
      if (sharp != null) 'sharp': sharp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanSetLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? sessionLogId,
    Value<String>? exerciseId,
    Value<String>? stepId,
    Value<String>? setValues,
    Value<String>? unit,
    Value<int?>? pain,
    Value<bool>? sharp,
    Value<int>? rowid,
  }) {
    return PlanSetLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      sessionLogId: sessionLogId ?? this.sessionLogId,
      exerciseId: exerciseId ?? this.exerciseId,
      stepId: stepId ?? this.stepId,
      setValues: setValues ?? this.setValues,
      unit: unit ?? this.unit,
      pain: pain ?? this.pain,
      sharp: sharp ?? this.sharp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionLogId.present) {
      map['session_log_id'] = Variable<String>(sessionLogId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (setValues.present) {
      map['set_values'] = Variable<String>(setValues.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (pain.present) {
      map['pain'] = Variable<int>(pain.value);
    }
    if (sharp.present) {
      map['sharp'] = Variable<bool>(sharp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanSetLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('sessionLogId: $sessionLogId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('stepId: $stepId, ')
          ..write('setValues: $setValues, ')
          ..write('unit: $unit, ')
          ..write('pain: $pain, ')
          ..write('sharp: $sharp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanCheckinsTable extends PlanCheckins
    with TableInfo<$PlanCheckinsTable, PlanCheckin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanCheckinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<String> weekStart = GeneratedColumn<String>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionsDoneMeta = const VerificationMeta(
    'sessionsDone',
  );
  @override
  late final GeneratedColumn<int> sessionsDone = GeneratedColumn<int>(
    'sessions_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionsPlannedMeta = const VerificationMeta(
    'sessionsPlanned',
  );
  @override
  late final GeneratedColumn<int> sessionsPlanned = GeneratedColumn<int>(
    'sessions_planned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hadPemMeta = const VerificationMeta('hadPem');
  @override
  late final GeneratedColumn<bool> hadPem = GeneratedColumn<bool>(
    'had_pem',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("had_pem" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _pemCauseMeta = const VerificationMeta(
    'pemCause',
  );
  @override
  late final GeneratedColumn<String> pemCause = GeneratedColumn<String>(
    'pem_cause',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jointsOkMeta = const VerificationMeta(
    'jointsOk',
  );
  @override
  late final GeneratedColumn<bool> jointsOk = GeneratedColumn<bool>(
    'joints_ok',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("joints_ok" IN (0, 1))',
    ),
  );
  static const VerificationMeta _proteinDaysMeta = const VerificationMeta(
    'proteinDays',
  );
  @override
  late final GeneratedColumn<int> proteinDays = GeneratedColumn<int>(
    'protein_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _winMeta = const VerificationMeta('win');
  @override
  late final GeneratedColumn<String> win = GeneratedColumn<String>(
    'win',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fearStepMeta = const VerificationMeta(
    'fearStep',
  );
  @override
  late final GeneratedColumn<String> fearStep = GeneratedColumn<String>(
    'fear_step',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _decisionMeta = const VerificationMeta(
    'decision',
  );
  @override
  late final GeneratedColumn<String> decision = GeneratedColumn<String>(
    'decision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ceilingBeforeMeta = const VerificationMeta(
    'ceilingBefore',
  );
  @override
  late final GeneratedColumn<int> ceilingBefore = GeneratedColumn<int>(
    'ceiling_before',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ceilingAfterMeta = const VerificationMeta(
    'ceilingAfter',
  );
  @override
  late final GeneratedColumn<int> ceilingAfter = GeneratedColumn<int>(
    'ceiling_after',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    planId,
    weekStart,
    sessionsDone,
    sessionsPlanned,
    hadPem,
    pemCause,
    jointsOk,
    proteinDays,
    weightKg,
    win,
    fearStep,
    decision,
    ceilingBefore,
    ceilingAfter,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_checkins';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanCheckin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('sessions_done')) {
      context.handle(
        _sessionsDoneMeta,
        sessionsDone.isAcceptableOrUnknown(
          data['sessions_done']!,
          _sessionsDoneMeta,
        ),
      );
    }
    if (data.containsKey('sessions_planned')) {
      context.handle(
        _sessionsPlannedMeta,
        sessionsPlanned.isAcceptableOrUnknown(
          data['sessions_planned']!,
          _sessionsPlannedMeta,
        ),
      );
    }
    if (data.containsKey('had_pem')) {
      context.handle(
        _hadPemMeta,
        hadPem.isAcceptableOrUnknown(data['had_pem']!, _hadPemMeta),
      );
    }
    if (data.containsKey('pem_cause')) {
      context.handle(
        _pemCauseMeta,
        pemCause.isAcceptableOrUnknown(data['pem_cause']!, _pemCauseMeta),
      );
    }
    if (data.containsKey('joints_ok')) {
      context.handle(
        _jointsOkMeta,
        jointsOk.isAcceptableOrUnknown(data['joints_ok']!, _jointsOkMeta),
      );
    }
    if (data.containsKey('protein_days')) {
      context.handle(
        _proteinDaysMeta,
        proteinDays.isAcceptableOrUnknown(
          data['protein_days']!,
          _proteinDaysMeta,
        ),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('win')) {
      context.handle(
        _winMeta,
        win.isAcceptableOrUnknown(data['win']!, _winMeta),
      );
    }
    if (data.containsKey('fear_step')) {
      context.handle(
        _fearStepMeta,
        fearStep.isAcceptableOrUnknown(data['fear_step']!, _fearStepMeta),
      );
    }
    if (data.containsKey('decision')) {
      context.handle(
        _decisionMeta,
        decision.isAcceptableOrUnknown(data['decision']!, _decisionMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionMeta);
    }
    if (data.containsKey('ceiling_before')) {
      context.handle(
        _ceilingBeforeMeta,
        ceilingBefore.isAcceptableOrUnknown(
          data['ceiling_before']!,
          _ceilingBeforeMeta,
        ),
      );
    }
    if (data.containsKey('ceiling_after')) {
      context.handle(
        _ceilingAfterMeta,
        ceilingAfter.isAcceptableOrUnknown(
          data['ceiling_after']!,
          _ceilingAfterMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanCheckin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanCheckin(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week_start'],
      )!,
      sessionsDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sessions_done'],
      )!,
      sessionsPlanned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sessions_planned'],
      )!,
      hadPem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}had_pem'],
      )!,
      pemCause: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pem_cause'],
      ),
      jointsOk: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}joints_ok'],
      ),
      proteinDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protein_days'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      win: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}win'],
      ),
      fearStep: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fear_step'],
      ),
      decision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision'],
      )!,
      ceilingBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ceiling_before'],
      ),
      ceilingAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ceiling_after'],
      ),
    );
  }

  @override
  $PlanCheckinsTable createAlias(String alias) {
    return $PlanCheckinsTable(attachedDatabase, alias);
  }
}

class PlanCheckin extends DataClass implements Insertable<PlanCheckin> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String planId;

  /// Monday of the week being reviewed.
  final String weekStart;
  final int sessionsDone;
  final int sessionsPlanned;
  final bool hadPem;

  /// What came before the PEM (training, work, stairs, sleep, migraine…).
  final String? pemCause;

  /// Next-morning pain stayed at or below baseline all week.
  final bool? jointsOk;
  final int? proteinDays;
  final double? weightKg;
  final String? win;
  final String? fearStep;

  /// raise | keep | stepBack — see CheckinDecision.
  final String decision;
  final int? ceilingBefore;
  final int? ceilingAfter;
  const PlanCheckin({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.planId,
    required this.weekStart,
    required this.sessionsDone,
    required this.sessionsPlanned,
    required this.hadPem,
    this.pemCause,
    this.jointsOk,
    this.proteinDays,
    this.weightKg,
    this.win,
    this.fearStep,
    required this.decision,
    this.ceilingBefore,
    this.ceilingAfter,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['week_start'] = Variable<String>(weekStart);
    map['sessions_done'] = Variable<int>(sessionsDone);
    map['sessions_planned'] = Variable<int>(sessionsPlanned);
    map['had_pem'] = Variable<bool>(hadPem);
    if (!nullToAbsent || pemCause != null) {
      map['pem_cause'] = Variable<String>(pemCause);
    }
    if (!nullToAbsent || jointsOk != null) {
      map['joints_ok'] = Variable<bool>(jointsOk);
    }
    if (!nullToAbsent || proteinDays != null) {
      map['protein_days'] = Variable<int>(proteinDays);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || win != null) {
      map['win'] = Variable<String>(win);
    }
    if (!nullToAbsent || fearStep != null) {
      map['fear_step'] = Variable<String>(fearStep);
    }
    map['decision'] = Variable<String>(decision);
    if (!nullToAbsent || ceilingBefore != null) {
      map['ceiling_before'] = Variable<int>(ceilingBefore);
    }
    if (!nullToAbsent || ceilingAfter != null) {
      map['ceiling_after'] = Variable<int>(ceilingAfter);
    }
    return map;
  }

  PlanCheckinsCompanion toCompanion(bool nullToAbsent) {
    return PlanCheckinsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      planId: Value(planId),
      weekStart: Value(weekStart),
      sessionsDone: Value(sessionsDone),
      sessionsPlanned: Value(sessionsPlanned),
      hadPem: Value(hadPem),
      pemCause: pemCause == null && nullToAbsent
          ? const Value.absent()
          : Value(pemCause),
      jointsOk: jointsOk == null && nullToAbsent
          ? const Value.absent()
          : Value(jointsOk),
      proteinDays: proteinDays == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinDays),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      win: win == null && nullToAbsent ? const Value.absent() : Value(win),
      fearStep: fearStep == null && nullToAbsent
          ? const Value.absent()
          : Value(fearStep),
      decision: Value(decision),
      ceilingBefore: ceilingBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(ceilingBefore),
      ceilingAfter: ceilingAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(ceilingAfter),
    );
  }

  factory PlanCheckin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanCheckin(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      weekStart: serializer.fromJson<String>(json['weekStart']),
      sessionsDone: serializer.fromJson<int>(json['sessionsDone']),
      sessionsPlanned: serializer.fromJson<int>(json['sessionsPlanned']),
      hadPem: serializer.fromJson<bool>(json['hadPem']),
      pemCause: serializer.fromJson<String?>(json['pemCause']),
      jointsOk: serializer.fromJson<bool?>(json['jointsOk']),
      proteinDays: serializer.fromJson<int?>(json['proteinDays']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      win: serializer.fromJson<String?>(json['win']),
      fearStep: serializer.fromJson<String?>(json['fearStep']),
      decision: serializer.fromJson<String>(json['decision']),
      ceilingBefore: serializer.fromJson<int?>(json['ceilingBefore']),
      ceilingAfter: serializer.fromJson<int?>(json['ceilingAfter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'weekStart': serializer.toJson<String>(weekStart),
      'sessionsDone': serializer.toJson<int>(sessionsDone),
      'sessionsPlanned': serializer.toJson<int>(sessionsPlanned),
      'hadPem': serializer.toJson<bool>(hadPem),
      'pemCause': serializer.toJson<String?>(pemCause),
      'jointsOk': serializer.toJson<bool?>(jointsOk),
      'proteinDays': serializer.toJson<int?>(proteinDays),
      'weightKg': serializer.toJson<double?>(weightKg),
      'win': serializer.toJson<String?>(win),
      'fearStep': serializer.toJson<String?>(fearStep),
      'decision': serializer.toJson<String>(decision),
      'ceilingBefore': serializer.toJson<int?>(ceilingBefore),
      'ceilingAfter': serializer.toJson<int?>(ceilingAfter),
    };
  }

  PlanCheckin copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? planId,
    String? weekStart,
    int? sessionsDone,
    int? sessionsPlanned,
    bool? hadPem,
    Value<String?> pemCause = const Value.absent(),
    Value<bool?> jointsOk = const Value.absent(),
    Value<int?> proteinDays = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<String?> win = const Value.absent(),
    Value<String?> fearStep = const Value.absent(),
    String? decision,
    Value<int?> ceilingBefore = const Value.absent(),
    Value<int?> ceilingAfter = const Value.absent(),
  }) => PlanCheckin(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    weekStart: weekStart ?? this.weekStart,
    sessionsDone: sessionsDone ?? this.sessionsDone,
    sessionsPlanned: sessionsPlanned ?? this.sessionsPlanned,
    hadPem: hadPem ?? this.hadPem,
    pemCause: pemCause.present ? pemCause.value : this.pemCause,
    jointsOk: jointsOk.present ? jointsOk.value : this.jointsOk,
    proteinDays: proteinDays.present ? proteinDays.value : this.proteinDays,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    win: win.present ? win.value : this.win,
    fearStep: fearStep.present ? fearStep.value : this.fearStep,
    decision: decision ?? this.decision,
    ceilingBefore: ceilingBefore.present
        ? ceilingBefore.value
        : this.ceilingBefore,
    ceilingAfter: ceilingAfter.present ? ceilingAfter.value : this.ceilingAfter,
  );
  PlanCheckin copyWithCompanion(PlanCheckinsCompanion data) {
    return PlanCheckin(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      sessionsDone: data.sessionsDone.present
          ? data.sessionsDone.value
          : this.sessionsDone,
      sessionsPlanned: data.sessionsPlanned.present
          ? data.sessionsPlanned.value
          : this.sessionsPlanned,
      hadPem: data.hadPem.present ? data.hadPem.value : this.hadPem,
      pemCause: data.pemCause.present ? data.pemCause.value : this.pemCause,
      jointsOk: data.jointsOk.present ? data.jointsOk.value : this.jointsOk,
      proteinDays: data.proteinDays.present
          ? data.proteinDays.value
          : this.proteinDays,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      win: data.win.present ? data.win.value : this.win,
      fearStep: data.fearStep.present ? data.fearStep.value : this.fearStep,
      decision: data.decision.present ? data.decision.value : this.decision,
      ceilingBefore: data.ceilingBefore.present
          ? data.ceilingBefore.value
          : this.ceilingBefore,
      ceilingAfter: data.ceilingAfter.present
          ? data.ceilingAfter.value
          : this.ceilingAfter,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanCheckin(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('weekStart: $weekStart, ')
          ..write('sessionsDone: $sessionsDone, ')
          ..write('sessionsPlanned: $sessionsPlanned, ')
          ..write('hadPem: $hadPem, ')
          ..write('pemCause: $pemCause, ')
          ..write('jointsOk: $jointsOk, ')
          ..write('proteinDays: $proteinDays, ')
          ..write('weightKg: $weightKg, ')
          ..write('win: $win, ')
          ..write('fearStep: $fearStep, ')
          ..write('decision: $decision, ')
          ..write('ceilingBefore: $ceilingBefore, ')
          ..write('ceilingAfter: $ceilingAfter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    planId,
    weekStart,
    sessionsDone,
    sessionsPlanned,
    hadPem,
    pemCause,
    jointsOk,
    proteinDays,
    weightKg,
    win,
    fearStep,
    decision,
    ceilingBefore,
    ceilingAfter,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanCheckin &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.weekStart == this.weekStart &&
          other.sessionsDone == this.sessionsDone &&
          other.sessionsPlanned == this.sessionsPlanned &&
          other.hadPem == this.hadPem &&
          other.pemCause == this.pemCause &&
          other.jointsOk == this.jointsOk &&
          other.proteinDays == this.proteinDays &&
          other.weightKg == this.weightKg &&
          other.win == this.win &&
          other.fearStep == this.fearStep &&
          other.decision == this.decision &&
          other.ceilingBefore == this.ceilingBefore &&
          other.ceilingAfter == this.ceilingAfter);
}

class PlanCheckinsCompanion extends UpdateCompanion<PlanCheckin> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<String> weekStart;
  final Value<int> sessionsDone;
  final Value<int> sessionsPlanned;
  final Value<bool> hadPem;
  final Value<String?> pemCause;
  final Value<bool?> jointsOk;
  final Value<int?> proteinDays;
  final Value<double?> weightKg;
  final Value<String?> win;
  final Value<String?> fearStep;
  final Value<String> decision;
  final Value<int?> ceilingBefore;
  final Value<int?> ceilingAfter;
  final Value<int> rowid;
  const PlanCheckinsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.sessionsDone = const Value.absent(),
    this.sessionsPlanned = const Value.absent(),
    this.hadPem = const Value.absent(),
    this.pemCause = const Value.absent(),
    this.jointsOk = const Value.absent(),
    this.proteinDays = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.win = const Value.absent(),
    this.fearStep = const Value.absent(),
    this.decision = const Value.absent(),
    this.ceilingBefore = const Value.absent(),
    this.ceilingAfter = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanCheckinsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String planId,
    required String weekStart,
    this.sessionsDone = const Value.absent(),
    this.sessionsPlanned = const Value.absent(),
    this.hadPem = const Value.absent(),
    this.pemCause = const Value.absent(),
    this.jointsOk = const Value.absent(),
    this.proteinDays = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.win = const Value.absent(),
    this.fearStep = const Value.absent(),
    required String decision,
    this.ceilingBefore = const Value.absent(),
    this.ceilingAfter = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       planId = Value(planId),
       weekStart = Value(weekStart),
       decision = Value(decision);
  static Insertable<PlanCheckin> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? weekStart,
    Expression<int>? sessionsDone,
    Expression<int>? sessionsPlanned,
    Expression<bool>? hadPem,
    Expression<String>? pemCause,
    Expression<bool>? jointsOk,
    Expression<int>? proteinDays,
    Expression<double>? weightKg,
    Expression<String>? win,
    Expression<String>? fearStep,
    Expression<String>? decision,
    Expression<int>? ceilingBefore,
    Expression<int>? ceilingAfter,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (weekStart != null) 'week_start': weekStart,
      if (sessionsDone != null) 'sessions_done': sessionsDone,
      if (sessionsPlanned != null) 'sessions_planned': sessionsPlanned,
      if (hadPem != null) 'had_pem': hadPem,
      if (pemCause != null) 'pem_cause': pemCause,
      if (jointsOk != null) 'joints_ok': jointsOk,
      if (proteinDays != null) 'protein_days': proteinDays,
      if (weightKg != null) 'weight_kg': weightKg,
      if (win != null) 'win': win,
      if (fearStep != null) 'fear_step': fearStep,
      if (decision != null) 'decision': decision,
      if (ceilingBefore != null) 'ceiling_before': ceilingBefore,
      if (ceilingAfter != null) 'ceiling_after': ceilingAfter,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanCheckinsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<String>? weekStart,
    Value<int>? sessionsDone,
    Value<int>? sessionsPlanned,
    Value<bool>? hadPem,
    Value<String?>? pemCause,
    Value<bool?>? jointsOk,
    Value<int?>? proteinDays,
    Value<double?>? weightKg,
    Value<String?>? win,
    Value<String?>? fearStep,
    Value<String>? decision,
    Value<int?>? ceilingBefore,
    Value<int?>? ceilingAfter,
    Value<int>? rowid,
  }) {
    return PlanCheckinsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      weekStart: weekStart ?? this.weekStart,
      sessionsDone: sessionsDone ?? this.sessionsDone,
      sessionsPlanned: sessionsPlanned ?? this.sessionsPlanned,
      hadPem: hadPem ?? this.hadPem,
      pemCause: pemCause ?? this.pemCause,
      jointsOk: jointsOk ?? this.jointsOk,
      proteinDays: proteinDays ?? this.proteinDays,
      weightKg: weightKg ?? this.weightKg,
      win: win ?? this.win,
      fearStep: fearStep ?? this.fearStep,
      decision: decision ?? this.decision,
      ceilingBefore: ceilingBefore ?? this.ceilingBefore,
      ceilingAfter: ceilingAfter ?? this.ceilingAfter,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<String>(weekStart.value);
    }
    if (sessionsDone.present) {
      map['sessions_done'] = Variable<int>(sessionsDone.value);
    }
    if (sessionsPlanned.present) {
      map['sessions_planned'] = Variable<int>(sessionsPlanned.value);
    }
    if (hadPem.present) {
      map['had_pem'] = Variable<bool>(hadPem.value);
    }
    if (pemCause.present) {
      map['pem_cause'] = Variable<String>(pemCause.value);
    }
    if (jointsOk.present) {
      map['joints_ok'] = Variable<bool>(jointsOk.value);
    }
    if (proteinDays.present) {
      map['protein_days'] = Variable<int>(proteinDays.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (win.present) {
      map['win'] = Variable<String>(win.value);
    }
    if (fearStep.present) {
      map['fear_step'] = Variable<String>(fearStep.value);
    }
    if (decision.present) {
      map['decision'] = Variable<String>(decision.value);
    }
    if (ceilingBefore.present) {
      map['ceiling_before'] = Variable<int>(ceilingBefore.value);
    }
    if (ceilingAfter.present) {
      map['ceiling_after'] = Variable<int>(ceilingAfter.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanCheckinsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('weekStart: $weekStart, ')
          ..write('sessionsDone: $sessionsDone, ')
          ..write('sessionsPlanned: $sessionsPlanned, ')
          ..write('hadPem: $hadPem, ')
          ..write('pemCause: $pemCause, ')
          ..write('jointsOk: $jointsOk, ')
          ..write('proteinDays: $proteinDays, ')
          ..write('weightKg: $weightKg, ')
          ..write('win: $win, ')
          ..write('fearStep: $fearStep, ')
          ..write('decision: $decision, ')
          ..write('ceilingBefore: $ceilingBefore, ')
          ..write('ceilingAfter: $ceilingAfter, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanTestsTable extends PlanTests
    with TableInfo<$PlanTestsTable, PlanTest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanTestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    planId,
    position,
    name,
    unit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanTest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanTest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanTest(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
    );
  }

  @override
  $PlanTestsTable createAlias(String alias) {
    return $PlanTestsTable(attachedDatabase, alias);
  }
}

class PlanTest extends DataClass implements Insertable<PlanTest> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String planId;
  final int position;
  final String name;

  /// Free text, e.g. "reps", "seconds", "kg".
  final String? unit;
  const PlanTest({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.planId,
    required this.position,
    required this.name,
    this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    return map;
  }

  PlanTestsCompanion toCompanion(bool nullToAbsent) {
    return PlanTestsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      planId: Value(planId),
      position: Value(position),
      name: Value(name),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
    );
  }

  factory PlanTest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanTest(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      unit: serializer.fromJson<String?>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String?>(unit),
    };
  }

  PlanTest copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? planId,
    int? position,
    String? name,
    Value<String?> unit = const Value.absent(),
  }) => PlanTest(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    planId: planId ?? this.planId,
    position: position ?? this.position,
    name: name ?? this.name,
    unit: unit.present ? unit.value : this.unit,
  );
  PlanTest copyWithCompanion(PlanTestsCompanion data) {
    return PlanTest(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanTest(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(updatedAt, deletedAt, id, planId, position, name, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanTest &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.position == this.position &&
          other.name == this.name &&
          other.unit == this.unit);
}

class PlanTestsCompanion extends UpdateCompanion<PlanTest> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> planId;
  final Value<int> position;
  final Value<String> name;
  final Value<String?> unit;
  final Value<int> rowid;
  const PlanTestsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanTestsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String planId,
    required int position,
    required String name,
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       planId = Value(planId),
       position = Value(position),
       name = Value(name);
  static Insertable<PlanTest> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanTestsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? planId,
    Value<int>? position,
    Value<String>? name,
    Value<String?>? unit,
    Value<int>? rowid,
  }) {
    return PlanTestsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      planId: planId ?? this.planId,
      position: position ?? this.position,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanTestsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlanTestResultsTable extends PlanTestResults
    with TableInfo<$PlanTestResultsTable, PlanTestResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanTestResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<String> testId = GeneratedColumn<String>(
    'test_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    testId,
    date,
    value,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_test_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanTestResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('test_id')) {
      context.handle(
        _testIdMeta,
        testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta),
      );
    } else if (isInserting) {
      context.missing(_testIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanTestResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanTestResult(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      testId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}test_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $PlanTestResultsTable createAlias(String alias) {
    return $PlanTestResultsTable(attachedDatabase, alias);
  }
}

class PlanTestResult extends DataClass implements Insertable<PlanTestResult> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String testId;
  final String date;
  final double value;
  final String? note;
  const PlanTestResult({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.testId,
    required this.date,
    required this.value,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['test_id'] = Variable<String>(testId);
    map['date'] = Variable<String>(date);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PlanTestResultsCompanion toCompanion(bool nullToAbsent) {
    return PlanTestResultsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      testId: Value(testId),
      date: Value(date),
      value: Value(value),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PlanTestResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanTestResult(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      testId: serializer.fromJson<String>(json['testId']),
      date: serializer.fromJson<String>(json['date']),
      value: serializer.fromJson<double>(json['value']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'testId': serializer.toJson<String>(testId),
      'date': serializer.toJson<String>(date),
      'value': serializer.toJson<double>(value),
      'note': serializer.toJson<String?>(note),
    };
  }

  PlanTestResult copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? testId,
    String? date,
    double? value,
    Value<String?> note = const Value.absent(),
  }) => PlanTestResult(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    testId: testId ?? this.testId,
    date: date ?? this.date,
    value: value ?? this.value,
    note: note.present ? note.value : this.note,
  );
  PlanTestResult copyWithCompanion(PlanTestResultsCompanion data) {
    return PlanTestResult(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      date: data.date.present ? data.date.value : this.date,
      value: data.value.present ? data.value.value : this.value,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanTestResult(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(updatedAt, deletedAt, id, testId, date, value, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanTestResult &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.date == this.date &&
          other.value == this.value &&
          other.note == this.note);
}

class PlanTestResultsCompanion extends UpdateCompanion<PlanTestResult> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> testId;
  final Value<String> date;
  final Value<double> value;
  final Value<String?> note;
  final Value<int> rowid;
  const PlanTestResultsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.date = const Value.absent(),
    this.value = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanTestResultsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String testId,
    required String date,
    required double value,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       testId = Value(testId),
       date = Value(date),
       value = Value(value);
  static Insertable<PlanTestResult> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? testId,
    Expression<String>? date,
    Expression<double>? value,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (date != null) 'date': date,
      if (value != null) 'value': value,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanTestResultsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? testId,
    Value<String>? date,
    Value<double>? value,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return PlanTestResultsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      testId: testId ?? this.testId,
      date: date ?? this.date,
      value: value ?? this.value,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<String>(testId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanTestResultsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('date: $date, ')
          ..write('value: $value, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FearItemsTable extends FearItems
    with TableInfo<$FearItemsTable, FearItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FearItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fearMeta = const VerificationMeta('fear');
  @override
  late final GeneratedColumn<int> fear = GeneratedColumn<int>(
    'fear',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialFearMeta = const VerificationMeta(
    'initialFear',
  );
  @override
  late final GeneratedColumn<int> initialFear = GeneratedColumn<int>(
    'initial_fear',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settledOnMeta = const VerificationMeta(
    'settledOn',
  );
  @override
  late final GeneratedColumn<String> settledOn = GeneratedColumn<String>(
    'settled_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    name,
    fear,
    initialFear,
    settledOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fear_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FearItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('fear')) {
      context.handle(
        _fearMeta,
        fear.isAcceptableOrUnknown(data['fear']!, _fearMeta),
      );
    } else if (isInserting) {
      context.missing(_fearMeta);
    }
    if (data.containsKey('initial_fear')) {
      context.handle(
        _initialFearMeta,
        initialFear.isAcceptableOrUnknown(
          data['initial_fear']!,
          _initialFearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialFearMeta);
    }
    if (data.containsKey('settled_on')) {
      context.handle(
        _settledOnMeta,
        settledOn.isAcceptableOrUnknown(data['settled_on']!, _settledOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FearItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FearItem(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      fear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fear'],
      )!,
      initialFear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}initial_fear'],
      )!,
      settledOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settled_on'],
      ),
    );
  }

  @override
  $FearItemsTable createAlias(String alias) {
    return $FearItemsTable(attachedDatabase, alias);
  }
}

class FearItem extends DataClass implements Insertable<FearItem> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String name;
  final int fear;

  /// The fear rating when it was first added, to show change over time.
  final int initialFear;

  /// yyyy-MM-dd once it feels about 2/10 and the person moves on.
  final String? settledOn;
  const FearItem({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.fear,
    required this.initialFear,
    this.settledOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['fear'] = Variable<int>(fear);
    map['initial_fear'] = Variable<int>(initialFear);
    if (!nullToAbsent || settledOn != null) {
      map['settled_on'] = Variable<String>(settledOn);
    }
    return map;
  }

  FearItemsCompanion toCompanion(bool nullToAbsent) {
    return FearItemsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      fear: Value(fear),
      initialFear: Value(initialFear),
      settledOn: settledOn == null && nullToAbsent
          ? const Value.absent()
          : Value(settledOn),
    );
  }

  factory FearItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FearItem(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      fear: serializer.fromJson<int>(json['fear']),
      initialFear: serializer.fromJson<int>(json['initialFear']),
      settledOn: serializer.fromJson<String?>(json['settledOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'fear': serializer.toJson<int>(fear),
      'initialFear': serializer.toJson<int>(initialFear),
      'settledOn': serializer.toJson<String?>(settledOn),
    };
  }

  FearItem copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    int? fear,
    int? initialFear,
    Value<String?> settledOn = const Value.absent(),
  }) => FearItem(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    fear: fear ?? this.fear,
    initialFear: initialFear ?? this.initialFear,
    settledOn: settledOn.present ? settledOn.value : this.settledOn,
  );
  FearItem copyWithCompanion(FearItemsCompanion data) {
    return FearItem(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      fear: data.fear.present ? data.fear.value : this.fear,
      initialFear: data.initialFear.present
          ? data.initialFear.value
          : this.initialFear,
      settledOn: data.settledOn.present ? data.settledOn.value : this.settledOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FearItem(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('fear: $fear, ')
          ..write('initialFear: $initialFear, ')
          ..write('settledOn: $settledOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(updatedAt, deletedAt, id, name, fear, initialFear, settledOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FearItem &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.fear == this.fear &&
          other.initialFear == this.initialFear &&
          other.settledOn == this.settledOn);
}

class FearItemsCompanion extends UpdateCompanion<FearItem> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<int> fear;
  final Value<int> initialFear;
  final Value<String?> settledOn;
  final Value<int> rowid;
  const FearItemsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.fear = const Value.absent(),
    this.initialFear = const Value.absent(),
    this.settledOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FearItemsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required int fear,
    required int initialFear,
    this.settledOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       name = Value(name),
       fear = Value(fear),
       initialFear = Value(initialFear);
  static Insertable<FearItem> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? fear,
    Expression<int>? initialFear,
    Expression<String>? settledOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (fear != null) 'fear': fear,
      if (initialFear != null) 'initial_fear': initialFear,
      if (settledOn != null) 'settled_on': settledOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FearItemsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<int>? fear,
    Value<int>? initialFear,
    Value<String?>? settledOn,
    Value<int>? rowid,
  }) {
    return FearItemsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      fear: fear ?? this.fear,
      initialFear: initialFear ?? this.initialFear,
      settledOn: settledOn ?? this.settledOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fear.present) {
      map['fear'] = Variable<int>(fear.value);
    }
    if (initialFear.present) {
      map['initial_fear'] = Variable<int>(initialFear.value);
    }
    if (settledOn.present) {
      map['settled_on'] = Variable<String>(settledOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FearItemsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('fear: $fear, ')
          ..write('initialFear: $initialFear, ')
          ..write('settledOn: $settledOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExposureLogsTable extends ExposureLogs
    with TableInfo<$ExposureLogsTable, ExposureLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExposureLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fearItemIdMeta = const VerificationMeta(
    'fearItemId',
  );
  @override
  late final GeneratedColumn<String> fearItemId = GeneratedColumn<String>(
    'fear_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptMeta = const VerificationMeta(
    'attempt',
  );
  @override
  late final GeneratedColumn<String> attempt = GeneratedColumn<String>(
    'attempt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _predictionMeta = const VerificationMeta(
    'prediction',
  );
  @override
  late final GeneratedColumn<String> prediction = GeneratedColumn<String>(
    'prediction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fearBeforeMeta = const VerificationMeta(
    'fearBefore',
  );
  @override
  late final GeneratedColumn<int> fearBefore = GeneratedColumn<int>(
    'fear_before',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fearAfterMeta = const VerificationMeta(
    'fearAfter',
  );
  @override
  late final GeneratedColumn<int> fearAfter = GeneratedColumn<int>(
    'fear_after',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nothingBadMeta = const VerificationMeta(
    'nothingBad',
  );
  @override
  late final GeneratedColumn<bool> nothingBad = GeneratedColumn<bool>(
    'nothing_bad',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("nothing_bad" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    fearItemId,
    date,
    attempt,
    prediction,
    outcome,
    fearBefore,
    fearAfter,
    nothingBad,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exposure_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExposureLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fear_item_id')) {
      context.handle(
        _fearItemIdMeta,
        fearItemId.isAcceptableOrUnknown(
          data['fear_item_id']!,
          _fearItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fearItemIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('attempt')) {
      context.handle(
        _attemptMeta,
        attempt.isAcceptableOrUnknown(data['attempt']!, _attemptMeta),
      );
    }
    if (data.containsKey('prediction')) {
      context.handle(
        _predictionMeta,
        prediction.isAcceptableOrUnknown(data['prediction']!, _predictionMeta),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('fear_before')) {
      context.handle(
        _fearBeforeMeta,
        fearBefore.isAcceptableOrUnknown(data['fear_before']!, _fearBeforeMeta),
      );
    }
    if (data.containsKey('fear_after')) {
      context.handle(
        _fearAfterMeta,
        fearAfter.isAcceptableOrUnknown(data['fear_after']!, _fearAfterMeta),
      );
    }
    if (data.containsKey('nothing_bad')) {
      context.handle(
        _nothingBadMeta,
        nothingBad.isAcceptableOrUnknown(data['nothing_bad']!, _nothingBadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExposureLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExposureLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fearItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fear_item_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      attempt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt'],
      ),
      prediction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prediction'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      ),
      fearBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fear_before'],
      ),
      fearAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fear_after'],
      ),
      nothingBad: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}nothing_bad'],
      )!,
    );
  }

  @override
  $ExposureLogsTable createAlias(String alias) {
    return $ExposureLogsTable(attachedDatabase, alias);
  }
}

class ExposureLog extends DataClass implements Insertable<ExposureLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;
  final String fearItemId;
  final String date;

  /// The small form tried, e.g. "two steps holding the rail".
  final String? attempt;
  final String? prediction;
  final String? outcome;
  final int? fearBefore;
  final int? fearAfter;

  /// "I did it and nothing bad happened" — the evidence that changes the
  /// belief that pain means damage.
  final bool nothingBad;
  const ExposureLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.fearItemId,
    required this.date,
    this.attempt,
    this.prediction,
    this.outcome,
    this.fearBefore,
    this.fearAfter,
    required this.nothingBad,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['fear_item_id'] = Variable<String>(fearItemId);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || attempt != null) {
      map['attempt'] = Variable<String>(attempt);
    }
    if (!nullToAbsent || prediction != null) {
      map['prediction'] = Variable<String>(prediction);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || fearBefore != null) {
      map['fear_before'] = Variable<int>(fearBefore);
    }
    if (!nullToAbsent || fearAfter != null) {
      map['fear_after'] = Variable<int>(fearAfter);
    }
    map['nothing_bad'] = Variable<bool>(nothingBad);
    return map;
  }

  ExposureLogsCompanion toCompanion(bool nullToAbsent) {
    return ExposureLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      fearItemId: Value(fearItemId),
      date: Value(date),
      attempt: attempt == null && nullToAbsent
          ? const Value.absent()
          : Value(attempt),
      prediction: prediction == null && nullToAbsent
          ? const Value.absent()
          : Value(prediction),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      fearBefore: fearBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(fearBefore),
      fearAfter: fearAfter == null && nullToAbsent
          ? const Value.absent()
          : Value(fearAfter),
      nothingBad: Value(nothingBad),
    );
  }

  factory ExposureLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExposureLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      fearItemId: serializer.fromJson<String>(json['fearItemId']),
      date: serializer.fromJson<String>(json['date']),
      attempt: serializer.fromJson<String?>(json['attempt']),
      prediction: serializer.fromJson<String?>(json['prediction']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      fearBefore: serializer.fromJson<int?>(json['fearBefore']),
      fearAfter: serializer.fromJson<int?>(json['fearAfter']),
      nothingBad: serializer.fromJson<bool>(json['nothingBad']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'fearItemId': serializer.toJson<String>(fearItemId),
      'date': serializer.toJson<String>(date),
      'attempt': serializer.toJson<String?>(attempt),
      'prediction': serializer.toJson<String?>(prediction),
      'outcome': serializer.toJson<String?>(outcome),
      'fearBefore': serializer.toJson<int?>(fearBefore),
      'fearAfter': serializer.toJson<int?>(fearAfter),
      'nothingBad': serializer.toJson<bool>(nothingBad),
    };
  }

  ExposureLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? fearItemId,
    String? date,
    Value<String?> attempt = const Value.absent(),
    Value<String?> prediction = const Value.absent(),
    Value<String?> outcome = const Value.absent(),
    Value<int?> fearBefore = const Value.absent(),
    Value<int?> fearAfter = const Value.absent(),
    bool? nothingBad,
  }) => ExposureLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    fearItemId: fearItemId ?? this.fearItemId,
    date: date ?? this.date,
    attempt: attempt.present ? attempt.value : this.attempt,
    prediction: prediction.present ? prediction.value : this.prediction,
    outcome: outcome.present ? outcome.value : this.outcome,
    fearBefore: fearBefore.present ? fearBefore.value : this.fearBefore,
    fearAfter: fearAfter.present ? fearAfter.value : this.fearAfter,
    nothingBad: nothingBad ?? this.nothingBad,
  );
  ExposureLog copyWithCompanion(ExposureLogsCompanion data) {
    return ExposureLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      fearItemId: data.fearItemId.present
          ? data.fearItemId.value
          : this.fearItemId,
      date: data.date.present ? data.date.value : this.date,
      attempt: data.attempt.present ? data.attempt.value : this.attempt,
      prediction: data.prediction.present
          ? data.prediction.value
          : this.prediction,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      fearBefore: data.fearBefore.present
          ? data.fearBefore.value
          : this.fearBefore,
      fearAfter: data.fearAfter.present ? data.fearAfter.value : this.fearAfter,
      nothingBad: data.nothingBad.present
          ? data.nothingBad.value
          : this.nothingBad,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExposureLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('fearItemId: $fearItemId, ')
          ..write('date: $date, ')
          ..write('attempt: $attempt, ')
          ..write('prediction: $prediction, ')
          ..write('outcome: $outcome, ')
          ..write('fearBefore: $fearBefore, ')
          ..write('fearAfter: $fearAfter, ')
          ..write('nothingBad: $nothingBad')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    fearItemId,
    date,
    attempt,
    prediction,
    outcome,
    fearBefore,
    fearAfter,
    nothingBad,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExposureLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.fearItemId == this.fearItemId &&
          other.date == this.date &&
          other.attempt == this.attempt &&
          other.prediction == this.prediction &&
          other.outcome == this.outcome &&
          other.fearBefore == this.fearBefore &&
          other.fearAfter == this.fearAfter &&
          other.nothingBad == this.nothingBad);
}

class ExposureLogsCompanion extends UpdateCompanion<ExposureLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> fearItemId;
  final Value<String> date;
  final Value<String?> attempt;
  final Value<String?> prediction;
  final Value<String?> outcome;
  final Value<int?> fearBefore;
  final Value<int?> fearAfter;
  final Value<bool> nothingBad;
  final Value<int> rowid;
  const ExposureLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.fearItemId = const Value.absent(),
    this.date = const Value.absent(),
    this.attempt = const Value.absent(),
    this.prediction = const Value.absent(),
    this.outcome = const Value.absent(),
    this.fearBefore = const Value.absent(),
    this.fearAfter = const Value.absent(),
    this.nothingBad = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExposureLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String fearItemId,
    required String date,
    this.attempt = const Value.absent(),
    this.prediction = const Value.absent(),
    this.outcome = const Value.absent(),
    this.fearBefore = const Value.absent(),
    this.fearAfter = const Value.absent(),
    this.nothingBad = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       fearItemId = Value(fearItemId),
       date = Value(date);
  static Insertable<ExposureLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? fearItemId,
    Expression<String>? date,
    Expression<String>? attempt,
    Expression<String>? prediction,
    Expression<String>? outcome,
    Expression<int>? fearBefore,
    Expression<int>? fearAfter,
    Expression<bool>? nothingBad,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (fearItemId != null) 'fear_item_id': fearItemId,
      if (date != null) 'date': date,
      if (attempt != null) 'attempt': attempt,
      if (prediction != null) 'prediction': prediction,
      if (outcome != null) 'outcome': outcome,
      if (fearBefore != null) 'fear_before': fearBefore,
      if (fearAfter != null) 'fear_after': fearAfter,
      if (nothingBad != null) 'nothing_bad': nothingBad,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExposureLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? fearItemId,
    Value<String>? date,
    Value<String?>? attempt,
    Value<String?>? prediction,
    Value<String?>? outcome,
    Value<int?>? fearBefore,
    Value<int?>? fearAfter,
    Value<bool>? nothingBad,
    Value<int>? rowid,
  }) {
    return ExposureLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      fearItemId: fearItemId ?? this.fearItemId,
      date: date ?? this.date,
      attempt: attempt ?? this.attempt,
      prediction: prediction ?? this.prediction,
      outcome: outcome ?? this.outcome,
      fearBefore: fearBefore ?? this.fearBefore,
      fearAfter: fearAfter ?? this.fearAfter,
      nothingBad: nothingBad ?? this.nothingBad,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fearItemId.present) {
      map['fear_item_id'] = Variable<String>(fearItemId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (attempt.present) {
      map['attempt'] = Variable<String>(attempt.value);
    }
    if (prediction.present) {
      map['prediction'] = Variable<String>(prediction.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (fearBefore.present) {
      map['fear_before'] = Variable<int>(fearBefore.value);
    }
    if (fearAfter.present) {
      map['fear_after'] = Variable<int>(fearAfter.value);
    }
    if (nothingBad.present) {
      map['nothing_bad'] = Variable<bool>(nothingBad.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExposureLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('fearItemId: $fearItemId, ')
          ..write('date: $date, ')
          ..write('attempt: $attempt, ')
          ..write('prediction: $prediction, ')
          ..write('outcome: $outcome, ')
          ..write('fearBefore: $fearBefore, ')
          ..write('fearAfter: $fearAfter, ')
          ..write('nothingBad: $nothingBad, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StandTestsTable extends StandTests
    with TableInfo<$StandTestsTable, StandTest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StandTestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baselinePositionMeta = const VerificationMeta(
    'baselinePosition',
  );
  @override
  late final GeneratedColumn<String> baselinePosition = GeneratedColumn<String>(
    'baseline_position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('lying'),
  );
  static const VerificationMeta _baselineHrMeta = const VerificationMeta(
    'baselineHr',
  );
  @override
  late final GeneratedColumn<int> baselineHr = GeneratedColumn<int>(
    'baseline_hr',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baselineSysMeta = const VerificationMeta(
    'baselineSys',
  );
  @override
  late final GeneratedColumn<int> baselineSys = GeneratedColumn<int>(
    'baseline_sys',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baselineDiaMeta = const VerificationMeta(
    'baselineDia',
  );
  @override
  late final GeneratedColumn<int> baselineDia = GeneratedColumn<int>(
    'baseline_dia',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hr1Meta = const VerificationMeta('hr1');
  @override
  late final GeneratedColumn<int> hr1 = GeneratedColumn<int>(
    'hr1',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sys1Meta = const VerificationMeta('sys1');
  @override
  late final GeneratedColumn<int> sys1 = GeneratedColumn<int>(
    'sys1',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dia1Meta = const VerificationMeta('dia1');
  @override
  late final GeneratedColumn<int> dia1 = GeneratedColumn<int>(
    'dia1',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hr3Meta = const VerificationMeta('hr3');
  @override
  late final GeneratedColumn<int> hr3 = GeneratedColumn<int>(
    'hr3',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sys3Meta = const VerificationMeta('sys3');
  @override
  late final GeneratedColumn<int> sys3 = GeneratedColumn<int>(
    'sys3',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dia3Meta = const VerificationMeta('dia3');
  @override
  late final GeneratedColumn<int> dia3 = GeneratedColumn<int>(
    'dia3',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hr10Meta = const VerificationMeta('hr10');
  @override
  late final GeneratedColumn<int> hr10 = GeneratedColumn<int>(
    'hr10',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sys10Meta = const VerificationMeta('sys10');
  @override
  late final GeneratedColumn<int> sys10 = GeneratedColumn<int>(
    'sys10',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dia10Meta = const VerificationMeta('dia10');
  @override
  late final GeneratedColumn<int> dia10 = GeneratedColumn<int>(
    'dia10',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
    'symptoms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _stoppedEarlyMeta = const VerificationMeta(
    'stoppedEarly',
  );
  @override
  late final GeneratedColumn<bool> stoppedEarly = GeneratedColumn<bool>(
    'stopped_early',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("stopped_early" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    startedAt,
    baselinePosition,
    baselineHr,
    baselineSys,
    baselineDia,
    hr1,
    sys1,
    dia1,
    hr3,
    sys3,
    dia3,
    hr10,
    sys10,
    dia10,
    symptoms,
    stoppedEarly,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stand_tests';
  @override
  VerificationContext validateIntegrity(
    Insertable<StandTest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('baseline_position')) {
      context.handle(
        _baselinePositionMeta,
        baselinePosition.isAcceptableOrUnknown(
          data['baseline_position']!,
          _baselinePositionMeta,
        ),
      );
    }
    if (data.containsKey('baseline_hr')) {
      context.handle(
        _baselineHrMeta,
        baselineHr.isAcceptableOrUnknown(data['baseline_hr']!, _baselineHrMeta),
      );
    }
    if (data.containsKey('baseline_sys')) {
      context.handle(
        _baselineSysMeta,
        baselineSys.isAcceptableOrUnknown(
          data['baseline_sys']!,
          _baselineSysMeta,
        ),
      );
    }
    if (data.containsKey('baseline_dia')) {
      context.handle(
        _baselineDiaMeta,
        baselineDia.isAcceptableOrUnknown(
          data['baseline_dia']!,
          _baselineDiaMeta,
        ),
      );
    }
    if (data.containsKey('hr1')) {
      context.handle(
        _hr1Meta,
        hr1.isAcceptableOrUnknown(data['hr1']!, _hr1Meta),
      );
    }
    if (data.containsKey('sys1')) {
      context.handle(
        _sys1Meta,
        sys1.isAcceptableOrUnknown(data['sys1']!, _sys1Meta),
      );
    }
    if (data.containsKey('dia1')) {
      context.handle(
        _dia1Meta,
        dia1.isAcceptableOrUnknown(data['dia1']!, _dia1Meta),
      );
    }
    if (data.containsKey('hr3')) {
      context.handle(
        _hr3Meta,
        hr3.isAcceptableOrUnknown(data['hr3']!, _hr3Meta),
      );
    }
    if (data.containsKey('sys3')) {
      context.handle(
        _sys3Meta,
        sys3.isAcceptableOrUnknown(data['sys3']!, _sys3Meta),
      );
    }
    if (data.containsKey('dia3')) {
      context.handle(
        _dia3Meta,
        dia3.isAcceptableOrUnknown(data['dia3']!, _dia3Meta),
      );
    }
    if (data.containsKey('hr10')) {
      context.handle(
        _hr10Meta,
        hr10.isAcceptableOrUnknown(data['hr10']!, _hr10Meta),
      );
    }
    if (data.containsKey('sys10')) {
      context.handle(
        _sys10Meta,
        sys10.isAcceptableOrUnknown(data['sys10']!, _sys10Meta),
      );
    }
    if (data.containsKey('dia10')) {
      context.handle(
        _dia10Meta,
        dia10.isAcceptableOrUnknown(data['dia10']!, _dia10Meta),
      );
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    }
    if (data.containsKey('stopped_early')) {
      context.handle(
        _stoppedEarlyMeta,
        stoppedEarly.isAcceptableOrUnknown(
          data['stopped_early']!,
          _stoppedEarlyMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StandTest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandTest(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}started_at'],
      )!,
      baselinePosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}baseline_position'],
      )!,
      baselineHr: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baseline_hr'],
      ),
      baselineSys: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baseline_sys'],
      ),
      baselineDia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}baseline_dia'],
      ),
      hr1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hr1'],
      ),
      sys1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sys1'],
      ),
      dia1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia1'],
      ),
      hr3: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hr3'],
      ),
      sys3: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sys3'],
      ),
      dia3: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia3'],
      ),
      hr10: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hr10'],
      ),
      sys10: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sys10'],
      ),
      dia10: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dia10'],
      ),
      symptoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms'],
      )!,
      stoppedEarly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}stopped_early'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $StandTestsTable createAlias(String alias) {
    return $StandTestsTable(attachedDatabase, alias);
  }
}

class StandTest extends DataClass implements Insertable<StandTest> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;

  /// yyyy-MM-dd.
  final String date;

  /// ISO time the person stood up.
  final String startedAt;

  /// 'lying' or 'sitting' for the baseline.
  final String baselinePosition;
  final int? baselineHr;
  final int? baselineSys;
  final int? baselineDia;
  final int? hr1;
  final int? sys1;
  final int? dia1;
  final int? hr3;
  final int? sys3;
  final int? dia3;
  final int? hr10;
  final int? sys10;
  final int? dia10;

  /// JSON list of symptom keys felt while standing.
  final String symptoms;

  /// True when "Stop test" ended it before 10 minutes.
  final bool stoppedEarly;
  final String? note;
  const StandTest({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.startedAt,
    required this.baselinePosition,
    this.baselineHr,
    this.baselineSys,
    this.baselineDia,
    this.hr1,
    this.sys1,
    this.dia1,
    this.hr3,
    this.sys3,
    this.dia3,
    this.hr10,
    this.sys10,
    this.dia10,
    required this.symptoms,
    required this.stoppedEarly,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['started_at'] = Variable<String>(startedAt);
    map['baseline_position'] = Variable<String>(baselinePosition);
    if (!nullToAbsent || baselineHr != null) {
      map['baseline_hr'] = Variable<int>(baselineHr);
    }
    if (!nullToAbsent || baselineSys != null) {
      map['baseline_sys'] = Variable<int>(baselineSys);
    }
    if (!nullToAbsent || baselineDia != null) {
      map['baseline_dia'] = Variable<int>(baselineDia);
    }
    if (!nullToAbsent || hr1 != null) {
      map['hr1'] = Variable<int>(hr1);
    }
    if (!nullToAbsent || sys1 != null) {
      map['sys1'] = Variable<int>(sys1);
    }
    if (!nullToAbsent || dia1 != null) {
      map['dia1'] = Variable<int>(dia1);
    }
    if (!nullToAbsent || hr3 != null) {
      map['hr3'] = Variable<int>(hr3);
    }
    if (!nullToAbsent || sys3 != null) {
      map['sys3'] = Variable<int>(sys3);
    }
    if (!nullToAbsent || dia3 != null) {
      map['dia3'] = Variable<int>(dia3);
    }
    if (!nullToAbsent || hr10 != null) {
      map['hr10'] = Variable<int>(hr10);
    }
    if (!nullToAbsent || sys10 != null) {
      map['sys10'] = Variable<int>(sys10);
    }
    if (!nullToAbsent || dia10 != null) {
      map['dia10'] = Variable<int>(dia10);
    }
    map['symptoms'] = Variable<String>(symptoms);
    map['stopped_early'] = Variable<bool>(stoppedEarly);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  StandTestsCompanion toCompanion(bool nullToAbsent) {
    return StandTestsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      startedAt: Value(startedAt),
      baselinePosition: Value(baselinePosition),
      baselineHr: baselineHr == null && nullToAbsent
          ? const Value.absent()
          : Value(baselineHr),
      baselineSys: baselineSys == null && nullToAbsent
          ? const Value.absent()
          : Value(baselineSys),
      baselineDia: baselineDia == null && nullToAbsent
          ? const Value.absent()
          : Value(baselineDia),
      hr1: hr1 == null && nullToAbsent ? const Value.absent() : Value(hr1),
      sys1: sys1 == null && nullToAbsent ? const Value.absent() : Value(sys1),
      dia1: dia1 == null && nullToAbsent ? const Value.absent() : Value(dia1),
      hr3: hr3 == null && nullToAbsent ? const Value.absent() : Value(hr3),
      sys3: sys3 == null && nullToAbsent ? const Value.absent() : Value(sys3),
      dia3: dia3 == null && nullToAbsent ? const Value.absent() : Value(dia3),
      hr10: hr10 == null && nullToAbsent ? const Value.absent() : Value(hr10),
      sys10: sys10 == null && nullToAbsent
          ? const Value.absent()
          : Value(sys10),
      dia10: dia10 == null && nullToAbsent
          ? const Value.absent()
          : Value(dia10),
      symptoms: Value(symptoms),
      stoppedEarly: Value(stoppedEarly),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory StandTest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandTest(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      baselinePosition: serializer.fromJson<String>(json['baselinePosition']),
      baselineHr: serializer.fromJson<int?>(json['baselineHr']),
      baselineSys: serializer.fromJson<int?>(json['baselineSys']),
      baselineDia: serializer.fromJson<int?>(json['baselineDia']),
      hr1: serializer.fromJson<int?>(json['hr1']),
      sys1: serializer.fromJson<int?>(json['sys1']),
      dia1: serializer.fromJson<int?>(json['dia1']),
      hr3: serializer.fromJson<int?>(json['hr3']),
      sys3: serializer.fromJson<int?>(json['sys3']),
      dia3: serializer.fromJson<int?>(json['dia3']),
      hr10: serializer.fromJson<int?>(json['hr10']),
      sys10: serializer.fromJson<int?>(json['sys10']),
      dia10: serializer.fromJson<int?>(json['dia10']),
      symptoms: serializer.fromJson<String>(json['symptoms']),
      stoppedEarly: serializer.fromJson<bool>(json['stoppedEarly']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'startedAt': serializer.toJson<String>(startedAt),
      'baselinePosition': serializer.toJson<String>(baselinePosition),
      'baselineHr': serializer.toJson<int?>(baselineHr),
      'baselineSys': serializer.toJson<int?>(baselineSys),
      'baselineDia': serializer.toJson<int?>(baselineDia),
      'hr1': serializer.toJson<int?>(hr1),
      'sys1': serializer.toJson<int?>(sys1),
      'dia1': serializer.toJson<int?>(dia1),
      'hr3': serializer.toJson<int?>(hr3),
      'sys3': serializer.toJson<int?>(sys3),
      'dia3': serializer.toJson<int?>(dia3),
      'hr10': serializer.toJson<int?>(hr10),
      'sys10': serializer.toJson<int?>(sys10),
      'dia10': serializer.toJson<int?>(dia10),
      'symptoms': serializer.toJson<String>(symptoms),
      'stoppedEarly': serializer.toJson<bool>(stoppedEarly),
      'note': serializer.toJson<String?>(note),
    };
  }

  StandTest copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? startedAt,
    String? baselinePosition,
    Value<int?> baselineHr = const Value.absent(),
    Value<int?> baselineSys = const Value.absent(),
    Value<int?> baselineDia = const Value.absent(),
    Value<int?> hr1 = const Value.absent(),
    Value<int?> sys1 = const Value.absent(),
    Value<int?> dia1 = const Value.absent(),
    Value<int?> hr3 = const Value.absent(),
    Value<int?> sys3 = const Value.absent(),
    Value<int?> dia3 = const Value.absent(),
    Value<int?> hr10 = const Value.absent(),
    Value<int?> sys10 = const Value.absent(),
    Value<int?> dia10 = const Value.absent(),
    String? symptoms,
    bool? stoppedEarly,
    Value<String?> note = const Value.absent(),
  }) => StandTest(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    startedAt: startedAt ?? this.startedAt,
    baselinePosition: baselinePosition ?? this.baselinePosition,
    baselineHr: baselineHr.present ? baselineHr.value : this.baselineHr,
    baselineSys: baselineSys.present ? baselineSys.value : this.baselineSys,
    baselineDia: baselineDia.present ? baselineDia.value : this.baselineDia,
    hr1: hr1.present ? hr1.value : this.hr1,
    sys1: sys1.present ? sys1.value : this.sys1,
    dia1: dia1.present ? dia1.value : this.dia1,
    hr3: hr3.present ? hr3.value : this.hr3,
    sys3: sys3.present ? sys3.value : this.sys3,
    dia3: dia3.present ? dia3.value : this.dia3,
    hr10: hr10.present ? hr10.value : this.hr10,
    sys10: sys10.present ? sys10.value : this.sys10,
    dia10: dia10.present ? dia10.value : this.dia10,
    symptoms: symptoms ?? this.symptoms,
    stoppedEarly: stoppedEarly ?? this.stoppedEarly,
    note: note.present ? note.value : this.note,
  );
  StandTest copyWithCompanion(StandTestsCompanion data) {
    return StandTest(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      baselinePosition: data.baselinePosition.present
          ? data.baselinePosition.value
          : this.baselinePosition,
      baselineHr: data.baselineHr.present
          ? data.baselineHr.value
          : this.baselineHr,
      baselineSys: data.baselineSys.present
          ? data.baselineSys.value
          : this.baselineSys,
      baselineDia: data.baselineDia.present
          ? data.baselineDia.value
          : this.baselineDia,
      hr1: data.hr1.present ? data.hr1.value : this.hr1,
      sys1: data.sys1.present ? data.sys1.value : this.sys1,
      dia1: data.dia1.present ? data.dia1.value : this.dia1,
      hr3: data.hr3.present ? data.hr3.value : this.hr3,
      sys3: data.sys3.present ? data.sys3.value : this.sys3,
      dia3: data.dia3.present ? data.dia3.value : this.dia3,
      hr10: data.hr10.present ? data.hr10.value : this.hr10,
      sys10: data.sys10.present ? data.sys10.value : this.sys10,
      dia10: data.dia10.present ? data.dia10.value : this.dia10,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      stoppedEarly: data.stoppedEarly.present
          ? data.stoppedEarly.value
          : this.stoppedEarly,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandTest(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('baselinePosition: $baselinePosition, ')
          ..write('baselineHr: $baselineHr, ')
          ..write('baselineSys: $baselineSys, ')
          ..write('baselineDia: $baselineDia, ')
          ..write('hr1: $hr1, ')
          ..write('sys1: $sys1, ')
          ..write('dia1: $dia1, ')
          ..write('hr3: $hr3, ')
          ..write('sys3: $sys3, ')
          ..write('dia3: $dia3, ')
          ..write('hr10: $hr10, ')
          ..write('sys10: $sys10, ')
          ..write('dia10: $dia10, ')
          ..write('symptoms: $symptoms, ')
          ..write('stoppedEarly: $stoppedEarly, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    updatedAt,
    deletedAt,
    id,
    date,
    startedAt,
    baselinePosition,
    baselineHr,
    baselineSys,
    baselineDia,
    hr1,
    sys1,
    dia1,
    hr3,
    sys3,
    dia3,
    hr10,
    sys10,
    dia10,
    symptoms,
    stoppedEarly,
    note,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandTest &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.startedAt == this.startedAt &&
          other.baselinePosition == this.baselinePosition &&
          other.baselineHr == this.baselineHr &&
          other.baselineSys == this.baselineSys &&
          other.baselineDia == this.baselineDia &&
          other.hr1 == this.hr1 &&
          other.sys1 == this.sys1 &&
          other.dia1 == this.dia1 &&
          other.hr3 == this.hr3 &&
          other.sys3 == this.sys3 &&
          other.dia3 == this.dia3 &&
          other.hr10 == this.hr10 &&
          other.sys10 == this.sys10 &&
          other.dia10 == this.dia10 &&
          other.symptoms == this.symptoms &&
          other.stoppedEarly == this.stoppedEarly &&
          other.note == this.note);
}

class StandTestsCompanion extends UpdateCompanion<StandTest> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> startedAt;
  final Value<String> baselinePosition;
  final Value<int?> baselineHr;
  final Value<int?> baselineSys;
  final Value<int?> baselineDia;
  final Value<int?> hr1;
  final Value<int?> sys1;
  final Value<int?> dia1;
  final Value<int?> hr3;
  final Value<int?> sys3;
  final Value<int?> dia3;
  final Value<int?> hr10;
  final Value<int?> sys10;
  final Value<int?> dia10;
  final Value<String> symptoms;
  final Value<bool> stoppedEarly;
  final Value<String?> note;
  final Value<int> rowid;
  const StandTestsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.baselinePosition = const Value.absent(),
    this.baselineHr = const Value.absent(),
    this.baselineSys = const Value.absent(),
    this.baselineDia = const Value.absent(),
    this.hr1 = const Value.absent(),
    this.sys1 = const Value.absent(),
    this.dia1 = const Value.absent(),
    this.hr3 = const Value.absent(),
    this.sys3 = const Value.absent(),
    this.dia3 = const Value.absent(),
    this.hr10 = const Value.absent(),
    this.sys10 = const Value.absent(),
    this.dia10 = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.stoppedEarly = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandTestsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String startedAt,
    this.baselinePosition = const Value.absent(),
    this.baselineHr = const Value.absent(),
    this.baselineSys = const Value.absent(),
    this.baselineDia = const Value.absent(),
    this.hr1 = const Value.absent(),
    this.sys1 = const Value.absent(),
    this.dia1 = const Value.absent(),
    this.hr3 = const Value.absent(),
    this.sys3 = const Value.absent(),
    this.dia3 = const Value.absent(),
    this.hr10 = const Value.absent(),
    this.sys10 = const Value.absent(),
    this.dia10 = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.stoppedEarly = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       startedAt = Value(startedAt);
  static Insertable<StandTest> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? startedAt,
    Expression<String>? baselinePosition,
    Expression<int>? baselineHr,
    Expression<int>? baselineSys,
    Expression<int>? baselineDia,
    Expression<int>? hr1,
    Expression<int>? sys1,
    Expression<int>? dia1,
    Expression<int>? hr3,
    Expression<int>? sys3,
    Expression<int>? dia3,
    Expression<int>? hr10,
    Expression<int>? sys10,
    Expression<int>? dia10,
    Expression<String>? symptoms,
    Expression<bool>? stoppedEarly,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (startedAt != null) 'started_at': startedAt,
      if (baselinePosition != null) 'baseline_position': baselinePosition,
      if (baselineHr != null) 'baseline_hr': baselineHr,
      if (baselineSys != null) 'baseline_sys': baselineSys,
      if (baselineDia != null) 'baseline_dia': baselineDia,
      if (hr1 != null) 'hr1': hr1,
      if (sys1 != null) 'sys1': sys1,
      if (dia1 != null) 'dia1': dia1,
      if (hr3 != null) 'hr3': hr3,
      if (sys3 != null) 'sys3': sys3,
      if (dia3 != null) 'dia3': dia3,
      if (hr10 != null) 'hr10': hr10,
      if (sys10 != null) 'sys10': sys10,
      if (dia10 != null) 'dia10': dia10,
      if (symptoms != null) 'symptoms': symptoms,
      if (stoppedEarly != null) 'stopped_early': stoppedEarly,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandTestsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? startedAt,
    Value<String>? baselinePosition,
    Value<int?>? baselineHr,
    Value<int?>? baselineSys,
    Value<int?>? baselineDia,
    Value<int?>? hr1,
    Value<int?>? sys1,
    Value<int?>? dia1,
    Value<int?>? hr3,
    Value<int?>? sys3,
    Value<int?>? dia3,
    Value<int?>? hr10,
    Value<int?>? sys10,
    Value<int?>? dia10,
    Value<String>? symptoms,
    Value<bool>? stoppedEarly,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return StandTestsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      startedAt: startedAt ?? this.startedAt,
      baselinePosition: baselinePosition ?? this.baselinePosition,
      baselineHr: baselineHr ?? this.baselineHr,
      baselineSys: baselineSys ?? this.baselineSys,
      baselineDia: baselineDia ?? this.baselineDia,
      hr1: hr1 ?? this.hr1,
      sys1: sys1 ?? this.sys1,
      dia1: dia1 ?? this.dia1,
      hr3: hr3 ?? this.hr3,
      sys3: sys3 ?? this.sys3,
      dia3: dia3 ?? this.dia3,
      hr10: hr10 ?? this.hr10,
      sys10: sys10 ?? this.sys10,
      dia10: dia10 ?? this.dia10,
      symptoms: symptoms ?? this.symptoms,
      stoppedEarly: stoppedEarly ?? this.stoppedEarly,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (baselinePosition.present) {
      map['baseline_position'] = Variable<String>(baselinePosition.value);
    }
    if (baselineHr.present) {
      map['baseline_hr'] = Variable<int>(baselineHr.value);
    }
    if (baselineSys.present) {
      map['baseline_sys'] = Variable<int>(baselineSys.value);
    }
    if (baselineDia.present) {
      map['baseline_dia'] = Variable<int>(baselineDia.value);
    }
    if (hr1.present) {
      map['hr1'] = Variable<int>(hr1.value);
    }
    if (sys1.present) {
      map['sys1'] = Variable<int>(sys1.value);
    }
    if (dia1.present) {
      map['dia1'] = Variable<int>(dia1.value);
    }
    if (hr3.present) {
      map['hr3'] = Variable<int>(hr3.value);
    }
    if (sys3.present) {
      map['sys3'] = Variable<int>(sys3.value);
    }
    if (dia3.present) {
      map['dia3'] = Variable<int>(dia3.value);
    }
    if (hr10.present) {
      map['hr10'] = Variable<int>(hr10.value);
    }
    if (sys10.present) {
      map['sys10'] = Variable<int>(sys10.value);
    }
    if (dia10.present) {
      map['dia10'] = Variable<int>(dia10.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (stoppedEarly.present) {
      map['stopped_early'] = Variable<bool>(stoppedEarly.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StandTestsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startedAt: $startedAt, ')
          ..write('baselinePosition: $baselinePosition, ')
          ..write('baselineHr: $baselineHr, ')
          ..write('baselineSys: $baselineSys, ')
          ..write('baselineDia: $baselineDia, ')
          ..write('hr1: $hr1, ')
          ..write('sys1: $sys1, ')
          ..write('dia1: $dia1, ')
          ..write('hr3: $hr3, ')
          ..write('sys3: $sys3, ')
          ..write('dia3: $dia3, ')
          ..write('hr10: $hr10, ')
          ..write('sys10: $sys10, ')
          ..write('dia10: $dia10, ')
          ..write('symptoms: $symptoms, ')
          ..write('stoppedEarly: $stoppedEarly, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SweatLogsTable extends SweatLogs
    with TableInfo<$SweatLogsTable, SweatLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SweatLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _kindsMeta = const VerificationMeta('kinds');
  @override
  late final GeneratedColumn<String> kinds = GeneratedColumn<String>(
    'kinds',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    kinds,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sweat_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SweatLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('kinds')) {
      context.handle(
        _kindsMeta,
        kinds.isAcceptableOrUnknown(data['kinds']!, _kindsMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SweatLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SweatLog(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      kinds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kinds'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SweatLogsTable createAlias(String alias) {
    return $SweatLogsTable(attachedDatabase, alias);
  }
}

class SweatLog extends DataClass implements Insertable<SweatLog> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;

  /// yyyy-MM-dd, one row per day.
  final String date;

  /// JSON list of [SweatKind] names.
  final String kinds;
  final String? note;
  const SweatLog({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.kinds,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['kinds'] = Variable<String>(kinds);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SweatLogsCompanion toCompanion(bool nullToAbsent) {
    return SweatLogsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      kinds: Value(kinds),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SweatLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SweatLog(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      kinds: serializer.fromJson<String>(json['kinds']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'kinds': serializer.toJson<String>(kinds),
      'note': serializer.toJson<String?>(note),
    };
  }

  SweatLog copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? kinds,
    Value<String?> note = const Value.absent(),
  }) => SweatLog(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    kinds: kinds ?? this.kinds,
    note: note.present ? note.value : this.note,
  );
  SweatLog copyWithCompanion(SweatLogsCompanion data) {
    return SweatLog(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      kinds: data.kinds.present ? data.kinds.value : this.kinds,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SweatLog(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('kinds: $kinds, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(updatedAt, deletedAt, id, date, kinds, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SweatLog &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.kinds == this.kinds &&
          other.note == this.note);
}

class SweatLogsCompanion extends UpdateCompanion<SweatLog> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> kinds;
  final Value<String?> note;
  final Value<int> rowid;
  const SweatLogsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.kinds = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SweatLogsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    this.kinds = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date);
  static Insertable<SweatLog> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? kinds,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (kinds != null) 'kinds': kinds,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SweatLogsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? kinds,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return SweatLogsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      kinds: kinds ?? this.kinds,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (kinds.present) {
      map['kinds'] = Variable<String>(kinds.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SweatLogsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('kinds: $kinds, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BloodPressureReadingsTable extends BloodPressureReadings
    with TableInfo<$BloodPressureReadingsTable, BloodPressureReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodPressureReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<String> takenAt = GeneratedColumn<String>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _systolicMeta = const VerificationMeta(
    'systolic',
  );
  @override
  late final GeneratedColumn<int> systolic = GeneratedColumn<int>(
    'systolic',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diastolicMeta = const VerificationMeta(
    'diastolic',
  );
  @override
  late final GeneratedColumn<int> diastolic = GeneratedColumn<int>(
    'diastolic',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  @override
  late final GeneratedColumn<int> pulse = GeneratedColumn<int>(
    'pulse',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sitting'),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    updatedAt,
    deletedAt,
    id,
    date,
    takenAt,
    systolic,
    diastolic,
    pulse,
    position,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_pressure_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodPressureReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    if (data.containsKey('systolic')) {
      context.handle(
        _systolicMeta,
        systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta),
      );
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(
        _diastolicMeta,
        diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta),
      );
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
        _pulseMeta,
        pulse.isAcceptableOrUnknown(data['pulse']!, _pulseMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodPressureReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodPressureReading(
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}taken_at'],
      )!,
      systolic: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}systolic'],
      )!,
      diastolic: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}diastolic'],
      )!,
      pulse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulse'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $BloodPressureReadingsTable createAlias(String alias) {
    return $BloodPressureReadingsTable(attachedDatabase, alias);
  }
}

class BloodPressureReading extends DataClass
    implements Insertable<BloodPressureReading> {
  final String updatedAt;
  final DateTime? deletedAt;
  final String id;

  /// yyyy-MM-dd.
  final String date;

  /// ISO time of the reading.
  final String takenAt;
  final int systolic;
  final int diastolic;

  /// The cuff's pulse reading, if it gave one.
  final int? pulse;

  /// 'sitting', 'lying' or 'standing'.
  final String position;
  final String? note;
  const BloodPressureReading({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.takenAt,
    required this.systolic,
    required this.diastolic,
    this.pulse,
    required this.position,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['taken_at'] = Variable<String>(takenAt);
    map['systolic'] = Variable<int>(systolic);
    map['diastolic'] = Variable<int>(diastolic);
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    map['position'] = Variable<String>(position);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  BloodPressureReadingsCompanion toCompanion(bool nullToAbsent) {
    return BloodPressureReadingsCompanion(
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      date: Value(date),
      takenAt: Value(takenAt),
      systolic: Value(systolic),
      diastolic: Value(diastolic),
      pulse: pulse == null && nullToAbsent
          ? const Value.absent()
          : Value(pulse),
      position: Value(position),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory BloodPressureReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodPressureReading(
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      takenAt: serializer.fromJson<String>(json['takenAt']),
      systolic: serializer.fromJson<int>(json['systolic']),
      diastolic: serializer.fromJson<int>(json['diastolic']),
      pulse: serializer.fromJson<int?>(json['pulse']),
      position: serializer.fromJson<String>(json['position']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'takenAt': serializer.toJson<String>(takenAt),
      'systolic': serializer.toJson<int>(systolic),
      'diastolic': serializer.toJson<int>(diastolic),
      'pulse': serializer.toJson<int?>(pulse),
      'position': serializer.toJson<String>(position),
      'note': serializer.toJson<String?>(note),
    };
  }

  BloodPressureReading copyWith({
    String? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? date,
    String? takenAt,
    int? systolic,
    int? diastolic,
    Value<int?> pulse = const Value.absent(),
    String? position,
    Value<String?> note = const Value.absent(),
  }) => BloodPressureReading(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    takenAt: takenAt ?? this.takenAt,
    systolic: systolic ?? this.systolic,
    diastolic: diastolic ?? this.diastolic,
    pulse: pulse.present ? pulse.value : this.pulse,
    position: position ?? this.position,
    note: note.present ? note.value : this.note,
  );
  BloodPressureReading copyWithCompanion(BloodPressureReadingsCompanion data) {
    return BloodPressureReading(
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      pulse: data.pulse.present ? data.pulse.value : this.pulse,
      position: data.position.present ? data.position.value : this.position,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureReading(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('takenAt: $takenAt, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('position: $position, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    updatedAt,
    deletedAt,
    id,
    date,
    takenAt,
    systolic,
    diastolic,
    pulse,
    position,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodPressureReading &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.date == this.date &&
          other.takenAt == this.takenAt &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.pulse == this.pulse &&
          other.position == this.position &&
          other.note == this.note);
}

class BloodPressureReadingsCompanion
    extends UpdateCompanion<BloodPressureReading> {
  final Value<String> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> date;
  final Value<String> takenAt;
  final Value<int> systolic;
  final Value<int> diastolic;
  final Value<int?> pulse;
  final Value<String> position;
  final Value<String?> note;
  final Value<int> rowid;
  const BloodPressureReadingsCompanion({
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.pulse = const Value.absent(),
    this.position = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BloodPressureReadingsCompanion.insert({
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    required String id,
    required String date,
    required String takenAt,
    required int systolic,
    required int diastolic,
    this.pulse = const Value.absent(),
    this.position = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : updatedAt = Value(updatedAt),
       id = Value(id),
       date = Value(date),
       takenAt = Value(takenAt),
       systolic = Value(systolic),
       diastolic = Value(diastolic);
  static Insertable<BloodPressureReading> custom({
    Expression<String>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? takenAt,
    Expression<int>? systolic,
    Expression<int>? diastolic,
    Expression<int>? pulse,
    Expression<String>? position,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (takenAt != null) 'taken_at': takenAt,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (pulse != null) 'pulse': pulse,
      if (position != null) 'position': position,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BloodPressureReadingsCompanion copyWith({
    Value<String>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? date,
    Value<String>? takenAt,
    Value<int>? systolic,
    Value<int>? diastolic,
    Value<int?>? pulse,
    Value<String>? position,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return BloodPressureReadingsCompanion(
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      date: date ?? this.date,
      takenAt: takenAt ?? this.takenAt,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      position: position ?? this.position,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<String>(takenAt.value);
    }
    if (systolic.present) {
      map['systolic'] = Variable<int>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<int>(diastolic.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureReadingsCompanion(')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('takenAt: $takenAt, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('position: $position, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyLogsTable dailyLogs = $DailyLogsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $CalisthenicsTable calisthenics = $CalisthenicsTable(this);
  late final $TherapiesTable therapies = $TherapiesTable(this);
  late final $LiquidLogsTable liquidLogs = $LiquidLogsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $WeatherCacheTable weatherCache = $WeatherCacheTable(this);
  late final $SorenessChecksTable sorenessChecks = $SorenessChecksTable(this);
  late final $CheckinsTable checkins = $CheckinsTable(this);
  late final $InjuriesTable injuries = $InjuriesTable(this);
  late final $TrainingPlansTable trainingPlans = $TrainingPlansTable(this);
  late final $PlanPhasesTable planPhases = $PlanPhasesTable(this);
  late final $PlanSessionsTable planSessions = $PlanSessionsTable(this);
  late final $PlanExercisesTable planExercises = $PlanExercisesTable(this);
  late final $PlanStepsTable planSteps = $PlanStepsTable(this);
  late final $PlanSessionLogsTable planSessionLogs = $PlanSessionLogsTable(
    this,
  );
  late final $PlanSetLogsTable planSetLogs = $PlanSetLogsTable(this);
  late final $PlanCheckinsTable planCheckins = $PlanCheckinsTable(this);
  late final $PlanTestsTable planTests = $PlanTestsTable(this);
  late final $PlanTestResultsTable planTestResults = $PlanTestResultsTable(
    this,
  );
  late final $FearItemsTable fearItems = $FearItemsTable(this);
  late final $ExposureLogsTable exposureLogs = $ExposureLogsTable(this);
  late final $StandTestsTable standTests = $StandTestsTable(this);
  late final $SweatLogsTable sweatLogs = $SweatLogsTable(this);
  late final $BloodPressureReadingsTable bloodPressureReadings =
      $BloodPressureReadingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dailyLogs,
    activities,
    calisthenics,
    therapies,
    liquidLogs,
    settings,
    weatherCache,
    sorenessChecks,
    checkins,
    injuries,
    trainingPlans,
    planPhases,
    planSessions,
    planExercises,
    planSteps,
    planSessionLogs,
    planSetLogs,
    planCheckins,
    planTests,
    planTestResults,
    fearItems,
    exposureLogs,
    standTests,
    sweatLogs,
    bloodPressureReadings,
  ];
}

typedef $$DailyLogsTableCreateCompanionBuilder =
    DailyLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<double?> fatPercentage,
      Value<int> waterMlRaw,
      Value<double> waterMlCredit,
      Value<double> proteinG,
      Value<double> creatineG,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> bracesUsed,
      Value<int?> braceComfort,
      Value<int> steps,
      Value<bool> isRestDay,
      Value<bool> isFlareDay,
      Value<double?> sleepHours,
      Value<String?> sleepQuality,
      Value<int?> sleepHeartRateMin,
      Value<int?> sleepHeartRateMax,
      Value<int?> restingHeartRate,
      Value<double?> hrvMs,
      Value<String?> stepsSource,
      Value<String?> sleepSource,
      Value<String?> heartSource,
      Value<int?> remSleepMin,
      Value<int?> deepSleepMin,
      Value<bool?> hadNightmares,
      Value<int> rowid,
    });
typedef $$DailyLogsTableUpdateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<double?> fatPercentage,
      Value<int> waterMlRaw,
      Value<double> waterMlCredit,
      Value<double> proteinG,
      Value<double> creatineG,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> bracesUsed,
      Value<int?> braceComfort,
      Value<int> steps,
      Value<bool> isRestDay,
      Value<bool> isFlareDay,
      Value<double?> sleepHours,
      Value<String?> sleepQuality,
      Value<int?> sleepHeartRateMin,
      Value<int?> sleepHeartRateMax,
      Value<int?> restingHeartRate,
      Value<double?> hrvMs,
      Value<String?> stepsSource,
      Value<String?> sleepSource,
      Value<String?> heartSource,
      Value<int?> remSleepMin,
      Value<int?> deepSleepMin,
      Value<bool?> hadNightmares,
      Value<int> rowid,
    });

class $$DailyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPercentage => $composableBuilder(
    column: $table.fatPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterMlRaw => $composableBuilder(
    column: $table.waterMlRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterMlCredit => $composableBuilder(
    column: $table.waterMlCredit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creatineG => $composableBuilder(
    column: $table.creatineG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bracesUsed => $composableBuilder(
    column: $table.bracesUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get braceComfort => $composableBuilder(
    column: $table.braceComfort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRestDay => $composableBuilder(
    column: $table.isRestDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFlareDay => $composableBuilder(
    column: $table.isFlareDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepHeartRateMin => $composableBuilder(
    column: $table.sleepHeartRateMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepHeartRateMax => $composableBuilder(
    column: $table.sleepHeartRateMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepsSource => $composableBuilder(
    column: $table.stepsSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sleepSource => $composableBuilder(
    column: $table.sleepSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heartSource => $composableBuilder(
    column: $table.heartSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remSleepMin => $composableBuilder(
    column: $table.remSleepMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deepSleepMin => $composableBuilder(
    column: $table.deepSleepMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hadNightmares => $composableBuilder(
    column: $table.hadNightmares,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPercentage => $composableBuilder(
    column: $table.fatPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterMlRaw => $composableBuilder(
    column: $table.waterMlRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterMlCredit => $composableBuilder(
    column: $table.waterMlCredit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creatineG => $composableBuilder(
    column: $table.creatineG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bracesUsed => $composableBuilder(
    column: $table.bracesUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get braceComfort => $composableBuilder(
    column: $table.braceComfort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRestDay => $composableBuilder(
    column: $table.isRestDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFlareDay => $composableBuilder(
    column: $table.isFlareDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepHeartRateMin => $composableBuilder(
    column: $table.sleepHeartRateMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepHeartRateMax => $composableBuilder(
    column: $table.sleepHeartRateMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrvMs => $composableBuilder(
    column: $table.hrvMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepsSource => $composableBuilder(
    column: $table.stepsSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sleepSource => $composableBuilder(
    column: $table.sleepSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heartSource => $composableBuilder(
    column: $table.heartSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remSleepMin => $composableBuilder(
    column: $table.remSleepMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deepSleepMin => $composableBuilder(
    column: $table.deepSleepMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hadNightmares => $composableBuilder(
    column: $table.hadNightmares,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get fatPercentage => $composableBuilder(
    column: $table.fatPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterMlRaw => $composableBuilder(
    column: $table.waterMlRaw,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterMlCredit => $composableBuilder(
    column: $table.waterMlCredit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get creatineG =>
      $composableBuilder(column: $table.creatineG, builder: (column) => column);

  GeneratedColumn<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bracesUsed => $composableBuilder(
    column: $table.bracesUsed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get braceComfort => $composableBuilder(
    column: $table.braceComfort,
    builder: (column) => column,
  );

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<bool> get isRestDay =>
      $composableBuilder(column: $table.isRestDay, builder: (column) => column);

  GeneratedColumn<bool> get isFlareDay => $composableBuilder(
    column: $table.isFlareDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sleepHours => $composableBuilder(
    column: $table.sleepHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepHeartRateMin => $composableBuilder(
    column: $table.sleepHeartRateMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepHeartRateMax => $composableBuilder(
    column: $table.sleepHeartRateMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restingHeartRate => $composableBuilder(
    column: $table.restingHeartRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hrvMs =>
      $composableBuilder(column: $table.hrvMs, builder: (column) => column);

  GeneratedColumn<String> get stepsSource => $composableBuilder(
    column: $table.stepsSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sleepSource => $composableBuilder(
    column: $table.sleepSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get heartSource => $composableBuilder(
    column: $table.heartSource,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remSleepMin => $composableBuilder(
    column: $table.remSleepMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deepSleepMin => $composableBuilder(
    column: $table.deepSleepMin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hadNightmares => $composableBuilder(
    column: $table.hadNightmares,
    builder: (column) => column,
  );
}

class $$DailyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyLogsTable,
          DailyLog,
          $$DailyLogsTableFilterComposer,
          $$DailyLogsTableOrderingComposer,
          $$DailyLogsTableAnnotationComposer,
          $$DailyLogsTableCreateCompanionBuilder,
          $$DailyLogsTableUpdateCompanionBuilder,
          (DailyLog, BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog>),
          DailyLog,
          PrefetchHooks Function()
        > {
  $$DailyLogsTableTableManager(_$AppDatabase db, $DailyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> fatPercentage = const Value.absent(),
                Value<int> waterMlRaw = const Value.absent(),
                Value<double> waterMlCredit = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> creatineG = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> bracesUsed = const Value.absent(),
                Value<int?> braceComfort = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<bool> isRestDay = const Value.absent(),
                Value<bool> isFlareDay = const Value.absent(),
                Value<double?> sleepHours = const Value.absent(),
                Value<String?> sleepQuality = const Value.absent(),
                Value<int?> sleepHeartRateMin = const Value.absent(),
                Value<int?> sleepHeartRateMax = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<double?> hrvMs = const Value.absent(),
                Value<String?> stepsSource = const Value.absent(),
                Value<String?> sleepSource = const Value.absent(),
                Value<String?> heartSource = const Value.absent(),
                Value<int?> remSleepMin = const Value.absent(),
                Value<int?> deepSleepMin = const Value.absent(),
                Value<bool?> hadNightmares = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                weightKg: weightKg,
                heightCm: heightCm,
                fatPercentage: fatPercentage,
                waterMlRaw: waterMlRaw,
                waterMlCredit: waterMlCredit,
                proteinG: proteinG,
                creatineG: creatineG,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                bracesUsed: bracesUsed,
                braceComfort: braceComfort,
                steps: steps,
                isRestDay: isRestDay,
                isFlareDay: isFlareDay,
                sleepHours: sleepHours,
                sleepQuality: sleepQuality,
                sleepHeartRateMin: sleepHeartRateMin,
                sleepHeartRateMax: sleepHeartRateMax,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                stepsSource: stepsSource,
                sleepSource: sleepSource,
                heartSource: heartSource,
                remSleepMin: remSleepMin,
                deepSleepMin: deepSleepMin,
                hadNightmares: hadNightmares,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> fatPercentage = const Value.absent(),
                Value<int> waterMlRaw = const Value.absent(),
                Value<double> waterMlCredit = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> creatineG = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> bracesUsed = const Value.absent(),
                Value<int?> braceComfort = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<bool> isRestDay = const Value.absent(),
                Value<bool> isFlareDay = const Value.absent(),
                Value<double?> sleepHours = const Value.absent(),
                Value<String?> sleepQuality = const Value.absent(),
                Value<int?> sleepHeartRateMin = const Value.absent(),
                Value<int?> sleepHeartRateMax = const Value.absent(),
                Value<int?> restingHeartRate = const Value.absent(),
                Value<double?> hrvMs = const Value.absent(),
                Value<String?> stepsSource = const Value.absent(),
                Value<String?> sleepSource = const Value.absent(),
                Value<String?> heartSource = const Value.absent(),
                Value<int?> remSleepMin = const Value.absent(),
                Value<int?> deepSleepMin = const Value.absent(),
                Value<bool?> hadNightmares = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                weightKg: weightKg,
                heightCm: heightCm,
                fatPercentage: fatPercentage,
                waterMlRaw: waterMlRaw,
                waterMlCredit: waterMlCredit,
                proteinG: proteinG,
                creatineG: creatineG,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                bracesUsed: bracesUsed,
                braceComfort: braceComfort,
                steps: steps,
                isRestDay: isRestDay,
                isFlareDay: isFlareDay,
                sleepHours: sleepHours,
                sleepQuality: sleepQuality,
                sleepHeartRateMin: sleepHeartRateMin,
                sleepHeartRateMax: sleepHeartRateMax,
                restingHeartRate: restingHeartRate,
                hrvMs: hrvMs,
                stepsSource: stepsSource,
                sleepSource: sleepSource,
                heartSource: heartSource,
                remSleepMin: remSleepMin,
                deepSleepMin: deepSleepMin,
                hadNightmares: hadNightmares,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyLogsTable,
      DailyLog,
      $$DailyLogsTableFilterComposer,
      $$DailyLogsTableOrderingComposer,
      $$DailyLogsTableAnnotationComposer,
      $$DailyLogsTableCreateCompanionBuilder,
      $$DailyLogsTableUpdateCompanionBuilder,
      (DailyLog, BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog>),
      DailyLog,
      PrefetchHooks Function()
    >;
typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String activityName,
      required int durationMin,
      Value<double> extraWeightKg,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> source,
      Value<String?> healthkitUuid,
      Value<double?> metsAvg,
      Value<double?> activeEnergyKcal,
      Value<int?> heartRateMinBpm,
      Value<int?> heartRateMaxBpm,
      Value<int> rowid,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> activityName,
      Value<int> durationMin,
      Value<double> extraWeightKg,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> source,
      Value<String?> healthkitUuid,
      Value<double?> metsAvg,
      Value<double?> activeEnergyKcal,
      Value<int?> heartRateMinBpm,
      Value<int?> heartRateMaxBpm,
      Value<int> rowid,
    });

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get extraWeightKg => $composableBuilder(
    column: $table.extraWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthkitUuid => $composableBuilder(
    column: $table.healthkitUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get metsAvg => $composableBuilder(
    column: $table.metsAvg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get activeEnergyKcal => $composableBuilder(
    column: $table.activeEnergyKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get extraWeightKg => $composableBuilder(
    column: $table.extraWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthkitUuid => $composableBuilder(
    column: $table.healthkitUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get metsAvg => $composableBuilder(
    column: $table.metsAvg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get activeEnergyKcal => $composableBuilder(
    column: $table.activeEnergyKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get activityName => $composableBuilder(
    column: $table.activityName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get extraWeightKg => $composableBuilder(
    column: $table.extraWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get healthkitUuid => $composableBuilder(
    column: $table.healthkitUuid,
    builder: (column) => column,
  );

  GeneratedColumn<double> get metsAvg =>
      $composableBuilder(column: $table.metsAvg, builder: (column) => column);

  GeneratedColumn<double> get activeEnergyKcal => $composableBuilder(
    column: $table.activeEnergyKcal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => column,
  );
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
          Activity,
          PrefetchHooks Function()
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> activityName = const Value.absent(),
                Value<int> durationMin = const Value.absent(),
                Value<double> extraWeightKg = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> healthkitUuid = const Value.absent(),
                Value<double?> metsAvg = const Value.absent(),
                Value<double?> activeEnergyKcal = const Value.absent(),
                Value<int?> heartRateMinBpm = const Value.absent(),
                Value<int?> heartRateMaxBpm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                activityName: activityName,
                durationMin: durationMin,
                extraWeightKg: extraWeightKg,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                source: source,
                healthkitUuid: healthkitUuid,
                metsAvg: metsAvg,
                activeEnergyKcal: activeEnergyKcal,
                heartRateMinBpm: heartRateMinBpm,
                heartRateMaxBpm: heartRateMaxBpm,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String activityName,
                required int durationMin,
                Value<double> extraWeightKg = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> healthkitUuid = const Value.absent(),
                Value<double?> metsAvg = const Value.absent(),
                Value<double?> activeEnergyKcal = const Value.absent(),
                Value<int?> heartRateMinBpm = const Value.absent(),
                Value<int?> heartRateMaxBpm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                activityName: activityName,
                durationMin: durationMin,
                extraWeightKg: extraWeightKg,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                source: source,
                healthkitUuid: healthkitUuid,
                metsAvg: metsAvg,
                activeEnergyKcal: activeEnergyKcal,
                heartRateMinBpm: heartRateMinBpm,
                heartRateMaxBpm: heartRateMaxBpm,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
      Activity,
      PrefetchHooks Function()
    >;
typedef $$CalisthenicsTableCreateCompanionBuilder =
    CalisthenicsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String exercise,
      required String progression,
      required int sets,
      required int reps,
      Value<String?> setValues,
      Value<String> unit,
      Value<double> comfortScore,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String?> contractionMode,
      Value<int?> heartRateMinBpm,
      Value<int?> heartRateMaxBpm,
      Value<int> rowid,
    });
typedef $$CalisthenicsTableUpdateCompanionBuilder =
    CalisthenicsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> exercise,
      Value<String> progression,
      Value<int> sets,
      Value<int> reps,
      Value<String?> setValues,
      Value<String> unit,
      Value<double> comfortScore,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String?> contractionMode,
      Value<int?> heartRateMinBpm,
      Value<int?> heartRateMaxBpm,
      Value<int> rowid,
    });

class $$CalisthenicsTableFilterComposer
    extends Composer<_$AppDatabase, $CalisthenicsTable> {
  $$CalisthenicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exercise => $composableBuilder(
    column: $table.exercise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get progression => $composableBuilder(
    column: $table.progression,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setValues => $composableBuilder(
    column: $table.setValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get comfortScore => $composableBuilder(
    column: $table.comfortScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contractionMode => $composableBuilder(
    column: $table.contractionMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CalisthenicsTableOrderingComposer
    extends Composer<_$AppDatabase, $CalisthenicsTable> {
  $$CalisthenicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exercise => $composableBuilder(
    column: $table.exercise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get progression => $composableBuilder(
    column: $table.progression,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setValues => $composableBuilder(
    column: $table.setValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get comfortScore => $composableBuilder(
    column: $table.comfortScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contractionMode => $composableBuilder(
    column: $table.contractionMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CalisthenicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CalisthenicsTable> {
  $$CalisthenicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get exercise =>
      $composableBuilder(column: $table.exercise, builder: (column) => column);

  GeneratedColumn<String> get progression => $composableBuilder(
    column: $table.progression,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<String> get setValues =>
      $composableBuilder(column: $table.setValues, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get comfortScore => $composableBuilder(
    column: $table.comfortScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contractionMode => $composableBuilder(
    column: $table.contractionMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRateMinBpm => $composableBuilder(
    column: $table.heartRateMinBpm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRateMaxBpm => $composableBuilder(
    column: $table.heartRateMaxBpm,
    builder: (column) => column,
  );
}

class $$CalisthenicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CalisthenicsTable,
          Calisthenic,
          $$CalisthenicsTableFilterComposer,
          $$CalisthenicsTableOrderingComposer,
          $$CalisthenicsTableAnnotationComposer,
          $$CalisthenicsTableCreateCompanionBuilder,
          $$CalisthenicsTableUpdateCompanionBuilder,
          (
            Calisthenic,
            BaseReferences<_$AppDatabase, $CalisthenicsTable, Calisthenic>,
          ),
          Calisthenic,
          PrefetchHooks Function()
        > {
  $$CalisthenicsTableTableManager(_$AppDatabase db, $CalisthenicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalisthenicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalisthenicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalisthenicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> exercise = const Value.absent(),
                Value<String> progression = const Value.absent(),
                Value<int> sets = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<String?> setValues = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> comfortScore = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String?> contractionMode = const Value.absent(),
                Value<int?> heartRateMinBpm = const Value.absent(),
                Value<int?> heartRateMaxBpm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalisthenicsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                exercise: exercise,
                progression: progression,
                sets: sets,
                reps: reps,
                setValues: setValues,
                unit: unit,
                comfortScore: comfortScore,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                contractionMode: contractionMode,
                heartRateMinBpm: heartRateMinBpm,
                heartRateMaxBpm: heartRateMaxBpm,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String exercise,
                required String progression,
                required int sets,
                required int reps,
                Value<String?> setValues = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> comfortScore = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String?> contractionMode = const Value.absent(),
                Value<int?> heartRateMinBpm = const Value.absent(),
                Value<int?> heartRateMaxBpm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CalisthenicsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                exercise: exercise,
                progression: progression,
                sets: sets,
                reps: reps,
                setValues: setValues,
                unit: unit,
                comfortScore: comfortScore,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                contractionMode: contractionMode,
                heartRateMinBpm: heartRateMinBpm,
                heartRateMaxBpm: heartRateMaxBpm,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CalisthenicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CalisthenicsTable,
      Calisthenic,
      $$CalisthenicsTableFilterComposer,
      $$CalisthenicsTableOrderingComposer,
      $$CalisthenicsTableAnnotationComposer,
      $$CalisthenicsTableCreateCompanionBuilder,
      $$CalisthenicsTableUpdateCompanionBuilder,
      (
        Calisthenic,
        BaseReferences<_$AppDatabase, $CalisthenicsTable, Calisthenic>,
      ),
      Calisthenic,
      PrefetchHooks Function()
    >;
typedef $$TherapiesTableCreateCompanionBuilder =
    TherapiesCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String therapyName,
      required int durationMin,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<int> rowid,
    });
typedef $$TherapiesTableUpdateCompanionBuilder =
    TherapiesCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> therapyName,
      Value<int> durationMin,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<int> rowid,
    });

class $$TherapiesTableFilterComposer
    extends Composer<_$AppDatabase, $TherapiesTable> {
  $$TherapiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get therapyName => $composableBuilder(
    column: $table.therapyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TherapiesTableOrderingComposer
    extends Composer<_$AppDatabase, $TherapiesTable> {
  $$TherapiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get therapyName => $composableBuilder(
    column: $table.therapyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TherapiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TherapiesTable> {
  $$TherapiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get therapyName => $composableBuilder(
    column: $table.therapyName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => column,
  );
}

class $$TherapiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TherapiesTable,
          Therapy,
          $$TherapiesTableFilterComposer,
          $$TherapiesTableOrderingComposer,
          $$TherapiesTableAnnotationComposer,
          $$TherapiesTableCreateCompanionBuilder,
          $$TherapiesTableUpdateCompanionBuilder,
          (Therapy, BaseReferences<_$AppDatabase, $TherapiesTable, Therapy>),
          Therapy,
          PrefetchHooks Function()
        > {
  $$TherapiesTableTableManager(_$AppDatabase db, $TherapiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TherapiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TherapiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TherapiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> therapyName = const Value.absent(),
                Value<int> durationMin = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TherapiesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                therapyName: therapyName,
                durationMin: durationMin,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String therapyName,
                required int durationMin,
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TherapiesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                therapyName: therapyName,
                durationMin: durationMin,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TherapiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TherapiesTable,
      Therapy,
      $$TherapiesTableFilterComposer,
      $$TherapiesTableOrderingComposer,
      $$TherapiesTableAnnotationComposer,
      $$TherapiesTableCreateCompanionBuilder,
      $$TherapiesTableUpdateCompanionBuilder,
      (Therapy, BaseReferences<_$AppDatabase, $TherapiesTable, Therapy>),
      Therapy,
      PrefetchHooks Function()
    >;
typedef $$LiquidLogsTableCreateCompanionBuilder =
    LiquidLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String drinkType,
      Value<String?> customDrinkLabel,
      required int amountMlRaw,
      required double hydrationMlCredit,
      Value<int> rowid,
    });
typedef $$LiquidLogsTableUpdateCompanionBuilder =
    LiquidLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> drinkType,
      Value<String?> customDrinkLabel,
      Value<int> amountMlRaw,
      Value<double> hydrationMlCredit,
      Value<int> rowid,
    });

class $$LiquidLogsTableFilterComposer
    extends Composer<_$AppDatabase, $LiquidLogsTable> {
  $$LiquidLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get drinkType => $composableBuilder(
    column: $table.drinkType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customDrinkLabel => $composableBuilder(
    column: $table.customDrinkLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMlRaw => $composableBuilder(
    column: $table.amountMlRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hydrationMlCredit => $composableBuilder(
    column: $table.hydrationMlCredit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LiquidLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $LiquidLogsTable> {
  $$LiquidLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get drinkType => $composableBuilder(
    column: $table.drinkType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customDrinkLabel => $composableBuilder(
    column: $table.customDrinkLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMlRaw => $composableBuilder(
    column: $table.amountMlRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hydrationMlCredit => $composableBuilder(
    column: $table.hydrationMlCredit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LiquidLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LiquidLogsTable> {
  $$LiquidLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get drinkType =>
      $composableBuilder(column: $table.drinkType, builder: (column) => column);

  GeneratedColumn<String> get customDrinkLabel => $composableBuilder(
    column: $table.customDrinkLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMlRaw => $composableBuilder(
    column: $table.amountMlRaw,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hydrationMlCredit => $composableBuilder(
    column: $table.hydrationMlCredit,
    builder: (column) => column,
  );
}

class $$LiquidLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LiquidLogsTable,
          LiquidLog,
          $$LiquidLogsTableFilterComposer,
          $$LiquidLogsTableOrderingComposer,
          $$LiquidLogsTableAnnotationComposer,
          $$LiquidLogsTableCreateCompanionBuilder,
          $$LiquidLogsTableUpdateCompanionBuilder,
          (
            LiquidLog,
            BaseReferences<_$AppDatabase, $LiquidLogsTable, LiquidLog>,
          ),
          LiquidLog,
          PrefetchHooks Function()
        > {
  $$LiquidLogsTableTableManager(_$AppDatabase db, $LiquidLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LiquidLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LiquidLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LiquidLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> drinkType = const Value.absent(),
                Value<String?> customDrinkLabel = const Value.absent(),
                Value<int> amountMlRaw = const Value.absent(),
                Value<double> hydrationMlCredit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LiquidLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                drinkType: drinkType,
                customDrinkLabel: customDrinkLabel,
                amountMlRaw: amountMlRaw,
                hydrationMlCredit: hydrationMlCredit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String drinkType,
                Value<String?> customDrinkLabel = const Value.absent(),
                required int amountMlRaw,
                required double hydrationMlCredit,
                Value<int> rowid = const Value.absent(),
              }) => LiquidLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                drinkType: drinkType,
                customDrinkLabel: customDrinkLabel,
                amountMlRaw: amountMlRaw,
                hydrationMlCredit: hydrationMlCredit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LiquidLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LiquidLogsTable,
      LiquidLog,
      $$LiquidLogsTableFilterComposer,
      $$LiquidLogsTableOrderingComposer,
      $$LiquidLogsTableAnnotationComposer,
      $$LiquidLogsTableCreateCompanionBuilder,
      $$LiquidLogsTableUpdateCompanionBuilder,
      (LiquidLog, BaseReferences<_$AppDatabase, $LiquidLogsTable, LiquidLog>),
      LiquidLog,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<String> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$WeatherCacheTableCreateCompanionBuilder =
    WeatherCacheCompanion Function({
      required String date,
      required double lat,
      required double lon,
      Value<double?> tempC,
      Value<double?> humidityPct,
      Value<double?> pressureHpa,
      Value<int> rowid,
    });
typedef $$WeatherCacheTableUpdateCompanionBuilder =
    WeatherCacheCompanion Function({
      Value<String> date,
      Value<double> lat,
      Value<double> lon,
      Value<double?> tempC,
      Value<double?> humidityPct,
      Value<double?> pressureHpa,
      Value<int> rowid,
    });

class $$WeatherCacheTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get humidityPct => $composableBuilder(
    column: $table.humidityPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeatherCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tempC => $composableBuilder(
    column: $table.tempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get humidityPct => $composableBuilder(
    column: $table.humidityPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherCacheTable> {
  $$WeatherCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get tempC =>
      $composableBuilder(column: $table.tempC, builder: (column) => column);

  GeneratedColumn<double> get humidityPct => $composableBuilder(
    column: $table.humidityPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pressureHpa => $composableBuilder(
    column: $table.pressureHpa,
    builder: (column) => column,
  );
}

class $$WeatherCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherCacheTable,
          WeatherCacheData,
          $$WeatherCacheTableFilterComposer,
          $$WeatherCacheTableOrderingComposer,
          $$WeatherCacheTableAnnotationComposer,
          $$WeatherCacheTableCreateCompanionBuilder,
          $$WeatherCacheTableUpdateCompanionBuilder,
          (
            WeatherCacheData,
            BaseReferences<_$AppDatabase, $WeatherCacheTable, WeatherCacheData>,
          ),
          WeatherCacheData,
          PrefetchHooks Function()
        > {
  $$WeatherCacheTableTableManager(_$AppDatabase db, $WeatherCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double?> tempC = const Value.absent(),
                Value<double?> humidityPct = const Value.absent(),
                Value<double?> pressureHpa = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeatherCacheCompanion(
                date: date,
                lat: lat,
                lon: lon,
                tempC: tempC,
                humidityPct: humidityPct,
                pressureHpa: pressureHpa,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required double lat,
                required double lon,
                Value<double?> tempC = const Value.absent(),
                Value<double?> humidityPct = const Value.absent(),
                Value<double?> pressureHpa = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeatherCacheCompanion.insert(
                date: date,
                lat: lat,
                lon: lon,
                tempC: tempC,
                humidityPct: humidityPct,
                pressureHpa: pressureHpa,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeatherCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherCacheTable,
      WeatherCacheData,
      $$WeatherCacheTableFilterComposer,
      $$WeatherCacheTableOrderingComposer,
      $$WeatherCacheTableAnnotationComposer,
      $$WeatherCacheTableCreateCompanionBuilder,
      $$WeatherCacheTableUpdateCompanionBuilder,
      (
        WeatherCacheData,
        BaseReferences<_$AppDatabase, $WeatherCacheTable, WeatherCacheData>,
      ),
      WeatherCacheData,
      PrefetchHooks Function()
    >;
typedef $$SorenessChecksTableCreateCompanionBuilder =
    SorenessChecksCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String onset,
      required String spread,
      required String trend,
      required String verdict,
      required String verdictLabel,
      Value<int> rowid,
    });
typedef $$SorenessChecksTableUpdateCompanionBuilder =
    SorenessChecksCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> onset,
      Value<String> spread,
      Value<String> trend,
      Value<String> verdict,
      Value<String> verdictLabel,
      Value<int> rowid,
    });

class $$SorenessChecksTableFilterComposer
    extends Composer<_$AppDatabase, $SorenessChecksTable> {
  $$SorenessChecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get onset => $composableBuilder(
    column: $table.onset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spread => $composableBuilder(
    column: $table.spread,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trend => $composableBuilder(
    column: $table.trend,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verdict => $composableBuilder(
    column: $table.verdict,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verdictLabel => $composableBuilder(
    column: $table.verdictLabel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SorenessChecksTableOrderingComposer
    extends Composer<_$AppDatabase, $SorenessChecksTable> {
  $$SorenessChecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get onset => $composableBuilder(
    column: $table.onset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spread => $composableBuilder(
    column: $table.spread,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trend => $composableBuilder(
    column: $table.trend,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verdict => $composableBuilder(
    column: $table.verdict,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verdictLabel => $composableBuilder(
    column: $table.verdictLabel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SorenessChecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SorenessChecksTable> {
  $$SorenessChecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get onset =>
      $composableBuilder(column: $table.onset, builder: (column) => column);

  GeneratedColumn<String> get spread =>
      $composableBuilder(column: $table.spread, builder: (column) => column);

  GeneratedColumn<String> get trend =>
      $composableBuilder(column: $table.trend, builder: (column) => column);

  GeneratedColumn<String> get verdict =>
      $composableBuilder(column: $table.verdict, builder: (column) => column);

  GeneratedColumn<String> get verdictLabel => $composableBuilder(
    column: $table.verdictLabel,
    builder: (column) => column,
  );
}

class $$SorenessChecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SorenessChecksTable,
          SorenessCheck,
          $$SorenessChecksTableFilterComposer,
          $$SorenessChecksTableOrderingComposer,
          $$SorenessChecksTableAnnotationComposer,
          $$SorenessChecksTableCreateCompanionBuilder,
          $$SorenessChecksTableUpdateCompanionBuilder,
          (
            SorenessCheck,
            BaseReferences<_$AppDatabase, $SorenessChecksTable, SorenessCheck>,
          ),
          SorenessCheck,
          PrefetchHooks Function()
        > {
  $$SorenessChecksTableTableManager(
    _$AppDatabase db,
    $SorenessChecksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SorenessChecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SorenessChecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SorenessChecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> onset = const Value.absent(),
                Value<String> spread = const Value.absent(),
                Value<String> trend = const Value.absent(),
                Value<String> verdict = const Value.absent(),
                Value<String> verdictLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SorenessChecksCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                onset: onset,
                spread: spread,
                trend: trend,
                verdict: verdict,
                verdictLabel: verdictLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String onset,
                required String spread,
                required String trend,
                required String verdict,
                required String verdictLabel,
                Value<int> rowid = const Value.absent(),
              }) => SorenessChecksCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                onset: onset,
                spread: spread,
                trend: trend,
                verdict: verdict,
                verdictLabel: verdictLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SorenessChecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SorenessChecksTable,
      SorenessCheck,
      $$SorenessChecksTableFilterComposer,
      $$SorenessChecksTableOrderingComposer,
      $$SorenessChecksTableAnnotationComposer,
      $$SorenessChecksTableCreateCompanionBuilder,
      $$SorenessChecksTableUpdateCompanionBuilder,
      (
        SorenessCheck,
        BaseReferences<_$AppDatabase, $SorenessChecksTable, SorenessCheck>,
      ),
      SorenessCheck,
      PrefetchHooks Function()
    >;
typedef $$CheckinsTableCreateCompanionBuilder =
    CheckinsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String loggedAt,
      required String mentalState,
      required String bodyFeeling,
      Value<String> note,
      Value<int> rowid,
    });
typedef $$CheckinsTableUpdateCompanionBuilder =
    CheckinsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> loggedAt,
      Value<String> mentalState,
      Value<String> bodyFeeling,
      Value<String> note,
      Value<int> rowid,
    });

class $$CheckinsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckinsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckinsTable> {
  $$CheckinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<String> get mentalState => $composableBuilder(
    column: $table.mentalState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyFeeling => $composableBuilder(
    column: $table.bodyFeeling,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$CheckinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckinsTable,
          Checkin,
          $$CheckinsTableFilterComposer,
          $$CheckinsTableOrderingComposer,
          $$CheckinsTableAnnotationComposer,
          $$CheckinsTableCreateCompanionBuilder,
          $$CheckinsTableUpdateCompanionBuilder,
          (Checkin, BaseReferences<_$AppDatabase, $CheckinsTable, Checkin>),
          Checkin,
          PrefetchHooks Function()
        > {
  $$CheckinsTableTableManager(_$AppDatabase db, $CheckinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> loggedAt = const Value.absent(),
                Value<String> mentalState = const Value.absent(),
                Value<String> bodyFeeling = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckinsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                loggedAt: loggedAt,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String loggedAt,
                required String mentalState,
                required String bodyFeeling,
                Value<String> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckinsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                loggedAt: loggedAt,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckinsTable,
      Checkin,
      $$CheckinsTableFilterComposer,
      $$CheckinsTableOrderingComposer,
      $$CheckinsTableAnnotationComposer,
      $$CheckinsTableCreateCompanionBuilder,
      $$CheckinsTableUpdateCompanionBuilder,
      (Checkin, BaseReferences<_$AppDatabase, $CheckinsTable, Checkin>),
      Checkin,
      PrefetchHooks Function()
    >;
typedef $$InjuriesTableCreateCompanionBuilder =
    InjuriesCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String dateStarted,
      required String zone,
      required String kind,
      required String type,
      Value<String> note,
      Value<String?> resolvedAt,
      Value<bool?> stillPainful,
      Value<String?> comparedToUsual,
      Value<int> rowid,
    });
typedef $$InjuriesTableUpdateCompanionBuilder =
    InjuriesCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> dateStarted,
      Value<String> zone,
      Value<String> kind,
      Value<String> type,
      Value<String> note,
      Value<String?> resolvedAt,
      Value<bool?> stillPainful,
      Value<String?> comparedToUsual,
      Value<int> rowid,
    });

class $$InjuriesTableFilterComposer
    extends Composer<_$AppDatabase, $InjuriesTable> {
  $$InjuriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateStarted => $composableBuilder(
    column: $table.dateStarted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zone => $composableBuilder(
    column: $table.zone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stillPainful => $composableBuilder(
    column: $table.stillPainful,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comparedToUsual => $composableBuilder(
    column: $table.comparedToUsual,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InjuriesTableOrderingComposer
    extends Composer<_$AppDatabase, $InjuriesTable> {
  $$InjuriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateStarted => $composableBuilder(
    column: $table.dateStarted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zone => $composableBuilder(
    column: $table.zone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stillPainful => $composableBuilder(
    column: $table.stillPainful,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comparedToUsual => $composableBuilder(
    column: $table.comparedToUsual,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InjuriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InjuriesTable> {
  $$InjuriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dateStarted => $composableBuilder(
    column: $table.dateStarted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get zone =>
      $composableBuilder(column: $table.zone, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get resolvedAt => $composableBuilder(
    column: $table.resolvedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get stillPainful => $composableBuilder(
    column: $table.stillPainful,
    builder: (column) => column,
  );

  GeneratedColumn<String> get comparedToUsual => $composableBuilder(
    column: $table.comparedToUsual,
    builder: (column) => column,
  );
}

class $$InjuriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InjuriesTable,
          Injury,
          $$InjuriesTableFilterComposer,
          $$InjuriesTableOrderingComposer,
          $$InjuriesTableAnnotationComposer,
          $$InjuriesTableCreateCompanionBuilder,
          $$InjuriesTableUpdateCompanionBuilder,
          (Injury, BaseReferences<_$AppDatabase, $InjuriesTable, Injury>),
          Injury,
          PrefetchHooks Function()
        > {
  $$InjuriesTableTableManager(_$AppDatabase db, $InjuriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InjuriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InjuriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InjuriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> dateStarted = const Value.absent(),
                Value<String> zone = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String?> resolvedAt = const Value.absent(),
                Value<bool?> stillPainful = const Value.absent(),
                Value<String?> comparedToUsual = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InjuriesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                dateStarted: dateStarted,
                zone: zone,
                kind: kind,
                type: type,
                note: note,
                resolvedAt: resolvedAt,
                stillPainful: stillPainful,
                comparedToUsual: comparedToUsual,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String dateStarted,
                required String zone,
                required String kind,
                required String type,
                Value<String> note = const Value.absent(),
                Value<String?> resolvedAt = const Value.absent(),
                Value<bool?> stillPainful = const Value.absent(),
                Value<String?> comparedToUsual = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InjuriesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                dateStarted: dateStarted,
                zone: zone,
                kind: kind,
                type: type,
                note: note,
                resolvedAt: resolvedAt,
                stillPainful: stillPainful,
                comparedToUsual: comparedToUsual,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InjuriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InjuriesTable,
      Injury,
      $$InjuriesTableFilterComposer,
      $$InjuriesTableOrderingComposer,
      $$InjuriesTableAnnotationComposer,
      $$InjuriesTableCreateCompanionBuilder,
      $$InjuriesTableUpdateCompanionBuilder,
      (Injury, BaseReferences<_$AppDatabase, $InjuriesTable, Injury>),
      Injury,
      PrefetchHooks Function()
    >;
typedef $$TrainingPlansTableCreateCompanionBuilder =
    TrainingPlansCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String startDate,
      Value<int> weeks,
      Value<int?> weeklyCeilingMin,
      Value<String?> floorNote,
      Value<String?> currentPhaseId,
      Value<String?> testWeeks,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$TrainingPlansTableUpdateCompanionBuilder =
    TrainingPlansCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> startDate,
      Value<int> weeks,
      Value<int?> weeklyCeilingMin,
      Value<String?> floorNote,
      Value<String?> currentPhaseId,
      Value<String?> testWeeks,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$TrainingPlansTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weeklyCeilingMin => $composableBuilder(
    column: $table.weeklyCeilingMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get floorNote => $composableBuilder(
    column: $table.floorNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentPhaseId => $composableBuilder(
    column: $table.currentPhaseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testWeeks => $composableBuilder(
    column: $table.testWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrainingPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeks => $composableBuilder(
    column: $table.weeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weeklyCeilingMin => $composableBuilder(
    column: $table.weeklyCeilingMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get floorNote => $composableBuilder(
    column: $table.floorNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentPhaseId => $composableBuilder(
    column: $table.currentPhaseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testWeeks => $composableBuilder(
    column: $table.testWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrainingPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingPlansTable> {
  $$TrainingPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get weeks =>
      $composableBuilder(column: $table.weeks, builder: (column) => column);

  GeneratedColumn<int> get weeklyCeilingMin => $composableBuilder(
    column: $table.weeklyCeilingMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get floorNote =>
      $composableBuilder(column: $table.floorNote, builder: (column) => column);

  GeneratedColumn<String> get currentPhaseId => $composableBuilder(
    column: $table.currentPhaseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get testWeeks =>
      $composableBuilder(column: $table.testWeeks, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$TrainingPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingPlansTable,
          TrainingPlan,
          $$TrainingPlansTableFilterComposer,
          $$TrainingPlansTableOrderingComposer,
          $$TrainingPlansTableAnnotationComposer,
          $$TrainingPlansTableCreateCompanionBuilder,
          $$TrainingPlansTableUpdateCompanionBuilder,
          (
            TrainingPlan,
            BaseReferences<_$AppDatabase, $TrainingPlansTable, TrainingPlan>,
          ),
          TrainingPlan,
          PrefetchHooks Function()
        > {
  $$TrainingPlansTableTableManager(_$AppDatabase db, $TrainingPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> startDate = const Value.absent(),
                Value<int> weeks = const Value.absent(),
                Value<int?> weeklyCeilingMin = const Value.absent(),
                Value<String?> floorNote = const Value.absent(),
                Value<String?> currentPhaseId = const Value.absent(),
                Value<String?> testWeeks = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingPlansCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                startDate: startDate,
                weeks: weeks,
                weeklyCeilingMin: weeklyCeilingMin,
                floorNote: floorNote,
                currentPhaseId: currentPhaseId,
                testWeeks: testWeeks,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String startDate,
                Value<int> weeks = const Value.absent(),
                Value<int?> weeklyCeilingMin = const Value.absent(),
                Value<String?> floorNote = const Value.absent(),
                Value<String?> currentPhaseId = const Value.absent(),
                Value<String?> testWeeks = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingPlansCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                startDate: startDate,
                weeks: weeks,
                weeklyCeilingMin: weeklyCeilingMin,
                floorNote: floorNote,
                currentPhaseId: currentPhaseId,
                testWeeks: testWeeks,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrainingPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingPlansTable,
      TrainingPlan,
      $$TrainingPlansTableFilterComposer,
      $$TrainingPlansTableOrderingComposer,
      $$TrainingPlansTableAnnotationComposer,
      $$TrainingPlansTableCreateCompanionBuilder,
      $$TrainingPlansTableUpdateCompanionBuilder,
      (
        TrainingPlan,
        BaseReferences<_$AppDatabase, $TrainingPlansTable, TrainingPlan>,
      ),
      TrainingPlan,
      PrefetchHooks Function()
    >;
typedef $$PlanPhasesTableCreateCompanionBuilder =
    PlanPhasesCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String planId,
      required int position,
      required String name,
      Value<String?> goal,
      Value<String?> effort,
      Value<String?> cardio,
      Value<String?> gate,
      Value<int> rowid,
    });
typedef $$PlanPhasesTableUpdateCompanionBuilder =
    PlanPhasesCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> planId,
      Value<int> position,
      Value<String> name,
      Value<String?> goal,
      Value<String?> effort,
      Value<String?> cardio,
      Value<String?> gate,
      Value<int> rowid,
    });

class $$PlanPhasesTableFilterComposer
    extends Composer<_$AppDatabase, $PlanPhasesTable> {
  $$PlanPhasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effort => $composableBuilder(
    column: $table.effort,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardio => $composableBuilder(
    column: $table.cardio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gate => $composableBuilder(
    column: $table.gate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanPhasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanPhasesTable> {
  $$PlanPhasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effort => $composableBuilder(
    column: $table.effort,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardio => $composableBuilder(
    column: $table.cardio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gate => $composableBuilder(
    column: $table.gate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanPhasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanPhasesTable> {
  $$PlanPhasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get effort =>
      $composableBuilder(column: $table.effort, builder: (column) => column);

  GeneratedColumn<String> get cardio =>
      $composableBuilder(column: $table.cardio, builder: (column) => column);

  GeneratedColumn<String> get gate =>
      $composableBuilder(column: $table.gate, builder: (column) => column);
}

class $$PlanPhasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanPhasesTable,
          PlanPhase,
          $$PlanPhasesTableFilterComposer,
          $$PlanPhasesTableOrderingComposer,
          $$PlanPhasesTableAnnotationComposer,
          $$PlanPhasesTableCreateCompanionBuilder,
          $$PlanPhasesTableUpdateCompanionBuilder,
          (
            PlanPhase,
            BaseReferences<_$AppDatabase, $PlanPhasesTable, PlanPhase>,
          ),
          PlanPhase,
          PrefetchHooks Function()
        > {
  $$PlanPhasesTableTableManager(_$AppDatabase db, $PlanPhasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanPhasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanPhasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanPhasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> goal = const Value.absent(),
                Value<String?> effort = const Value.absent(),
                Value<String?> cardio = const Value.absent(),
                Value<String?> gate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanPhasesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                goal: goal,
                effort: effort,
                cardio: cardio,
                gate: gate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String planId,
                required int position,
                required String name,
                Value<String?> goal = const Value.absent(),
                Value<String?> effort = const Value.absent(),
                Value<String?> cardio = const Value.absent(),
                Value<String?> gate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanPhasesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                goal: goal,
                effort: effort,
                cardio: cardio,
                gate: gate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanPhasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanPhasesTable,
      PlanPhase,
      $$PlanPhasesTableFilterComposer,
      $$PlanPhasesTableOrderingComposer,
      $$PlanPhasesTableAnnotationComposer,
      $$PlanPhasesTableCreateCompanionBuilder,
      $$PlanPhasesTableUpdateCompanionBuilder,
      (PlanPhase, BaseReferences<_$AppDatabase, $PlanPhasesTable, PlanPhase>),
      PlanPhase,
      PrefetchHooks Function()
    >;
typedef $$PlanSessionsTableCreateCompanionBuilder =
    PlanSessionsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String planId,
      required int position,
      required String name,
      Value<int?> weekday,
      Value<int?> durationMin,
      Value<String?> lowDayNote,
      Value<bool> isCardio,
      Value<int> rowid,
    });
typedef $$PlanSessionsTableUpdateCompanionBuilder =
    PlanSessionsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> planId,
      Value<int> position,
      Value<String> name,
      Value<int?> weekday,
      Value<int?> durationMin,
      Value<String?> lowDayNote,
      Value<bool> isCardio,
      Value<int> rowid,
    });

class $$PlanSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanSessionsTable> {
  $$PlanSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lowDayNote => $composableBuilder(
    column: $table.lowDayNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCardio => $composableBuilder(
    column: $table.isCardio,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanSessionsTable> {
  $$PlanSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lowDayNote => $composableBuilder(
    column: $table.lowDayNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCardio => $composableBuilder(
    column: $table.isCardio,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanSessionsTable> {
  $$PlanSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lowDayNote => $composableBuilder(
    column: $table.lowDayNote,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCardio =>
      $composableBuilder(column: $table.isCardio, builder: (column) => column);
}

class $$PlanSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanSessionsTable,
          PlanSession,
          $$PlanSessionsTableFilterComposer,
          $$PlanSessionsTableOrderingComposer,
          $$PlanSessionsTableAnnotationComposer,
          $$PlanSessionsTableCreateCompanionBuilder,
          $$PlanSessionsTableUpdateCompanionBuilder,
          (
            PlanSession,
            BaseReferences<_$AppDatabase, $PlanSessionsTable, PlanSession>,
          ),
          PlanSession,
          PrefetchHooks Function()
        > {
  $$PlanSessionsTableTableManager(_$AppDatabase db, $PlanSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> weekday = const Value.absent(),
                Value<int?> durationMin = const Value.absent(),
                Value<String?> lowDayNote = const Value.absent(),
                Value<bool> isCardio = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSessionsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                weekday: weekday,
                durationMin: durationMin,
                lowDayNote: lowDayNote,
                isCardio: isCardio,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String planId,
                required int position,
                required String name,
                Value<int?> weekday = const Value.absent(),
                Value<int?> durationMin = const Value.absent(),
                Value<String?> lowDayNote = const Value.absent(),
                Value<bool> isCardio = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSessionsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                weekday: weekday,
                durationMin: durationMin,
                lowDayNote: lowDayNote,
                isCardio: isCardio,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanSessionsTable,
      PlanSession,
      $$PlanSessionsTableFilterComposer,
      $$PlanSessionsTableOrderingComposer,
      $$PlanSessionsTableAnnotationComposer,
      $$PlanSessionsTableCreateCompanionBuilder,
      $$PlanSessionsTableUpdateCompanionBuilder,
      (
        PlanSession,
        BaseReferences<_$AppDatabase, $PlanSessionsTable, PlanSession>,
      ),
      PlanSession,
      PrefetchHooks Function()
    >;
typedef $$PlanExercisesTableCreateCompanionBuilder =
    PlanExercisesCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String sessionId,
      required int position,
      required String name,
      Value<String?> cue,
      Value<String?> currentStepId,
      Value<String?> stepChangedOn,
      Value<int> rowid,
    });
typedef $$PlanExercisesTableUpdateCompanionBuilder =
    PlanExercisesCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> sessionId,
      Value<int> position,
      Value<String> name,
      Value<String?> cue,
      Value<String?> currentStepId,
      Value<String?> stepChangedOn,
      Value<int> rowid,
    });

class $$PlanExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cue => $composableBuilder(
    column: $table.cue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStepId => $composableBuilder(
    column: $table.currentStepId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepChangedOn => $composableBuilder(
    column: $table.stepChangedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cue => $composableBuilder(
    column: $table.cue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStepId => $composableBuilder(
    column: $table.currentStepId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepChangedOn => $composableBuilder(
    column: $table.stepChangedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get cue =>
      $composableBuilder(column: $table.cue, builder: (column) => column);

  GeneratedColumn<String> get currentStepId => $composableBuilder(
    column: $table.currentStepId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepChangedOn => $composableBuilder(
    column: $table.stepChangedOn,
    builder: (column) => column,
  );
}

class $$PlanExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanExercisesTable,
          PlanExercise,
          $$PlanExercisesTableFilterComposer,
          $$PlanExercisesTableOrderingComposer,
          $$PlanExercisesTableAnnotationComposer,
          $$PlanExercisesTableCreateCompanionBuilder,
          $$PlanExercisesTableUpdateCompanionBuilder,
          (
            PlanExercise,
            BaseReferences<_$AppDatabase, $PlanExercisesTable, PlanExercise>,
          ),
          PlanExercise,
          PrefetchHooks Function()
        > {
  $$PlanExercisesTableTableManager(_$AppDatabase db, $PlanExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> cue = const Value.absent(),
                Value<String?> currentStepId = const Value.absent(),
                Value<String?> stepChangedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanExercisesCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                sessionId: sessionId,
                position: position,
                name: name,
                cue: cue,
                currentStepId: currentStepId,
                stepChangedOn: stepChangedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String sessionId,
                required int position,
                required String name,
                Value<String?> cue = const Value.absent(),
                Value<String?> currentStepId = const Value.absent(),
                Value<String?> stepChangedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanExercisesCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                sessionId: sessionId,
                position: position,
                name: name,
                cue: cue,
                currentStepId: currentStepId,
                stepChangedOn: stepChangedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanExercisesTable,
      PlanExercise,
      $$PlanExercisesTableFilterComposer,
      $$PlanExercisesTableOrderingComposer,
      $$PlanExercisesTableAnnotationComposer,
      $$PlanExercisesTableCreateCompanionBuilder,
      $$PlanExercisesTableUpdateCompanionBuilder,
      (
        PlanExercise,
        BaseReferences<_$AppDatabase, $PlanExercisesTable, PlanExercise>,
      ),
      PlanExercise,
      PrefetchHooks Function()
    >;
typedef $$PlanStepsTableCreateCompanionBuilder =
    PlanStepsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String exerciseId,
      required int position,
      required String name,
      Value<String?> dose,
      Value<String> unit,
      Value<bool> needsClearance,
      Value<String?> clearedOn,
      Value<int> rowid,
    });
typedef $$PlanStepsTableUpdateCompanionBuilder =
    PlanStepsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> exerciseId,
      Value<int> position,
      Value<String> name,
      Value<String?> dose,
      Value<String> unit,
      Value<bool> needsClearance,
      Value<String?> clearedOn,
      Value<int> rowid,
    });

class $$PlanStepsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanStepsTable> {
  $$PlanStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsClearance => $composableBuilder(
    column: $table.needsClearance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clearedOn => $composableBuilder(
    column: $table.clearedOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanStepsTable> {
  $$PlanStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsClearance => $composableBuilder(
    column: $table.needsClearance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clearedOn => $composableBuilder(
    column: $table.clearedOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanStepsTable> {
  $$PlanStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get needsClearance => $composableBuilder(
    column: $table.needsClearance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clearedOn =>
      $composableBuilder(column: $table.clearedOn, builder: (column) => column);
}

class $$PlanStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanStepsTable,
          PlanStep,
          $$PlanStepsTableFilterComposer,
          $$PlanStepsTableOrderingComposer,
          $$PlanStepsTableAnnotationComposer,
          $$PlanStepsTableCreateCompanionBuilder,
          $$PlanStepsTableUpdateCompanionBuilder,
          (PlanStep, BaseReferences<_$AppDatabase, $PlanStepsTable, PlanStep>),
          PlanStep,
          PrefetchHooks Function()
        > {
  $$PlanStepsTableTableManager(_$AppDatabase db, $PlanStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> dose = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> needsClearance = const Value.absent(),
                Value<String?> clearedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanStepsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                exerciseId: exerciseId,
                position: position,
                name: name,
                dose: dose,
                unit: unit,
                needsClearance: needsClearance,
                clearedOn: clearedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String exerciseId,
                required int position,
                required String name,
                Value<String?> dose = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> needsClearance = const Value.absent(),
                Value<String?> clearedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanStepsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                exerciseId: exerciseId,
                position: position,
                name: name,
                dose: dose,
                unit: unit,
                needsClearance: needsClearance,
                clearedOn: clearedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanStepsTable,
      PlanStep,
      $$PlanStepsTableFilterComposer,
      $$PlanStepsTableOrderingComposer,
      $$PlanStepsTableAnnotationComposer,
      $$PlanStepsTableCreateCompanionBuilder,
      $$PlanStepsTableUpdateCompanionBuilder,
      (PlanStep, BaseReferences<_$AppDatabase, $PlanStepsTable, PlanStep>),
      PlanStep,
      PrefetchHooks Function()
    >;
typedef $$PlanSessionLogsTableCreateCompanionBuilder =
    PlanSessionLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String planId,
      Value<String?> sessionId,
      required String date,
      required String mode,
      Value<int?> durationMin,
      Value<String?> nextMorning,
      Value<String?> activityId,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$PlanSessionLogsTableUpdateCompanionBuilder =
    PlanSessionLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> planId,
      Value<String?> sessionId,
      Value<String> date,
      Value<String> mode,
      Value<int?> durationMin,
      Value<String?> nextMorning,
      Value<String?> activityId,
      Value<String?> note,
      Value<int> rowid,
    });

class $$PlanSessionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanSessionLogsTable> {
  $$PlanSessionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nextMorning => $composableBuilder(
    column: $table.nextMorning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanSessionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanSessionLogsTable> {
  $$PlanSessionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nextMorning => $composableBuilder(
    column: $table.nextMorning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanSessionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanSessionLogsTable> {
  $$PlanSessionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nextMorning => $composableBuilder(
    column: $table.nextMorning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityId => $composableBuilder(
    column: $table.activityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$PlanSessionLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanSessionLogsTable,
          PlanSessionLog,
          $$PlanSessionLogsTableFilterComposer,
          $$PlanSessionLogsTableOrderingComposer,
          $$PlanSessionLogsTableAnnotationComposer,
          $$PlanSessionLogsTableCreateCompanionBuilder,
          $$PlanSessionLogsTableUpdateCompanionBuilder,
          (
            PlanSessionLog,
            BaseReferences<
              _$AppDatabase,
              $PlanSessionLogsTable,
              PlanSessionLog
            >,
          ),
          PlanSessionLog,
          PrefetchHooks Function()
        > {
  $$PlanSessionLogsTableTableManager(
    _$AppDatabase db,
    $PlanSessionLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanSessionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanSessionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanSessionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String?> sessionId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<int?> durationMin = const Value.absent(),
                Value<String?> nextMorning = const Value.absent(),
                Value<String?> activityId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSessionLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                sessionId: sessionId,
                date: date,
                mode: mode,
                durationMin: durationMin,
                nextMorning: nextMorning,
                activityId: activityId,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String planId,
                Value<String?> sessionId = const Value.absent(),
                required String date,
                required String mode,
                Value<int?> durationMin = const Value.absent(),
                Value<String?> nextMorning = const Value.absent(),
                Value<String?> activityId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSessionLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                sessionId: sessionId,
                date: date,
                mode: mode,
                durationMin: durationMin,
                nextMorning: nextMorning,
                activityId: activityId,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanSessionLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanSessionLogsTable,
      PlanSessionLog,
      $$PlanSessionLogsTableFilterComposer,
      $$PlanSessionLogsTableOrderingComposer,
      $$PlanSessionLogsTableAnnotationComposer,
      $$PlanSessionLogsTableCreateCompanionBuilder,
      $$PlanSessionLogsTableUpdateCompanionBuilder,
      (
        PlanSessionLog,
        BaseReferences<_$AppDatabase, $PlanSessionLogsTable, PlanSessionLog>,
      ),
      PlanSessionLog,
      PrefetchHooks Function()
    >;
typedef $$PlanSetLogsTableCreateCompanionBuilder =
    PlanSetLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String sessionLogId,
      required String exerciseId,
      required String stepId,
      Value<String> setValues,
      Value<String> unit,
      Value<int?> pain,
      Value<bool> sharp,
      Value<int> rowid,
    });
typedef $$PlanSetLogsTableUpdateCompanionBuilder =
    PlanSetLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> sessionLogId,
      Value<String> exerciseId,
      Value<String> stepId,
      Value<String> setValues,
      Value<String> unit,
      Value<int?> pain,
      Value<bool> sharp,
      Value<int> rowid,
    });

class $$PlanSetLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanSetLogsTable> {
  $$PlanSetLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionLogId => $composableBuilder(
    column: $table.sessionLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepId => $composableBuilder(
    column: $table.stepId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setValues => $composableBuilder(
    column: $table.setValues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pain => $composableBuilder(
    column: $table.pain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sharp => $composableBuilder(
    column: $table.sharp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanSetLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanSetLogsTable> {
  $$PlanSetLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionLogId => $composableBuilder(
    column: $table.sessionLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepId => $composableBuilder(
    column: $table.stepId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setValues => $composableBuilder(
    column: $table.setValues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pain => $composableBuilder(
    column: $table.pain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sharp => $composableBuilder(
    column: $table.sharp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanSetLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanSetLogsTable> {
  $$PlanSetLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionLogId => $composableBuilder(
    column: $table.sessionLogId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<String> get setValues =>
      $composableBuilder(column: $table.setValues, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get pain =>
      $composableBuilder(column: $table.pain, builder: (column) => column);

  GeneratedColumn<bool> get sharp =>
      $composableBuilder(column: $table.sharp, builder: (column) => column);
}

class $$PlanSetLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanSetLogsTable,
          PlanSetLog,
          $$PlanSetLogsTableFilterComposer,
          $$PlanSetLogsTableOrderingComposer,
          $$PlanSetLogsTableAnnotationComposer,
          $$PlanSetLogsTableCreateCompanionBuilder,
          $$PlanSetLogsTableUpdateCompanionBuilder,
          (
            PlanSetLog,
            BaseReferences<_$AppDatabase, $PlanSetLogsTable, PlanSetLog>,
          ),
          PlanSetLog,
          PrefetchHooks Function()
        > {
  $$PlanSetLogsTableTableManager(_$AppDatabase db, $PlanSetLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanSetLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanSetLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanSetLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> sessionLogId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> stepId = const Value.absent(),
                Value<String> setValues = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int?> pain = const Value.absent(),
                Value<bool> sharp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSetLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                sessionLogId: sessionLogId,
                exerciseId: exerciseId,
                stepId: stepId,
                setValues: setValues,
                unit: unit,
                pain: pain,
                sharp: sharp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String sessionLogId,
                required String exerciseId,
                required String stepId,
                Value<String> setValues = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int?> pain = const Value.absent(),
                Value<bool> sharp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanSetLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                sessionLogId: sessionLogId,
                exerciseId: exerciseId,
                stepId: stepId,
                setValues: setValues,
                unit: unit,
                pain: pain,
                sharp: sharp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanSetLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanSetLogsTable,
      PlanSetLog,
      $$PlanSetLogsTableFilterComposer,
      $$PlanSetLogsTableOrderingComposer,
      $$PlanSetLogsTableAnnotationComposer,
      $$PlanSetLogsTableCreateCompanionBuilder,
      $$PlanSetLogsTableUpdateCompanionBuilder,
      (
        PlanSetLog,
        BaseReferences<_$AppDatabase, $PlanSetLogsTable, PlanSetLog>,
      ),
      PlanSetLog,
      PrefetchHooks Function()
    >;
typedef $$PlanCheckinsTableCreateCompanionBuilder =
    PlanCheckinsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String planId,
      required String weekStart,
      Value<int> sessionsDone,
      Value<int> sessionsPlanned,
      Value<bool> hadPem,
      Value<String?> pemCause,
      Value<bool?> jointsOk,
      Value<int?> proteinDays,
      Value<double?> weightKg,
      Value<String?> win,
      Value<String?> fearStep,
      required String decision,
      Value<int?> ceilingBefore,
      Value<int?> ceilingAfter,
      Value<int> rowid,
    });
typedef $$PlanCheckinsTableUpdateCompanionBuilder =
    PlanCheckinsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> planId,
      Value<String> weekStart,
      Value<int> sessionsDone,
      Value<int> sessionsPlanned,
      Value<bool> hadPem,
      Value<String?> pemCause,
      Value<bool?> jointsOk,
      Value<int?> proteinDays,
      Value<double?> weightKg,
      Value<String?> win,
      Value<String?> fearStep,
      Value<String> decision,
      Value<int?> ceilingBefore,
      Value<int?> ceilingAfter,
      Value<int> rowid,
    });

class $$PlanCheckinsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanCheckinsTable> {
  $$PlanCheckinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionsDone => $composableBuilder(
    column: $table.sessionsDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionsPlanned => $composableBuilder(
    column: $table.sessionsPlanned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hadPem => $composableBuilder(
    column: $table.hadPem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pemCause => $composableBuilder(
    column: $table.pemCause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get jointsOk => $composableBuilder(
    column: $table.jointsOk,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proteinDays => $composableBuilder(
    column: $table.proteinDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get win => $composableBuilder(
    column: $table.win,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fearStep => $composableBuilder(
    column: $table.fearStep,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ceilingBefore => $composableBuilder(
    column: $table.ceilingBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ceilingAfter => $composableBuilder(
    column: $table.ceilingAfter,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanCheckinsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanCheckinsTable> {
  $$PlanCheckinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionsDone => $composableBuilder(
    column: $table.sessionsDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionsPlanned => $composableBuilder(
    column: $table.sessionsPlanned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hadPem => $composableBuilder(
    column: $table.hadPem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pemCause => $composableBuilder(
    column: $table.pemCause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get jointsOk => $composableBuilder(
    column: $table.jointsOk,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proteinDays => $composableBuilder(
    column: $table.proteinDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get win => $composableBuilder(
    column: $table.win,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fearStep => $composableBuilder(
    column: $table.fearStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decision => $composableBuilder(
    column: $table.decision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ceilingBefore => $composableBuilder(
    column: $table.ceilingBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ceilingAfter => $composableBuilder(
    column: $table.ceilingAfter,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanCheckinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanCheckinsTable> {
  $$PlanCheckinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<int> get sessionsDone => $composableBuilder(
    column: $table.sessionsDone,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sessionsPlanned => $composableBuilder(
    column: $table.sessionsPlanned,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hadPem =>
      $composableBuilder(column: $table.hadPem, builder: (column) => column);

  GeneratedColumn<String> get pemCause =>
      $composableBuilder(column: $table.pemCause, builder: (column) => column);

  GeneratedColumn<bool> get jointsOk =>
      $composableBuilder(column: $table.jointsOk, builder: (column) => column);

  GeneratedColumn<int> get proteinDays => $composableBuilder(
    column: $table.proteinDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get win =>
      $composableBuilder(column: $table.win, builder: (column) => column);

  GeneratedColumn<String> get fearStep =>
      $composableBuilder(column: $table.fearStep, builder: (column) => column);

  GeneratedColumn<String> get decision =>
      $composableBuilder(column: $table.decision, builder: (column) => column);

  GeneratedColumn<int> get ceilingBefore => $composableBuilder(
    column: $table.ceilingBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ceilingAfter => $composableBuilder(
    column: $table.ceilingAfter,
    builder: (column) => column,
  );
}

class $$PlanCheckinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanCheckinsTable,
          PlanCheckin,
          $$PlanCheckinsTableFilterComposer,
          $$PlanCheckinsTableOrderingComposer,
          $$PlanCheckinsTableAnnotationComposer,
          $$PlanCheckinsTableCreateCompanionBuilder,
          $$PlanCheckinsTableUpdateCompanionBuilder,
          (
            PlanCheckin,
            BaseReferences<_$AppDatabase, $PlanCheckinsTable, PlanCheckin>,
          ),
          PlanCheckin,
          PrefetchHooks Function()
        > {
  $$PlanCheckinsTableTableManager(_$AppDatabase db, $PlanCheckinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanCheckinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanCheckinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanCheckinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> weekStart = const Value.absent(),
                Value<int> sessionsDone = const Value.absent(),
                Value<int> sessionsPlanned = const Value.absent(),
                Value<bool> hadPem = const Value.absent(),
                Value<String?> pemCause = const Value.absent(),
                Value<bool?> jointsOk = const Value.absent(),
                Value<int?> proteinDays = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> win = const Value.absent(),
                Value<String?> fearStep = const Value.absent(),
                Value<String> decision = const Value.absent(),
                Value<int?> ceilingBefore = const Value.absent(),
                Value<int?> ceilingAfter = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanCheckinsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                weekStart: weekStart,
                sessionsDone: sessionsDone,
                sessionsPlanned: sessionsPlanned,
                hadPem: hadPem,
                pemCause: pemCause,
                jointsOk: jointsOk,
                proteinDays: proteinDays,
                weightKg: weightKg,
                win: win,
                fearStep: fearStep,
                decision: decision,
                ceilingBefore: ceilingBefore,
                ceilingAfter: ceilingAfter,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String planId,
                required String weekStart,
                Value<int> sessionsDone = const Value.absent(),
                Value<int> sessionsPlanned = const Value.absent(),
                Value<bool> hadPem = const Value.absent(),
                Value<String?> pemCause = const Value.absent(),
                Value<bool?> jointsOk = const Value.absent(),
                Value<int?> proteinDays = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> win = const Value.absent(),
                Value<String?> fearStep = const Value.absent(),
                required String decision,
                Value<int?> ceilingBefore = const Value.absent(),
                Value<int?> ceilingAfter = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanCheckinsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                weekStart: weekStart,
                sessionsDone: sessionsDone,
                sessionsPlanned: sessionsPlanned,
                hadPem: hadPem,
                pemCause: pemCause,
                jointsOk: jointsOk,
                proteinDays: proteinDays,
                weightKg: weightKg,
                win: win,
                fearStep: fearStep,
                decision: decision,
                ceilingBefore: ceilingBefore,
                ceilingAfter: ceilingAfter,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanCheckinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanCheckinsTable,
      PlanCheckin,
      $$PlanCheckinsTableFilterComposer,
      $$PlanCheckinsTableOrderingComposer,
      $$PlanCheckinsTableAnnotationComposer,
      $$PlanCheckinsTableCreateCompanionBuilder,
      $$PlanCheckinsTableUpdateCompanionBuilder,
      (
        PlanCheckin,
        BaseReferences<_$AppDatabase, $PlanCheckinsTable, PlanCheckin>,
      ),
      PlanCheckin,
      PrefetchHooks Function()
    >;
typedef $$PlanTestsTableCreateCompanionBuilder =
    PlanTestsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String planId,
      required int position,
      required String name,
      Value<String?> unit,
      Value<int> rowid,
    });
typedef $$PlanTestsTableUpdateCompanionBuilder =
    PlanTestsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> planId,
      Value<int> position,
      Value<String> name,
      Value<String?> unit,
      Value<int> rowid,
    });

class $$PlanTestsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanTestsTable> {
  $$PlanTestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanTestsTable> {
  $$PlanTestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planId => $composableBuilder(
    column: $table.planId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanTestsTable> {
  $$PlanTestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);
}

class $$PlanTestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanTestsTable,
          PlanTest,
          $$PlanTestsTableFilterComposer,
          $$PlanTestsTableOrderingComposer,
          $$PlanTestsTableAnnotationComposer,
          $$PlanTestsTableCreateCompanionBuilder,
          $$PlanTestsTableUpdateCompanionBuilder,
          (PlanTest, BaseReferences<_$AppDatabase, $PlanTestsTable, PlanTest>),
          PlanTest,
          PrefetchHooks Function()
        > {
  $$PlanTestsTableTableManager(_$AppDatabase db, $PlanTestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanTestsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                unit: unit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String planId,
                required int position,
                required String name,
                Value<String?> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanTestsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                planId: planId,
                position: position,
                name: name,
                unit: unit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanTestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanTestsTable,
      PlanTest,
      $$PlanTestsTableFilterComposer,
      $$PlanTestsTableOrderingComposer,
      $$PlanTestsTableAnnotationComposer,
      $$PlanTestsTableCreateCompanionBuilder,
      $$PlanTestsTableUpdateCompanionBuilder,
      (PlanTest, BaseReferences<_$AppDatabase, $PlanTestsTable, PlanTest>),
      PlanTest,
      PrefetchHooks Function()
    >;
typedef $$PlanTestResultsTableCreateCompanionBuilder =
    PlanTestResultsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String testId,
      required String date,
      required double value,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$PlanTestResultsTableUpdateCompanionBuilder =
    PlanTestResultsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> testId,
      Value<String> date,
      Value<double> value,
      Value<String?> note,
      Value<int> rowid,
    });

class $$PlanTestResultsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanTestResultsTable> {
  $$PlanTestResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanTestResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanTestResultsTable> {
  $$PlanTestResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get testId => $composableBuilder(
    column: $table.testId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanTestResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanTestResultsTable> {
  $$PlanTestResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testId =>
      $composableBuilder(column: $table.testId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$PlanTestResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanTestResultsTable,
          PlanTestResult,
          $$PlanTestResultsTableFilterComposer,
          $$PlanTestResultsTableOrderingComposer,
          $$PlanTestResultsTableAnnotationComposer,
          $$PlanTestResultsTableCreateCompanionBuilder,
          $$PlanTestResultsTableUpdateCompanionBuilder,
          (
            PlanTestResult,
            BaseReferences<
              _$AppDatabase,
              $PlanTestResultsTable,
              PlanTestResult
            >,
          ),
          PlanTestResult,
          PrefetchHooks Function()
        > {
  $$PlanTestResultsTableTableManager(
    _$AppDatabase db,
    $PlanTestResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanTestResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanTestResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanTestResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> testId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanTestResultsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                testId: testId,
                date: date,
                value: value,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String testId,
                required String date,
                required double value,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanTestResultsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                testId: testId,
                date: date,
                value: value,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanTestResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanTestResultsTable,
      PlanTestResult,
      $$PlanTestResultsTableFilterComposer,
      $$PlanTestResultsTableOrderingComposer,
      $$PlanTestResultsTableAnnotationComposer,
      $$PlanTestResultsTableCreateCompanionBuilder,
      $$PlanTestResultsTableUpdateCompanionBuilder,
      (
        PlanTestResult,
        BaseReferences<_$AppDatabase, $PlanTestResultsTable, PlanTestResult>,
      ),
      PlanTestResult,
      PrefetchHooks Function()
    >;
typedef $$FearItemsTableCreateCompanionBuilder =
    FearItemsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required int fear,
      required int initialFear,
      Value<String?> settledOn,
      Value<int> rowid,
    });
typedef $$FearItemsTableUpdateCompanionBuilder =
    FearItemsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<int> fear,
      Value<int> initialFear,
      Value<String?> settledOn,
      Value<int> rowid,
    });

class $$FearItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FearItemsTable> {
  $$FearItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fear => $composableBuilder(
    column: $table.fear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get initialFear => $composableBuilder(
    column: $table.initialFear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settledOn => $composableBuilder(
    column: $table.settledOn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FearItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FearItemsTable> {
  $$FearItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fear => $composableBuilder(
    column: $table.fear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get initialFear => $composableBuilder(
    column: $table.initialFear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settledOn => $composableBuilder(
    column: $table.settledOn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FearItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FearItemsTable> {
  $$FearItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get fear =>
      $composableBuilder(column: $table.fear, builder: (column) => column);

  GeneratedColumn<int> get initialFear => $composableBuilder(
    column: $table.initialFear,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settledOn =>
      $composableBuilder(column: $table.settledOn, builder: (column) => column);
}

class $$FearItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FearItemsTable,
          FearItem,
          $$FearItemsTableFilterComposer,
          $$FearItemsTableOrderingComposer,
          $$FearItemsTableAnnotationComposer,
          $$FearItemsTableCreateCompanionBuilder,
          $$FearItemsTableUpdateCompanionBuilder,
          (FearItem, BaseReferences<_$AppDatabase, $FearItemsTable, FearItem>),
          FearItem,
          PrefetchHooks Function()
        > {
  $$FearItemsTableTableManager(_$AppDatabase db, $FearItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FearItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FearItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FearItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> fear = const Value.absent(),
                Value<int> initialFear = const Value.absent(),
                Value<String?> settledOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FearItemsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                fear: fear,
                initialFear: initialFear,
                settledOn: settledOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required int fear,
                required int initialFear,
                Value<String?> settledOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FearItemsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                fear: fear,
                initialFear: initialFear,
                settledOn: settledOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FearItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FearItemsTable,
      FearItem,
      $$FearItemsTableFilterComposer,
      $$FearItemsTableOrderingComposer,
      $$FearItemsTableAnnotationComposer,
      $$FearItemsTableCreateCompanionBuilder,
      $$FearItemsTableUpdateCompanionBuilder,
      (FearItem, BaseReferences<_$AppDatabase, $FearItemsTable, FearItem>),
      FearItem,
      PrefetchHooks Function()
    >;
typedef $$ExposureLogsTableCreateCompanionBuilder =
    ExposureLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String fearItemId,
      required String date,
      Value<String?> attempt,
      Value<String?> prediction,
      Value<String?> outcome,
      Value<int?> fearBefore,
      Value<int?> fearAfter,
      Value<bool> nothingBad,
      Value<int> rowid,
    });
typedef $$ExposureLogsTableUpdateCompanionBuilder =
    ExposureLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> fearItemId,
      Value<String> date,
      Value<String?> attempt,
      Value<String?> prediction,
      Value<String?> outcome,
      Value<int?> fearBefore,
      Value<int?> fearAfter,
      Value<bool> nothingBad,
      Value<int> rowid,
    });

class $$ExposureLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ExposureLogsTable> {
  $$ExposureLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fearItemId => $composableBuilder(
    column: $table.fearItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attempt => $composableBuilder(
    column: $table.attempt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fearBefore => $composableBuilder(
    column: $table.fearBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fearAfter => $composableBuilder(
    column: $table.fearAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get nothingBad => $composableBuilder(
    column: $table.nothingBad,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExposureLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExposureLogsTable> {
  $$ExposureLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fearItemId => $composableBuilder(
    column: $table.fearItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attempt => $composableBuilder(
    column: $table.attempt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fearBefore => $composableBuilder(
    column: $table.fearBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fearAfter => $composableBuilder(
    column: $table.fearAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get nothingBad => $composableBuilder(
    column: $table.nothingBad,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExposureLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExposureLogsTable> {
  $$ExposureLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fearItemId => $composableBuilder(
    column: $table.fearItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get attempt =>
      $composableBuilder(column: $table.attempt, builder: (column) => column);

  GeneratedColumn<String> get prediction => $composableBuilder(
    column: $table.prediction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<int> get fearBefore => $composableBuilder(
    column: $table.fearBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fearAfter =>
      $composableBuilder(column: $table.fearAfter, builder: (column) => column);

  GeneratedColumn<bool> get nothingBad => $composableBuilder(
    column: $table.nothingBad,
    builder: (column) => column,
  );
}

class $$ExposureLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExposureLogsTable,
          ExposureLog,
          $$ExposureLogsTableFilterComposer,
          $$ExposureLogsTableOrderingComposer,
          $$ExposureLogsTableAnnotationComposer,
          $$ExposureLogsTableCreateCompanionBuilder,
          $$ExposureLogsTableUpdateCompanionBuilder,
          (
            ExposureLog,
            BaseReferences<_$AppDatabase, $ExposureLogsTable, ExposureLog>,
          ),
          ExposureLog,
          PrefetchHooks Function()
        > {
  $$ExposureLogsTableTableManager(_$AppDatabase db, $ExposureLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExposureLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExposureLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExposureLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> fearItemId = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String?> attempt = const Value.absent(),
                Value<String?> prediction = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<int?> fearBefore = const Value.absent(),
                Value<int?> fearAfter = const Value.absent(),
                Value<bool> nothingBad = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExposureLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                fearItemId: fearItemId,
                date: date,
                attempt: attempt,
                prediction: prediction,
                outcome: outcome,
                fearBefore: fearBefore,
                fearAfter: fearAfter,
                nothingBad: nothingBad,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String fearItemId,
                required String date,
                Value<String?> attempt = const Value.absent(),
                Value<String?> prediction = const Value.absent(),
                Value<String?> outcome = const Value.absent(),
                Value<int?> fearBefore = const Value.absent(),
                Value<int?> fearAfter = const Value.absent(),
                Value<bool> nothingBad = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExposureLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                fearItemId: fearItemId,
                date: date,
                attempt: attempt,
                prediction: prediction,
                outcome: outcome,
                fearBefore: fearBefore,
                fearAfter: fearAfter,
                nothingBad: nothingBad,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExposureLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExposureLogsTable,
      ExposureLog,
      $$ExposureLogsTableFilterComposer,
      $$ExposureLogsTableOrderingComposer,
      $$ExposureLogsTableAnnotationComposer,
      $$ExposureLogsTableCreateCompanionBuilder,
      $$ExposureLogsTableUpdateCompanionBuilder,
      (
        ExposureLog,
        BaseReferences<_$AppDatabase, $ExposureLogsTable, ExposureLog>,
      ),
      ExposureLog,
      PrefetchHooks Function()
    >;
typedef $$StandTestsTableCreateCompanionBuilder =
    StandTestsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String startedAt,
      Value<String> baselinePosition,
      Value<int?> baselineHr,
      Value<int?> baselineSys,
      Value<int?> baselineDia,
      Value<int?> hr1,
      Value<int?> sys1,
      Value<int?> dia1,
      Value<int?> hr3,
      Value<int?> sys3,
      Value<int?> dia3,
      Value<int?> hr10,
      Value<int?> sys10,
      Value<int?> dia10,
      Value<String> symptoms,
      Value<bool> stoppedEarly,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$StandTestsTableUpdateCompanionBuilder =
    StandTestsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> startedAt,
      Value<String> baselinePosition,
      Value<int?> baselineHr,
      Value<int?> baselineSys,
      Value<int?> baselineDia,
      Value<int?> hr1,
      Value<int?> sys1,
      Value<int?> dia1,
      Value<int?> hr3,
      Value<int?> sys3,
      Value<int?> dia3,
      Value<int?> hr10,
      Value<int?> sys10,
      Value<int?> dia10,
      Value<String> symptoms,
      Value<bool> stoppedEarly,
      Value<String?> note,
      Value<int> rowid,
    });

class $$StandTestsTableFilterComposer
    extends Composer<_$AppDatabase, $StandTestsTable> {
  $$StandTestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baselinePosition => $composableBuilder(
    column: $table.baselinePosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baselineHr => $composableBuilder(
    column: $table.baselineHr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baselineSys => $composableBuilder(
    column: $table.baselineSys,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baselineDia => $composableBuilder(
    column: $table.baselineDia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hr1 => $composableBuilder(
    column: $table.hr1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sys1 => $composableBuilder(
    column: $table.sys1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dia1 => $composableBuilder(
    column: $table.dia1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hr3 => $composableBuilder(
    column: $table.hr3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sys3 => $composableBuilder(
    column: $table.sys3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dia3 => $composableBuilder(
    column: $table.dia3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hr10 => $composableBuilder(
    column: $table.hr10,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sys10 => $composableBuilder(
    column: $table.sys10,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dia10 => $composableBuilder(
    column: $table.dia10,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stoppedEarly => $composableBuilder(
    column: $table.stoppedEarly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StandTestsTableOrderingComposer
    extends Composer<_$AppDatabase, $StandTestsTable> {
  $$StandTestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baselinePosition => $composableBuilder(
    column: $table.baselinePosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baselineHr => $composableBuilder(
    column: $table.baselineHr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baselineSys => $composableBuilder(
    column: $table.baselineSys,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baselineDia => $composableBuilder(
    column: $table.baselineDia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hr1 => $composableBuilder(
    column: $table.hr1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sys1 => $composableBuilder(
    column: $table.sys1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dia1 => $composableBuilder(
    column: $table.dia1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hr3 => $composableBuilder(
    column: $table.hr3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sys3 => $composableBuilder(
    column: $table.sys3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dia3 => $composableBuilder(
    column: $table.dia3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hr10 => $composableBuilder(
    column: $table.hr10,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sys10 => $composableBuilder(
    column: $table.sys10,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dia10 => $composableBuilder(
    column: $table.dia10,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stoppedEarly => $composableBuilder(
    column: $table.stoppedEarly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StandTestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StandTestsTable> {
  $$StandTestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get baselinePosition => $composableBuilder(
    column: $table.baselinePosition,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baselineHr => $composableBuilder(
    column: $table.baselineHr,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baselineSys => $composableBuilder(
    column: $table.baselineSys,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baselineDia => $composableBuilder(
    column: $table.baselineDia,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hr1 =>
      $composableBuilder(column: $table.hr1, builder: (column) => column);

  GeneratedColumn<int> get sys1 =>
      $composableBuilder(column: $table.sys1, builder: (column) => column);

  GeneratedColumn<int> get dia1 =>
      $composableBuilder(column: $table.dia1, builder: (column) => column);

  GeneratedColumn<int> get hr3 =>
      $composableBuilder(column: $table.hr3, builder: (column) => column);

  GeneratedColumn<int> get sys3 =>
      $composableBuilder(column: $table.sys3, builder: (column) => column);

  GeneratedColumn<int> get dia3 =>
      $composableBuilder(column: $table.dia3, builder: (column) => column);

  GeneratedColumn<int> get hr10 =>
      $composableBuilder(column: $table.hr10, builder: (column) => column);

  GeneratedColumn<int> get sys10 =>
      $composableBuilder(column: $table.sys10, builder: (column) => column);

  GeneratedColumn<int> get dia10 =>
      $composableBuilder(column: $table.dia10, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<bool> get stoppedEarly => $composableBuilder(
    column: $table.stoppedEarly,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$StandTestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StandTestsTable,
          StandTest,
          $$StandTestsTableFilterComposer,
          $$StandTestsTableOrderingComposer,
          $$StandTestsTableAnnotationComposer,
          $$StandTestsTableCreateCompanionBuilder,
          $$StandTestsTableUpdateCompanionBuilder,
          (
            StandTest,
            BaseReferences<_$AppDatabase, $StandTestsTable, StandTest>,
          ),
          StandTest,
          PrefetchHooks Function()
        > {
  $$StandTestsTableTableManager(_$AppDatabase db, $StandTestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StandTestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StandTestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StandTestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> startedAt = const Value.absent(),
                Value<String> baselinePosition = const Value.absent(),
                Value<int?> baselineHr = const Value.absent(),
                Value<int?> baselineSys = const Value.absent(),
                Value<int?> baselineDia = const Value.absent(),
                Value<int?> hr1 = const Value.absent(),
                Value<int?> sys1 = const Value.absent(),
                Value<int?> dia1 = const Value.absent(),
                Value<int?> hr3 = const Value.absent(),
                Value<int?> sys3 = const Value.absent(),
                Value<int?> dia3 = const Value.absent(),
                Value<int?> hr10 = const Value.absent(),
                Value<int?> sys10 = const Value.absent(),
                Value<int?> dia10 = const Value.absent(),
                Value<String> symptoms = const Value.absent(),
                Value<bool> stoppedEarly = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandTestsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                startedAt: startedAt,
                baselinePosition: baselinePosition,
                baselineHr: baselineHr,
                baselineSys: baselineSys,
                baselineDia: baselineDia,
                hr1: hr1,
                sys1: sys1,
                dia1: dia1,
                hr3: hr3,
                sys3: sys3,
                dia3: dia3,
                hr10: hr10,
                sys10: sys10,
                dia10: dia10,
                symptoms: symptoms,
                stoppedEarly: stoppedEarly,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String startedAt,
                Value<String> baselinePosition = const Value.absent(),
                Value<int?> baselineHr = const Value.absent(),
                Value<int?> baselineSys = const Value.absent(),
                Value<int?> baselineDia = const Value.absent(),
                Value<int?> hr1 = const Value.absent(),
                Value<int?> sys1 = const Value.absent(),
                Value<int?> dia1 = const Value.absent(),
                Value<int?> hr3 = const Value.absent(),
                Value<int?> sys3 = const Value.absent(),
                Value<int?> dia3 = const Value.absent(),
                Value<int?> hr10 = const Value.absent(),
                Value<int?> sys10 = const Value.absent(),
                Value<int?> dia10 = const Value.absent(),
                Value<String> symptoms = const Value.absent(),
                Value<bool> stoppedEarly = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandTestsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                startedAt: startedAt,
                baselinePosition: baselinePosition,
                baselineHr: baselineHr,
                baselineSys: baselineSys,
                baselineDia: baselineDia,
                hr1: hr1,
                sys1: sys1,
                dia1: dia1,
                hr3: hr3,
                sys3: sys3,
                dia3: dia3,
                hr10: hr10,
                sys10: sys10,
                dia10: dia10,
                symptoms: symptoms,
                stoppedEarly: stoppedEarly,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StandTestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StandTestsTable,
      StandTest,
      $$StandTestsTableFilterComposer,
      $$StandTestsTableOrderingComposer,
      $$StandTestsTableAnnotationComposer,
      $$StandTestsTableCreateCompanionBuilder,
      $$StandTestsTableUpdateCompanionBuilder,
      (StandTest, BaseReferences<_$AppDatabase, $StandTestsTable, StandTest>),
      StandTest,
      PrefetchHooks Function()
    >;
typedef $$SweatLogsTableCreateCompanionBuilder =
    SweatLogsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      Value<String> kinds,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$SweatLogsTableUpdateCompanionBuilder =
    SweatLogsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> kinds,
      Value<String?> note,
      Value<int> rowid,
    });

class $$SweatLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SweatLogsTable> {
  $$SweatLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kinds => $composableBuilder(
    column: $table.kinds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SweatLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SweatLogsTable> {
  $$SweatLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kinds => $composableBuilder(
    column: $table.kinds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SweatLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SweatLogsTable> {
  $$SweatLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get kinds =>
      $composableBuilder(column: $table.kinds, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$SweatLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SweatLogsTable,
          SweatLog,
          $$SweatLogsTableFilterComposer,
          $$SweatLogsTableOrderingComposer,
          $$SweatLogsTableAnnotationComposer,
          $$SweatLogsTableCreateCompanionBuilder,
          $$SweatLogsTableUpdateCompanionBuilder,
          (SweatLog, BaseReferences<_$AppDatabase, $SweatLogsTable, SweatLog>),
          SweatLog,
          PrefetchHooks Function()
        > {
  $$SweatLogsTableTableManager(_$AppDatabase db, $SweatLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SweatLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SweatLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SweatLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> kinds = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SweatLogsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                kinds: kinds,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                Value<String> kinds = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SweatLogsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                kinds: kinds,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SweatLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SweatLogsTable,
      SweatLog,
      $$SweatLogsTableFilterComposer,
      $$SweatLogsTableOrderingComposer,
      $$SweatLogsTableAnnotationComposer,
      $$SweatLogsTableCreateCompanionBuilder,
      $$SweatLogsTableUpdateCompanionBuilder,
      (SweatLog, BaseReferences<_$AppDatabase, $SweatLogsTable, SweatLog>),
      SweatLog,
      PrefetchHooks Function()
    >;
typedef $$BloodPressureReadingsTableCreateCompanionBuilder =
    BloodPressureReadingsCompanion Function({
      required String updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String date,
      required String takenAt,
      required int systolic,
      required int diastolic,
      Value<int?> pulse,
      Value<String> position,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$BloodPressureReadingsTableUpdateCompanionBuilder =
    BloodPressureReadingsCompanion Function({
      Value<String> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> date,
      Value<String> takenAt,
      Value<int> systolic,
      Value<int> diastolic,
      Value<int?> pulse,
      Value<String> position,
      Value<String?> note,
      Value<int> rowid,
    });

class $$BloodPressureReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $BloodPressureReadingsTable> {
  $$BloodPressureReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BloodPressureReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodPressureReadingsTable> {
  $$BloodPressureReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BloodPressureReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodPressureReadingsTable> {
  $$BloodPressureReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<int> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<int> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get pulse =>
      $composableBuilder(column: $table.pulse, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$BloodPressureReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BloodPressureReadingsTable,
          BloodPressureReading,
          $$BloodPressureReadingsTableFilterComposer,
          $$BloodPressureReadingsTableOrderingComposer,
          $$BloodPressureReadingsTableAnnotationComposer,
          $$BloodPressureReadingsTableCreateCompanionBuilder,
          $$BloodPressureReadingsTableUpdateCompanionBuilder,
          (
            BloodPressureReading,
            BaseReferences<
              _$AppDatabase,
              $BloodPressureReadingsTable,
              BloodPressureReading
            >,
          ),
          BloodPressureReading,
          PrefetchHooks Function()
        > {
  $$BloodPressureReadingsTableTableManager(
    _$AppDatabase db,
    $BloodPressureReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodPressureReadingsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BloodPressureReadingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BloodPressureReadingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> takenAt = const Value.absent(),
                Value<int> systolic = const Value.absent(),
                Value<int> diastolic = const Value.absent(),
                Value<int?> pulse = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodPressureReadingsCompanion(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                takenAt: takenAt,
                systolic: systolic,
                diastolic: diastolic,
                pulse: pulse,
                position: position,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String date,
                required String takenAt,
                required int systolic,
                required int diastolic,
                Value<int?> pulse = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BloodPressureReadingsCompanion.insert(
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                date: date,
                takenAt: takenAt,
                systolic: systolic,
                diastolic: diastolic,
                pulse: pulse,
                position: position,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BloodPressureReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BloodPressureReadingsTable,
      BloodPressureReading,
      $$BloodPressureReadingsTableFilterComposer,
      $$BloodPressureReadingsTableOrderingComposer,
      $$BloodPressureReadingsTableAnnotationComposer,
      $$BloodPressureReadingsTableCreateCompanionBuilder,
      $$BloodPressureReadingsTableUpdateCompanionBuilder,
      (
        BloodPressureReading,
        BaseReferences<
          _$AppDatabase,
          $BloodPressureReadingsTable,
          BloodPressureReading
        >,
      ),
      BloodPressureReading,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db, _db.dailyLogs);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$CalisthenicsTableTableManager get calisthenics =>
      $$CalisthenicsTableTableManager(_db, _db.calisthenics);
  $$TherapiesTableTableManager get therapies =>
      $$TherapiesTableTableManager(_db, _db.therapies);
  $$LiquidLogsTableTableManager get liquidLogs =>
      $$LiquidLogsTableTableManager(_db, _db.liquidLogs);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$WeatherCacheTableTableManager get weatherCache =>
      $$WeatherCacheTableTableManager(_db, _db.weatherCache);
  $$SorenessChecksTableTableManager get sorenessChecks =>
      $$SorenessChecksTableTableManager(_db, _db.sorenessChecks);
  $$CheckinsTableTableManager get checkins =>
      $$CheckinsTableTableManager(_db, _db.checkins);
  $$InjuriesTableTableManager get injuries =>
      $$InjuriesTableTableManager(_db, _db.injuries);
  $$TrainingPlansTableTableManager get trainingPlans =>
      $$TrainingPlansTableTableManager(_db, _db.trainingPlans);
  $$PlanPhasesTableTableManager get planPhases =>
      $$PlanPhasesTableTableManager(_db, _db.planPhases);
  $$PlanSessionsTableTableManager get planSessions =>
      $$PlanSessionsTableTableManager(_db, _db.planSessions);
  $$PlanExercisesTableTableManager get planExercises =>
      $$PlanExercisesTableTableManager(_db, _db.planExercises);
  $$PlanStepsTableTableManager get planSteps =>
      $$PlanStepsTableTableManager(_db, _db.planSteps);
  $$PlanSessionLogsTableTableManager get planSessionLogs =>
      $$PlanSessionLogsTableTableManager(_db, _db.planSessionLogs);
  $$PlanSetLogsTableTableManager get planSetLogs =>
      $$PlanSetLogsTableTableManager(_db, _db.planSetLogs);
  $$PlanCheckinsTableTableManager get planCheckins =>
      $$PlanCheckinsTableTableManager(_db, _db.planCheckins);
  $$PlanTestsTableTableManager get planTests =>
      $$PlanTestsTableTableManager(_db, _db.planTests);
  $$PlanTestResultsTableTableManager get planTestResults =>
      $$PlanTestResultsTableTableManager(_db, _db.planTestResults);
  $$FearItemsTableTableManager get fearItems =>
      $$FearItemsTableTableManager(_db, _db.fearItems);
  $$ExposureLogsTableTableManager get exposureLogs =>
      $$ExposureLogsTableTableManager(_db, _db.exposureLogs);
  $$StandTestsTableTableManager get standTests =>
      $$StandTestsTableTableManager(_db, _db.standTests);
  $$SweatLogsTableTableManager get sweatLogs =>
      $$SweatLogsTableTableManager(_db, _db.sweatLogs);
  $$BloodPressureReadingsTableTableManager get bloodPressureReadings =>
      $$BloodPressureReadingsTableTableManager(_db, _db.bloodPressureReadings);
}
