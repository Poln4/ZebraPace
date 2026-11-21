import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "No se vende el freno" (business_plan.md §4.3), enforced in code: the
/// safety logic — today's load adjustment, the load ceiling, the PEM
/// caution line and the pacing alerts — must not be able to reach the
/// Zebras+ checkpoint through any chain of imports. If this fails, move
/// the paid check up into the screen that shows the deeper view instead.

/// Files that decide or deliver today's safety guidance.
const safetyRoots = [
  'lib/domain/services/pacing_service.dart',
  'lib/domain/services/pem_service.dart',
  'lib/domain/services/readiness_service.dart',
  'lib/data/notifications/pacing_alert_bridge.dart',
  'lib/providers/reminder_providers.dart',
];

/// The Zebras+ checkpoint and everything that exists only to feed it.
const plusFiles = [
  'lib/providers/plus_providers.dart',
  'lib/domain/services/plus_access.dart',
  'lib/data/plus/plus_entitlement_store.dart',
  'lib/data/plus/ai_credits_repository.dart',
  'lib/data/plus/revenuecat_service.dart',
  'lib/core/config/revenuecat_config.dart',
];

final _directive = RegExp(
  r'''^\s*(?:import|export)\s+['"]([^'"]+)['"]''',
  multiLine: true,
);

/// Local (lib/) files [path] imports or exports, normalised to
/// `lib/...` paths. Package and dart: imports are ignored.
List<String> _localDeps(String path) {
  final source = File(path).readAsStringSync();
  final dir = File(path).parent.uri;
  final deps = <String>[];
  for (final match in _directive.allMatches(source)) {
    final target = match.group(1)!;
    String? resolved;
    if (target.startsWith('package:zebrapace_app/')) {
      resolved = 'lib/${target.substring('package:zebrapace_app/'.length)}';
    } else if (!target.contains(':')) {
      resolved = Directory.current.uri
          .resolve(dir.resolve(target).path)
          .toFilePath()
          .replaceFirst('${Directory.current.path}/', '');
    }
    if (resolved != null) deps.add(resolved);
  }
  return deps;
}

/// Every lib/ file reachable from [root], mapped to the file that first
/// pulled it in (for a readable failure path).
Map<String, String?> _reachable(String root) {
  final parent = <String, String?>{root: null};
  final queue = [root];
  while (queue.isNotEmpty) {
    final current = queue.removeLast();
    if (!File(current).existsSync()) continue;
    for (final dep in _localDeps(current)) {
      if (parent.containsKey(dep)) continue;
      parent[dep] = current;
      queue.add(dep);
    }
  }
  return parent;
}

String _chain(Map<String, String?> parent, String file) {
  final path = <String>[file];
  var node = parent[file];
  while (node != null) {
    path.add(node);
    node = parent[node];
  }
  return path.reversed.join('\n  → ');
}

void main() {
  test('every safety root and Zebras+ file exists (renames must update this test)', () {
    for (final path in [...safetyRoots, ...plusFiles]) {
      expect(File(path).existsSync(), isTrue, reason: '$path is missing');
    }
  });

  test('the import walker follows relative and package imports', () {
    // Guards against the boundary test passing vacuously.
    final fromReminders = _reachable('lib/providers/reminder_providers.dart');
    expect(fromReminders, contains('lib/domain/services/readiness_service.dart'));
    expect(fromReminders, contains('lib/data/notifications/pacing_alert_bridge.dart'));
    final fromPlus = _reachable('lib/providers/plus_providers.dart');
    expect(fromPlus, contains('lib/domain/services/plus_access.dart'));
  });

  for (final root in safetyRoots) {
    test('$root cannot reach the Zebras+ checkpoint', () {
      final parent = _reachable(root);
      final leaks = plusFiles.where(parent.containsKey).toList();
      expect(
        leaks,
        isEmpty,
        reason: 'Safety code must stay free. Import chain:\n  '
            '${leaks.map((f) => _chain(parent, f)).join('\n\n  ')}',
      );
    });
  }
}
