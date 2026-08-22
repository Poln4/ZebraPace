import '../../core/constants/enums.dart';

class Checkin {
  const Checkin({
    required this.id,
    required this.date,
    required this.loggedAt,
    required this.mentalState,
    required this.bodyFeeling,
    this.note = '',
  });

  final String id;
  final String date;
  final String loggedAt; // 'HH:mm'
  final MentalState mentalState;
  final BodyFeeling bodyFeeling;
  final String note;
}
