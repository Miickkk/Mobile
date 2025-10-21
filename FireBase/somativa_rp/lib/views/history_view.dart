import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  List<Map<String, dynamic>> _history = [];

  Future<void> _fetchHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final uid = _auth.currentUser!.uid;
      final snapshot = await _firestore
          .collection("registros_ponto")
          .where("uid", isEqualTo: uid)
          .orderBy("data", descending: true)
          .get();

      final data = snapshot.docs.map((doc) {
        final map = doc.data();
        map["id"] = doc.id;
        return map;
      }).toList();

      setState(() {
        _history = data;
      });
    } catch (e) {
      setState(() {
        _history = [];
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao buscar histórico: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E),
      appBar: AppBar(
        title: const Text("Histórico de Pontos"),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Olá, ${user?.email ?? "Usuário"}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              "Veja abaixo todos os registros de ponto já realizados.",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.green))
                : _history.isEmpty
                    ? const Text(
                        "Nenhum registro encontrado",
                        style: TextStyle(color: Colors.white70),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _history.length,
                          itemBuilder: (context, index) {
                            final registro = _history[index];
                            final data = DateTime.parse(registro["data"]);
                            final lat = registro["latitude"];
                            final lon = registro["longitude"];

                            return Card(
                              color: Colors.green[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                leading: const Icon(Icons.access_time_rounded,
                                    color: Colors.greenAccent, size: 36),
                                title: Text(
                                  "${data.day}/${data.month}/${data.year} ${data.hour}:${data.minute.toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "Localização: ${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
