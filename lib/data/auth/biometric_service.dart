import 'package:local_auth/local_auth.dart';

/// Thin wrapper over local_auth. Every method degrades to false/empty on
/// error rather than throwing — biometrics being unavailable/unenrolled is
/// a first-class expected state, not a crash.
class BiometricService {
  BiometricService([LocalAuthentication? auth]) : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> isAvailable() async {
    try {
      // canCheckBiometrics is true whenever the hardware exists, even with
      // no face/finger enrolled — then the prompt falls straight through to
      // the device passcode, so only count biometrics that are set up.
      final supported = await _auth.isDeviceSupported();
      final enrolled = await _auth.getAvailableBiometrics();
      return supported && enrolled.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// biometricOnly: false lets the OS fall back to the device passcode —
  /// still a device-level credential the user controls, not a bypass.
  Future<bool> authenticate({String reason = 'Unlock ZebraPace'}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(biometricOnly: false, stickyAuth: true),
      );
    } catch (_) {
      return false;
    }
  }
}
