import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final registrosStream = FirebaseFirestore.instance
        .collection('registros_ponto') 
        .where('uid', isEqualTo: uid) 
        .orderBy('data', descending: true) 
        .snapshots(); 

    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E),
      appBar: AppBar(
        title: const Text("Histórico de Pontos"),
        backgroundColor: Colors.green[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: registrosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar histórico: ${snapshot.error}",
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum registro encontrado.",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final registro = docs[index].data() as Map<String, dynamic>;

              final dataHora = (registro["data"] as Timestamp).toDate();

              final tipo = registro["tipo"] ?? "Indefinido";
              final distancia = registro["distancia"];
              final lat = registro["latitude"];
              final lon = registro["longitude"];

              return Card(
                color: Colors.green[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.access_time_rounded,
                    color: Colors.greenAccent,
                    size: 36,
                  ),
                  title: Text(
                    "${tipo.toString().toUpperCase()} - ${DateFormat('dd/MM/yyyy HH:mm').format(dataHora)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (distancia != null)
                        Text(
                          "Distância: ${distancia.toStringAsFixed(1)} m",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      if (lat != null && lon != null)
                        Text(
                          "Localização: ${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}",
                          style: const TextStyle(color: Colors.white70),
                        )
                      else
                        const Text(
                          "Localização não registrada",
                          style: TextStyle(color: Colors.white70),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
