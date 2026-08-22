import '../../core/constants/enums.dart';

class Therapy {
  const Therapy({
    required this.id,
    required this.date,
    required this.therapyName,
    required this.durationMin,
    this.mentalState,
    this.bodyFeeling,
  });

  final String id;
  final String date;
  final String therapyName;
  final int durationMin;
  final MentalState? mentalState;
  final BodyFeeling? bodyFeeling;
}
