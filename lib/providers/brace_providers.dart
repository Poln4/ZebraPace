import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/defaults.dart';
import '../core/utils/id_gen.dart';
import '../data/repositories/settings_repository.dart';
import '../domain/models/brace_use.dart';
import 'app_providers.dart';

/// Braces the person added to the picker themselves, in the order added.
/// Stored as JSON under SettingsKeys.customBraces, so they travel with the
/// settings in exports and need no table of their own.
final customBracesProvider = StreamProvider<List<CustomBrace>>((ref) {
  return ref
      .watch(settingsRepositoryProvider)
      .watchAll()
      .map((m) => decodeCustomBraces(m[SettingsKeys.customBraces]));
});

List<CustomBrace> decodeCustomBraces(String? raw) {
  if (raw == null || raw.isEmpty) return const [];
  try {
    return (jsonDecode(raw) as List).map(CustomBrace.fromJson).whereType<CustomBrace>().toList();
  } catch (_) {
    return const [];
  }
}

/// Adds [name] to the list, or returns the existing entry when one with the
/// same name (ignoring case) is already there.
Future<CustomBrace> addCustomBrace(SettingsRepository settings, String name) async {
  final current = decodeCustomBraces(await settings.getString(SettingsKeys.customBraces, ''));
  final trimmed = name.trim();
  for (final b in current) {
    if (b.name.toLowerCase() == trimmed.toLowerCase()) return b;
  }
  final brace = CustomBrace(id: newId(), name: trimmed);
  await _save(settings, [...current, brace]);
  return brace;
}

/// Removes it from the picker only; days already logged keep their copy.
Future<void> removeCustomBrace(SettingsRepository settings, String id) async {
  final current = decodeCustomBraces(await settings.getString(SettingsKeys.customBraces, ''));
  await _save(settings, [for (final b in current) if (b.id != id) b]);
}

Future<void> _save(SettingsRepository settings, List<CustomBrace> braces) =>
    settings.set(SettingsKeys.customBraces, jsonEncode([for (final b in braces) b.toJson()]));
