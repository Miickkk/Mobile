// lib/controllers/ponto_controller.dart

import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // necessário para Firestore
import '../models/registro_ponto.dart';
import '../servcices/location_service.dart';

class PontoController {
  final LocationService _locationService = LocationService();

  final List<RegistroPonto> _registros = [];
  List<RegistroPonto> get registros => _registros;

  // Coordenadas fixas do local permitido
  final double _empresaLat = -23.567; // ajuste conforme necessário
  final double _empresaLon = -46.648;

  // Registrar ponto
  Future<void> registrarPonto(String tipo) async {

    final Position posicao = await _locationService.obterLocalizacao();
    final bool dentroRaio = _locationService.dentroDoRaio(
      latRef: _empresaLat,
      lonRef: _empresaLon,
      latAtual: posicao.latitude,
      lonAtual: posicao.longitude,
      raioMetros: 100, // raio em metros
    );

    if (!dentroRaio) {
      throw Exception('Você está fora do local autorizado.');
    }

    final registro = RegistroPonto(
      dataHora: DateTime.now(),
      tipo: tipo,
      latitude: posicao.latitude,
      longitude: posicao.longitude,
    );

    _registros.add(registro);

    // Salvar no Firestore
    await FirebaseFirestore.instance.collection('registros_ponto').add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'tipo': tipo,
      'data': FieldValue.serverTimestamp(),
      'latitude': posicao.latitude,
      'longitude': posicao.longitude,
    });
  }

  // Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
