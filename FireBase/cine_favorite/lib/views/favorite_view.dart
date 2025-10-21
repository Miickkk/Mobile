import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _registrando = false;
  String _status = "Aguardando registro...";
  Position? _posicaoAtual;

  // Coordenadas do local de trabalho (exemplo: escola/fábrica)
  final double localLat = -23.5505;
  final double localLon = -46.6333;

  Future<void> _registrarPonto() async {
    setState(() {
      _registrando = true;
      _status = "Verificando localização...";
    });

    try {
      // Pedir permissão de localização
      LocationPermission perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        setState(() {
          _status = "Permissão de localização negada.";
          _registrando = false;
        });
        return;
      }

      // Pegar posição atual
      Position posicao = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double distancia = Geolocator.distanceBetween(
        localLat,
        localLon,
        posicao.latitude,
        posicao.longitude,
      );

      if (distancia <= 100) {
        await _firestore.collection("registros_ponto").add({
          "uid": _auth.currentUser!.uid,
          "email": _auth.currentUser!.email,
          "data": DateTime.now().toIso8601String(),
          "latitude": posicao.latitude,
          "longitude": posicao.longitude,
        });

        setState(() {
          _status = "Ponto registrado com sucesso!";
          _posicaoAtual = posicao;
        });
      } else {
        setState(() {
          _status =
              "Fora do raio permitido (Distância: ${distancia.toStringAsFixed(1)} m)";
        });
      }
    } catch (e) {
      setState(() {
        _status = "Erro ao registrar ponto: $e";
      });
    }

    setState(() {
      _registrando = false;
    });
  }

  Future<void> _logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E),
      appBar: AppBar(
        title: const Text("Registro de Ponto"),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time_rounded,
                color: Colors.greenAccent.shade400, size: 100),
            const SizedBox(height: 20),
            Text(
              "Olá, ${user?.email ?? "Usuário"}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "Registre seu ponto quando estiver próximo do local de trabalho.",
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.fingerprint, size: 26),
              onPressed: _registrando ? null : _registrarPonto,
              label: Text(
                _registrando ? "Registrando..." : "Registrar Ponto",
                style: const TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 4,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _status,
              style: TextStyle(
                color: _status.contains("✅")
                    ? Colors.greenAccent
                    : Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (_posicaoAtual != null)
              Text(
                "Localização: ${_posicaoAtual!.latitude.toStringAsFixed(5)}, ${_posicaoAtual!.longitude.toStringAsFixed(5)}",
                style: const TextStyle(color: Colors.white54, fontSize: 14),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
