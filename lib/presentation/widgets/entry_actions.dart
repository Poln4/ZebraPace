import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

/// Shared "tap a logged entry" flow used by Activities, Calisthenics, and
/// Hydration — an action sheet offering Edit/Delete, and (for Delete) a
/// confirmation dialog before anything is actually removed. Kept generic:
/// callers own their own edit UI, this only owns the two universal prompts.
enum EntryAction { edit, delete }

Future<EntryAction?> showEntryActionSheet(BuildContext context, AppLocalizations l10n) {
  return showCupertinoModalPopup<EntryAction>(
    context: context,
    builder: (sheetContext) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          onPressed: () => Navigator.of(sheetContext).pop(EntryAction.edit),
          child: Text(l10n.commonEditButton),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(sheetContext).pop(EntryAction.delete),
          child: Text(l10n.commonDeleteButton),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(sheetContext).pop(),
        child: Text(l10n.commonCancelButton),
      ),
    ),
  );
}

Future<bool> confirmDelete(BuildContext context, AppLocalizations l10n) async {
  final confirmed = await showCupertinoDialog<bool>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(l10n.commonDeleteConfirmTitle),
      content: Text(l10n.commonDeleteConfirmMessage),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.commonCancelButton),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.commonDeleteButton),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
