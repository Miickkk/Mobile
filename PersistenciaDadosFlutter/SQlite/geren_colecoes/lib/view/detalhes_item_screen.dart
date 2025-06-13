import 'package:flutter/material.dart';
import 'package:geren_colecoes/models/item_model.dart';
import 'package:intl/intl.dart';
import '../models/colecoes_model.dart'; // ajuste o caminho conforme seu projeto

class DetalhesItemScreen extends StatelessWidget {
  final ItemColecao item;

  const DetalhesItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.purple.shade50;
    final Color cardColor = Colors.purple.shade100;
    final Color accentColor = Colors.deepPurple.shade300;
    final Color titleColor = Colors.deepPurple.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(item.nome),
        backgroundColor: accentColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                if (item.foto != null && item.foto!.isNotEmpty)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.foto!,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 100, color: accentColor);
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                _buildInfo("Nome", item.nome, accentColor, titleColor),
                _buildInfo("Descrição", item.descricao, accentColor, titleColor),
                _buildInfo("Data de Aquisição", item.dataFormatada, accentColor, titleColor),
                _buildInfo("Valor", "R\$ ${item.valor}", accentColor, titleColor),
                _buildInfo("Condição", item.condicao, accentColor, titleColor),
                _buildInfo("Detalhe Específico", item.detalheEspecifico, accentColor, titleColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(String titulo, String conteudo, Color accentColor, Color titleColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.label_important, color: accentColor, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    conteudo,
                    style: TextStyle(fontSize: 15, color: accentColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}