import 'package:flutter/cupertino.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/theme/zebra_theme.dart';
import '../../../../l10n/app_localizations.dart';

/// One field per set, so sets can differ (30, 20, 23), plus a reps/seconds
/// toggle for isometric holds. Shared by CalisthenicsSection's log form and
/// the edit sheet. [onChanged] gets the filled-in values only — blank or
/// zero fields are skipped.
class SetValuesEditor extends StatefulWidget {
  const SetValuesEditor({
    super.key,
    required this.initialValues,
    required this.unit,
    required this.onUnitChanged,
    required this.onChanged,
  });

  /// One entry per starting field; null leaves that field blank.
  final List<int?> initialValues;
  final SetUnit unit;
  final ValueChanged<SetUnit> onUnitChanged;
  final ValueChanged<List<int>> onChanged;

  @override
  State<SetValuesEditor> createState() => _SetValuesEditorState();
}

class _SetValuesEditorState extends State<SetValuesEditor> {
  late final List<TextEditingController> _controllers = [
    for (final v in widget.initialValues) _newController(v?.toString() ?? ''),
  ];

  TextEditingController _newController(String text) =>
      TextEditingController(text: text)..addListener(_emit);

  void _emit() {
    widget.onChanged([
      for (final c in _controllers)
        if ((int.tryParse(c.text.trim()) ?? 0) > 0) int.parse(c.text.trim()),
    ]);
  }

  void _addSet() {
    // Pre-fill with the previous set's value — most sets repeat or drop
    // a little, so editing beats typing from scratch.
    setState(() => _controllers.add(_newController(_controllers.lastOrNull?.text ?? '')));
    _emit();
  }

  void _removeSet() {
    if (_controllers.length <= 1) return;
    setState(() => _controllers.removeLast().dispose());
    _emit();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(l10n.calisthenicsSectionSetsPlaceholder,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
            CupertinoSlidingSegmentedControl<SetUnit>(
              groupValue: widget.unit,
              children: {
                for (final u in SetUnit.values)
                  u: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(u.label(l10n), style: const TextStyle(fontSize: 11)),
                  ),
              },
              onValueChanged: (u) {
                if (u != null) widget.onUnitChanged(u);
              },
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var i = 0; i < _controllers.length; i++)
              SizedBox(
                width: 72,
                child: CupertinoTextField(
                  controller: _controllers[i],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  placeholder: l10n.calisthenicsSectionSetFieldPlaceholder(i + 1),
                  suffix: widget.unit == SetUnit.seconds
                      ? const Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text('s', style: TextStyle(fontSize: 12)),
                        )
                      : null,
                ),
              ),
            _StepButton(label: l10n.calisthenicsSectionAddSet, onTap: _addSet),
            if (_controllers.length > 1)
              _StepButton(label: l10n.calisthenicsSectionRemoveSet, onTap: _removeSet),
          ],
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: ZebraColors.bg,
          border: Border.all(color: ZebraColors.cardBorder),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label, style: const TextStyle(fontSize: 11.5, color: ZebraColors.onColor)),
      ),
    );
  }
}
