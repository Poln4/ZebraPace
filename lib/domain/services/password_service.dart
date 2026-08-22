import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Salted-hash password storage — a deliberate improvement over app.py's
/// plaintext `user_input == APP_PASSWORD` comparison (acceptable there for a
/// local secrets.toml only the user controls; not something to replicate
/// verbatim now that a Keychain is available). Pure Dart, no platform
/// channels, fully unit-testable.
class PasswordService {
  static const _saltBytes = 16;

  String generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(_saltBytes, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  String hash(String password, String salt) {
    final bytes = utf8.encode('$salt:$password');
    return sha256.convert(bytes).toString();
  }

  bool verify(String password, String salt, String expectedHash) {
    return hash(password, salt) == expectedHash;
  }
}
