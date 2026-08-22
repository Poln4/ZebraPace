import '../../core/constants/enums.dart';
import '../../l10n/app_localizations.dart';

class LiquidLog {
  const LiquidLog({
    required this.id,
    required this.date,
    required this.drinkType,
    required this.amountMlRaw,
    required this.hydrationMlCredit,
    this.customDrinkLabel,
  });

  final String id;
  final String date;
  final DrinkType drinkType;
  final String? customDrinkLabel;
  final int amountMlRaw;
  final double hydrationMlCredit;

  String displayName(AppLocalizations l10n) =>
      drinkType == DrinkType.other && (customDrinkLabel?.isNotEmpty ?? false)
          ? customDrinkLabel!
          : drinkType.label(l10n);

  static double creditFor(DrinkType type, int amountMl) => amountMl * type.hydrationFactor;
}
