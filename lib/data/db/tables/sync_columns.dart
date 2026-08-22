import 'package:drift/drift.dart';

/// Shared columns for every table that will eventually sync to Supabase.
/// `updatedAt` drives last-write-wins conflict resolution; `deletedAt` is a
/// soft-delete tombstone since hard deletes don't propagate reliably in an
/// offline-first sync design. Neither is wired to a sync engine yet — see
/// the plan's "Cloud sync pivot" addendum — but adding them now avoids a
/// painful migration once sync is actually built.
mixin SyncColumns on Table {
  TextColumn get updatedAt => text()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
