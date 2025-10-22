import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'history_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _carregando = false;
  String? _ultimoTipo; // "entrada" ou "saida"
  String _status = "Aguardando registro...";
  Position? _posicaoAtual;

  // Coordenadas do local de trabalho
  final double localLat = -23.5505;
  final double localLon = -46.6333;
  final double raioPermitido = 100; // metros

  @override
  void initState() {
    super.initState();
    _buscarUltimoRegistro();
  }

  Future<void> _buscarUltimoRegistro() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot = await _db
        .collection('registros_ponto')
        .where('uid', isEqualTo: user.uid)
        .orderBy('data', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      _ultimoTipo = snapshot.docs.first['tipo'];
      setState(() {});
    }
  }

  Future<void> _baterPonto(String tipo) async {
    setState(() {
      _carregando = true;
      _status = "Verificando permissões...";
    });

    final user = _auth.currentUser;
    if (user == null) {
      setState(() {
        _status = "Usuário não logado!";
        _carregando = false;
      });
      return;
    }

    // Confirma senha antes do registro
    final senhaValida = await _confirmarSenha();
    if (!senhaValida) {
      setState(() {
        _status = "Senha incorreta ou cancelada.";
        _carregando = false;
      });
      return;
    }

    bool servicoHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!servicoHabilitado) {
      setState(() {
        _status = "Ative o serviço de localização!";
        _carregando = false;
      });
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        setState(() {
          _status = "Permissão de localização negada!";
          _carregando = false;
        });
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      setState(() {
        _status = "Permissão de localização permanentemente negada!";
        _carregando = false;
      });
      return;
    }

    final posicao = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final distancia = Geolocator.distanceBetween(
      localLat, localLon, posicao.latitude, posicao.longitude);

    if (distancia > raioPermitido) {
      setState(() {
        _status = "Você está fora do limite (${distancia.toStringAsFixed(1)} m)";
        _carregando = false;
      });
      return;
    }

    await _db.collection('registros_ponto').add({
      'uid': user.uid,
      'data': Timestamp.now(),
      'tipo': tipo,
      'latitude': posicao.latitude,
      'longitude': posicao.longitude,
      'distancia': distancia,
    });

    _ultimoTipo = tipo;
    setState(() {
      _carregando = false;
      _status = "✅ Ponto de $tipo registrado!";
      _posicaoAtual = posicao;
    });
  }

  Future<bool> _confirmarSenha() async {
    final TextEditingController senhaController = TextEditingController();
    bool confirmado = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar senha'),
        content: TextField(
          controller: senhaController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Senha'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                final cred = EmailAuthProvider.credential(
                  email: _auth.currentUser!.email!,
                  password: senhaController.text,
                );
                await _auth.currentUser!.reauthenticateWithCredential(cred);
                confirmado = true;
                Navigator.pop(context);
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Senha incorreta.')),
                );
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );

    return confirmado;
  }

  Future<void> _logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final podeEntrar = _ultimoTipo == 'saida' || _ultimoTipo == null;
    final podeSair = _ultimoTipo == 'entrada';
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
              Icon(Icons.access_time_rounded,
                  color: Colors.greenAccent.shade400, size: 100),
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
                "Registre sua entrada e saída quando estiver próximo do local de trabalho.",
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 🔹 Botões de ponto
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed:
                        _carregando || !podeEntrar ? null : () => _baterPonto('entrada'),
                    icon: const Icon(Icons.login_rounded),
                    label: Text(
                      _carregando && podeEntrar
                          ? "Registrando..."
                          : "Registrar Entrada",
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed:
                        _carregando || !podeSair ? null : () => _baterPonto('saida'),
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(
                      _carregando && podeSair
                          ? "Registrando..."
                          : "Registrar Saída",
                      style: const TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _carregando
                        ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HistoryView()),
                            ),
                    icon: const Icon(Icons.history_rounded),
                    label: const Text(
                      "Ver Histórico",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[500],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
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
                  color: _status.contains("✅")
                      ? Colors.greenAccent
                      : Colors.white70,
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
                Text(
                  "Último ponto: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
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
