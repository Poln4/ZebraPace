import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/sources.dart';

void main() {
  test('every topic lists only known sources, and every source is used', () {
    final used = <String>{};
    for (final topic in SourceTopic.values) {
      final ids = kSourcesByTopic[topic];
      expect(ids, isNotNull, reason: '$topic has no sources');
      expect(ids, isNotEmpty);
      for (final id in ids!) {
        expect(kSources.containsKey(id), isTrue, reason: '$topic → unknown $id');
        used.add(id);
      }
    }
    expect(kSources.keys.toSet().difference(used), isEmpty);
  });

  test('every source links to a DOI or an official https page', () {
    for (final s in kSources.values) {
      expect(s.url, startsWith('https://'));
      expect(s.title, isNotEmpty);
      expect(s.authors, isNotEmpty);
    }
  });
}
