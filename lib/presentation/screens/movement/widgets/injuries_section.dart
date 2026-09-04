import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../domain/models/injury.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_providers.dart';
import '../../../widgets/enum_wrap.dart';
import '../../../widgets/section_card.dart';

/// Injuries / structural events (app2.py) — discrete, dateable, localized,
/// deliberately separate from systemic Flare Days.
class InjuriesSection extends ConsumerStatefulWidget {
  const InjuriesSection({super.key});

  @override
  ConsumerState<InjuriesSection> createState() => _InjuriesSectionState();
}

class _InjuriesSectionState extends ConsumerState<InjuriesSection> {
  InjuryZone _zone = InjuryZone.wrist;
  InjuryKind _kind = InjuryKind.joint;
  InjuryType _type = InjuryType.subluxation;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activeInjuries = ref.watch(activeInjuriesProvider).valueOrNull ?? const [];
    final isLowEnergyDay = ref.watch(dailyLogProvider).valueOrNull?.isLowEnergyDay ?? false;

    return SectionCard(
      title: l10n.injuriesSectionTitle,
      caption: l10n.injuriesSectionCaption,
      collapsible: true,
      initiallyExpanded: !isLowEnergyDay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.injuriesSectionZoneLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          EnumWrap<InjuryZone>(
            options: InjuryZone.values,
            labelOf: (z) => z.label(l10n),
            value: _zone,
            onChanged: (v) => setState(() => _zone = v),
          ),
          const SizedBox(height: 10),
          Text(l10n.injuriesSectionKindLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          EnumWrap<InjuryKind>(
            options: InjuryKind.values,
            labelOf: (k) => k.label(l10n),
            value: _kind,
            onChanged: (v) => setState(() => _kind = v),
          ),
          const SizedBox(height: 10),
          Text(l10n.injuriesSectionTypeLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          EnumWrap<InjuryType>(
            options: InjuryType.values,
            labelOf: (t) => t.label(l10n),
            value: _type,
            onChanged: (v) => setState(() => _type = v),
          ),
          const SizedBox(height: 10),
          CupertinoTextField(
            controller: _noteController,
            placeholder: l10n.injuriesSectionNotePlaceholder,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              color: ZebraColors.sand,
              onPressed: _save,
              child: Text(l10n.injuriesSectionLogButton, style: const TextStyle(color: ZebraColors.black)),
            ),
          ),
          if (activeInjuries.isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(l10n.injuriesSectionActiveLabel, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            ...activeInjuries.map((i) => _ActiveInjuryCard(injury: i)),
          ],
        ],
      ),
    );
  }

  Future<void> _save() async {
    final date = ref.read(selectedDateProvider);
    await ref.read(injuryRepositoryProvider).insert(
          dateStarted: date,
          zone: _zone,
          kind: _kind,
          type: _type,
          note: _noteController.text,
        );
    _noteController.clear();
  }
}

class _ActiveInjuryCard extends ConsumerStatefulWidget {
  const _ActiveInjuryCard({required this.injury});

  final Injury injury;

  @override
  ConsumerState<_ActiveInjuryCard> createState() => _ActiveInjuryCardState();
}

class _ActiveInjuryCardState extends ConsumerState<_ActiveInjuryCard> {
  bool _stillPainful = true;
  ComparedToUsual? _compared;

  @override
  void initState() {
    super.initState();
    _stillPainful = widget.injury.stillPainful ?? true;
    _compared = widget.injury.comparedToUsual;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final i = widget.injury;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: ZebraColors.cardBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.injuriesSectionActiveTitle(i.zone.label(l10n), i.kind.label(l10n), i.type.label(l10n)),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          Text(l10n.injuriesSectionStarted(i.dateStarted),
              style: const TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
          if (i.note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(i.note, style: const TextStyle(fontSize: 12)),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(l10n.injuriesSectionStillPainful, style: const TextStyle(fontSize: 12)),
              CupertinoSwitch(
                value: _stillPainful,
                onChanged: (v) => setState(() => _stillPainful = v),
              ),
            ],
          ),
          EnumWrap<ComparedToUsual>(
            options: ComparedToUsual.values,
            labelOf: (c) => c.label(l10n),
            value: _compared ?? ComparedToUsual.aboutTheSame,
            onChanged: (v) => setState(() => _compared = v),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await ref.read(injuryRepositoryProvider).updateStatus(
                          i.id,
                          stillPainful: _stillPainful,
                          comparedToUsual: _compared,
                          resolve: true,
                        );
                  },
                  child: Text(l10n.injuriesSectionMarkResolved, style: const TextStyle(fontSize: 12)),
                ),
              ),
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await ref.read(injuryRepositoryProvider).updateStatus(
                          i.id,
                          stillPainful: _stillPainful,
                          comparedToUsual: _compared,
                        );
                  },
                  child: Text(l10n.injuriesSectionUpdate, style: const TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
