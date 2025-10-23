import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> obterLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivo) throw Exception('Serviço de localização desativado.');

    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        throw Exception('Permissão de localização negada.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      throw Exception('Permissão permanentemente negada.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  bool dentroDoRaio({
    required double latRef,
    required double lonRef,
    required double latAtual,
    required double lonAtual,
    required double raioMetros,
  }) {
    final distancia = Geolocator.distanceBetween(
      latRef,
      lonRef,
      latAtual,
      lonAtual,
    );
    return distancia <= raioMetros;
  }
}
