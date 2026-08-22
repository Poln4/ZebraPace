import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/services/password_service.dart';

void main() {
  final service = PasswordService();

  test('the correct password verifies against its own salt+hash', () {
    final salt = service.generateSalt();
    final hash = service.hash('correct horse battery staple', salt);
    expect(service.verify('correct horse battery staple', salt, hash), isTrue);
  });

  test('a wrong password fails verification', () {
    final salt = service.generateSalt();
    final hash = service.hash('correct horse battery staple', salt);
    expect(service.verify('wrong password', salt, hash), isFalse);
  });

  test('the same password produces different hashes with different salts (no rainbow-table reuse)', () {
    final saltA = service.generateSalt();
    final saltB = service.generateSalt();
    expect(saltA, isNot(equals(saltB)));
    expect(service.hash('same password', saltA), isNot(equals(service.hash('same password', saltB))));
  });

  test('the stored hash is never the plaintext password', () {
    final salt = service.generateSalt();
    final hash = service.hash('mypassword', salt);
    expect(hash, isNot(contains('mypassword')));
  });
}
