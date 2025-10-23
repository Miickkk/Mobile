import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'history_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _carregando = false;
  String? _mensagem;

  // Coordenadas fixas da empresa
  final double empresaLat = -23.567;
  final double empresaLon = -46.648;
  final double raioMetros = 100;

  Future<void> _registrarPonto(String tipo) async {
    setState(() {
      _carregando = true;
      _mensagem = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled)
        throw Exception("Serviço de localização desativado.");

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permissão de localização negada.");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception("Permissão de localização permanentemente negada.");
      }

      final posicao = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final distancia = Geolocator.distanceBetween(
        empresaLat,
        empresaLon,
        posicao.latitude,
        posicao.longitude,
      );

      final dentroDoRaio = distancia <= raioMetros;

      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('registros_ponto').add({
        'uid': uid,
        'tipo': tipo,
        'data': FieldValue.serverTimestamp(),
        'latitude': posicao.latitude,
        'longitude': posicao.longitude,
        'distancia': distancia,
        'dentroDoRaio': dentroDoRaio,
      });

      setState(() {
        _mensagem = dentroDoRaio
            ? "Registro de $tipo realizado com sucesso!"
            : "Você está fora do local autorizado! Distância: ${distancia.toStringAsFixed(1)} m";
      });
    } catch (e) {
      setState(() {
        _mensagem = "Erro ao registrar $tipo: $e";
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  void _abrirHistorico() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoryView()),
    );
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: const Text("Registro de Ponto"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: "Histórico",
            onPressed: _abrirHistorico,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: _carregando
            ? const CircularProgressIndicator(color: Colors.greenAccent)
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_filled,
                      color: Colors.greenAccent,
                      size: 90,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Registrar Ponto",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () => _registrarPonto("Entrada"),
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: const Text("Registrar Entrada"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 40,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _registrarPonto("Saída"),
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("Registrar Saída"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 40,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_mensagem != null)
                      Text(
                        _mensagem!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
