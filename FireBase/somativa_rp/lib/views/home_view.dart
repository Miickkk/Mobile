import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../services/rpdb_service.dart';
import '../controllers/location_controller.dart';
import 'history_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocationController _locationController = LocationController();

  bool _registrando = false;
  String _status = "Aguardando registro...";
  Position? _posicaoAtual;

  // Coordenadas do local de trabalho
  final double localLat = -23.5505;
  final double localLon = -46.6333;
  final double raioPermitido = 100; // metros

  Future<void> _registrarPonto() async {
    setState(() {
      _registrando = true;
      _status = "Verificando usuário e localização...";
    });

    final user = _auth.currentUser;
    if (user == null) {
      setState(() {
        _status = "Usuário não logado!";
        _registrando = false;
      });
      return;
    }

    // Solicitar permissão de localização
    bool temPermissao = await _locationController.requestPermission();
    if (!temPermissao) {
      setState(() {
        _status = "Permissão de localização negada!";
        _registrando = false;
      });
      return;
    }

    // Obter posição atual
    Position? posicao = await _locationController.getCurrentPosition();
    if (posicao == null) {
      setState(() {
        _status = "Erro ao obter localização!";
        _registrando = false;
      });
      return;
    }

    // Calcular distância
    double distancia = _locationController.calculateDistance(
        localLat, localLon, posicao.latitude, posicao.longitude);

    if (distancia > raioPermitido) {
      setState(() {
        _status = "Fora do raio permitido (${distancia.toStringAsFixed(1)} m)";
        _registrando = false;
      });
      return;
    }

    try {
      // Chamada correta do método estático
      await RpdbService.addAttendance(
          latitude: posicao.latitude, longitude: posicao.longitude);

      setState(() {
        _status = "✅ Ponto registrado com sucesso!";
        _posicaoAtual = posicao;
      });
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
    // Redirecionar para login se houver
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
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time_rounded,
                color: Colors.greenAccent.shade400,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                "Olá, ${user?.email ?? "Usuário"}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Registre seu ponto quando estiver próximo do local de trabalho.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Botões alinhados verticalmente
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _registrando ? null : _registrarPonto,
                    icon: const Icon(Icons.edit_location_rounded),
                    label: Text(
                      _registrando ? "Registrando..." : "Registrar Ponto",
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HistoryView()),
                      );
                    },
                    icon: const Icon(Icons.history_rounded),
                    label: const Text(
                      "Ver Histórico",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Text(
                _status,
                style: TextStyle(
                  color: _status.contains("✅") ? Colors.greenAccent : Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              if (_posicaoAtual != null) ...[
                const SizedBox(height: 16),
                Text(
                  "Localização: ${_posicaoAtual!.latitude.toStringAsFixed(5)}, ${_posicaoAtual!.longitude.toStringAsFixed(5)}",
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
