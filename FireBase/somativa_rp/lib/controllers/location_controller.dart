import 'package:geolocator/geolocator.dart';

class LocationController {
  // Verifica e solicita permissão de localização
  Future<bool> requestPermission() async {
    try {
      // Verifica se o GPS está ligado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Serviço de localização desativado.');
        await Geolocator.openLocationSettings(); // Abre configurações
        return false;
      }

      // Verifica status da permissão
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        print('Permissão negada permanentemente. Vá nas configurações.');
        await Geolocator.openAppSettings(); // Abre config do app
        return false;
      }

      if (permission == LocationPermission.denied) {
        print('Permissão de localização negada.');
        return false;
      }

      print('Permissão de localização concedida.');
      return true;
    } catch (e) {
      print('Erro ao solicitar permissão: $e');
      return false;
    }
  }

  // Obtém posição atual com timeout para evitar travamento
  Future<Position?> getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Tempo limite ao tentar obter localização.');
        },
      );
    } catch (e) {
      print('Erro ao obter posição: $e');
      return null;
    }
  }

  // Calcula distância entre dois pontos
  double calculateDistance(
    double startLat,
    double startLon,
    double endLat,
    double endLon,
  ) {
    return Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
  }
}
