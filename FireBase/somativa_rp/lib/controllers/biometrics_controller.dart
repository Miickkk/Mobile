import 'package:local_auth/local_auth.dart';

class BiometricsController {
  final LocalAuthentication _auth = LocalAuthentication();

  // verifica se o dispositivo suporta biometria
  Future<bool> canCheckBiometrics() async {
    return await _auth.canCheckBiometrics;
  }

  // autenticar usuário via biometria
  Future<bool> authenticate() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Autentique-se para registrar o ponto',
        biometricOnly: true,
      );
    } catch (e) {
      return false;
    }
  }
}
