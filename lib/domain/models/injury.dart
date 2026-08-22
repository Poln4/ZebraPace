import '../../core/constants/enums.dart';

class Injury {
  const Injury({
    required this.id,
    required this.dateStarted,
    required this.zone,
    required this.kind,
    required this.type,
    this.note = '',
    this.resolvedAt,
    this.stillPainful,
    this.comparedToUsual,
  });

  final String id;
  final String dateStarted;
  final InjuryZone zone;
  final InjuryKind kind;
  final InjuryType type;
  final String note;
  final String? resolvedAt;
  final bool? stillPainful;
  final ComparedToUsual? comparedToUsual;

  bool get isActive => resolvedAt == null;

  String get statusLabel => isActive ? 'Active' : 'Resolved $resolvedAt';
}
