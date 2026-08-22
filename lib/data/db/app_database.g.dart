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
  late final GeneratedColumn<int> proteinG = GeneratedColumn<int>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
        DriftSqlType.int,
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
  final int proteinG;
  final double creatineG;
  final String? mentalState;
  final String? bodyFeeling;

  /// JSON-encoded list of BraceType.db strings (app.py stored this as a
  /// Python str(list)/eval() pair — replaced with real JSON here).
  final String bracesUsed;
  final int? braceComfort;
  final int steps;
  final bool isRestDay;
  final bool isFlareDay;
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
    map['protein_g'] = Variable<int>(proteinG);
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
      proteinG: serializer.fromJson<int>(json['proteinG']),
      creatineG: serializer.fromJson<double>(json['creatineG']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
      bracesUsed: serializer.fromJson<String>(json['bracesUsed']),
      braceComfort: serializer.fromJson<int?>(json['braceComfort']),
      steps: serializer.fromJson<int>(json['steps']),
      isRestDay: serializer.fromJson<bool>(json['isRestDay']),
      isFlareDay: serializer.fromJson<bool>(json['isFlareDay']),
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
      'proteinG': serializer.toJson<int>(proteinG),
      'creatineG': serializer.toJson<double>(creatineG),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
      'bracesUsed': serializer.toJson<String>(bracesUsed),
      'braceComfort': serializer.toJson<int?>(braceComfort),
      'steps': serializer.toJson<int>(steps),
      'isRestDay': serializer.toJson<bool>(isRestDay),
      'isFlareDay': serializer.toJson<bool>(isFlareDay),
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
    int? proteinG,
    double? creatineG,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
    String? bracesUsed,
    Value<int?> braceComfort = const Value.absent(),
    int? steps,
    bool? isRestDay,
    bool? isFlareDay,
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
          ..write('isFlareDay: $isFlareDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
  );
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
          other.isFlareDay == this.isFlareDay);
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
  final Value<int> proteinG;
  final Value<double> creatineG;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<String> bracesUsed;
  final Value<int?> braceComfort;
  final Value<int> steps;
  final Value<bool> isRestDay;
  final Value<bool> isFlareDay;
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
    Expression<int>? proteinG,
    Expression<double>? creatineG,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? bracesUsed,
    Expression<int>? braceComfort,
    Expression<int>? steps,
    Expression<bool>? isRestDay,
    Expression<bool>? isFlareDay,
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
    Value<int>? proteinG,
    Value<double>? creatineG,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<String>? bracesUsed,
    Value<int?>? braceComfort,
    Value<int>? steps,
    Value<bool>? isRestDay,
    Value<bool>? isFlareDay,
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
      map['protein_g'] = Variable<int>(proteinG.value);
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
          ..write('activeEnergyKcal: $activeEnergyKcal')
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
          other.activeEnergyKcal == this.activeEnergyKcal);
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
    comfortScore,
    mentalState,
    bodyFeeling,
    contractionMode,
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
  final int sets;
  final int reps;

  /// 1.0-5.0 comfort slider value — the only comfort field that matters.
  /// app.py's original also had a dead/unused legacy `comfortable` boolean
  /// column; deliberately not ported.
  final double comfortScore;
  final String? mentalState;
  final String? bodyFeeling;
  final String? contractionMode;
  const Calisthenic({
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.date,
    required this.exercise,
    required this.progression,
    required this.sets,
    required this.reps,
    required this.comfortScore,
    this.mentalState,
    this.bodyFeeling,
    this.contractionMode,
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
      comfortScore: serializer.fromJson<double>(json['comfortScore']),
      mentalState: serializer.fromJson<String?>(json['mentalState']),
      bodyFeeling: serializer.fromJson<String?>(json['bodyFeeling']),
      contractionMode: serializer.fromJson<String?>(json['contractionMode']),
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
      'comfortScore': serializer.toJson<double>(comfortScore),
      'mentalState': serializer.toJson<String?>(mentalState),
      'bodyFeeling': serializer.toJson<String?>(bodyFeeling),
      'contractionMode': serializer.toJson<String?>(contractionMode),
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
    double? comfortScore,
    Value<String?> mentalState = const Value.absent(),
    Value<String?> bodyFeeling = const Value.absent(),
    Value<String?> contractionMode = const Value.absent(),
  }) => Calisthenic(
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    date: date ?? this.date,
    exercise: exercise ?? this.exercise,
    progression: progression ?? this.progression,
    sets: sets ?? this.sets,
    reps: reps ?? this.reps,
    comfortScore: comfortScore ?? this.comfortScore,
    mentalState: mentalState.present ? mentalState.value : this.mentalState,
    bodyFeeling: bodyFeeling.present ? bodyFeeling.value : this.bodyFeeling,
    contractionMode: contractionMode.present
        ? contractionMode.value
        : this.contractionMode,
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
          ..write('comfortScore: $comfortScore, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('contractionMode: $contractionMode')
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
    comfortScore,
    mentalState,
    bodyFeeling,
    contractionMode,
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
          other.comfortScore == this.comfortScore &&
          other.mentalState == this.mentalState &&
          other.bodyFeeling == this.bodyFeeling &&
          other.contractionMode == this.contractionMode);
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
  final Value<double> comfortScore;
  final Value<String?> mentalState;
  final Value<String?> bodyFeeling;
  final Value<String?> contractionMode;
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
    this.comfortScore = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.contractionMode = const Value.absent(),
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
    this.comfortScore = const Value.absent(),
    this.mentalState = const Value.absent(),
    this.bodyFeeling = const Value.absent(),
    this.contractionMode = const Value.absent(),
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
    Expression<double>? comfortScore,
    Expression<String>? mentalState,
    Expression<String>? bodyFeeling,
    Expression<String>? contractionMode,
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
      if (comfortScore != null) 'comfort_score': comfortScore,
      if (mentalState != null) 'mental_state': mentalState,
      if (bodyFeeling != null) 'body_feeling': bodyFeeling,
      if (contractionMode != null) 'contraction_mode': contractionMode,
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
    Value<double>? comfortScore,
    Value<String?>? mentalState,
    Value<String?>? bodyFeeling,
    Value<String?>? contractionMode,
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
      comfortScore: comfortScore ?? this.comfortScore,
      mentalState: mentalState ?? this.mentalState,
      bodyFeeling: bodyFeeling ?? this.bodyFeeling,
      contractionMode: contractionMode ?? this.contractionMode,
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
          ..write('comfortScore: $comfortScore, ')
          ..write('mentalState: $mentalState, ')
          ..write('bodyFeeling: $bodyFeeling, ')
          ..write('contractionMode: $contractionMode, ')
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
      Value<int> proteinG,
      Value<double> creatineG,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> bracesUsed,
      Value<int?> braceComfort,
      Value<int> steps,
      Value<bool> isRestDay,
      Value<bool> isFlareDay,
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
      Value<int> proteinG,
      Value<double> creatineG,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String> bracesUsed,
      Value<int?> braceComfort,
      Value<int> steps,
      Value<bool> isRestDay,
      Value<bool> isFlareDay,
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

  ColumnFilters<int> get proteinG => $composableBuilder(
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

  ColumnOrderings<int> get proteinG => $composableBuilder(
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

  GeneratedColumn<int> get proteinG =>
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
                Value<int> proteinG = const Value.absent(),
                Value<double> creatineG = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> bracesUsed = const Value.absent(),
                Value<int?> braceComfort = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<bool> isRestDay = const Value.absent(),
                Value<bool> isFlareDay = const Value.absent(),
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
                Value<int> proteinG = const Value.absent(),
                Value<double> creatineG = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String> bracesUsed = const Value.absent(),
                Value<int?> braceComfort = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<bool> isRestDay = const Value.absent(),
                Value<bool> isFlareDay = const Value.absent(),
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
      Value<double> comfortScore,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String?> contractionMode,
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
      Value<double> comfortScore,
      Value<String?> mentalState,
      Value<String?> bodyFeeling,
      Value<String?> contractionMode,
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
                Value<double> comfortScore = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String?> contractionMode = const Value.absent(),
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
                comfortScore: comfortScore,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                contractionMode: contractionMode,
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
                Value<double> comfortScore = const Value.absent(),
                Value<String?> mentalState = const Value.absent(),
                Value<String?> bodyFeeling = const Value.absent(),
                Value<String?> contractionMode = const Value.absent(),
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
                comfortScore: comfortScore,
                mentalState: mentalState,
                bodyFeeling: bodyFeeling,
                contractionMode: contractionMode,
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
}
