import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/colecoes_controller.dart';
import 'package:geren_colecoes/models/colecoes_model.dart';

class CadastroColecaoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastroColecaoScreenState();
}

class _CadastroColecaoScreenState extends State<CadastroColecaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerColecao = ColecoesController();

  late String _nome;
  late String _descricao;
  late String _tipo = 'Selos'; // Valor padrão

  final List<String> _tipos = ['Selos', 'Moedas', 'HQs', 'Outros'];

  _salvarColecao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newColecao = Colecao(
        nome: _nome,
        descricao: _descricao,
        tipoItem: _tipo,
      );

      await _controllerColecao.createColecao(newColecao);
      Navigator.pop(context, true);
    }
  }

  IconData _iconePorTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'hqs':
      case 'hq':
        return Icons.menu_book_rounded;
      case 'moedas':
      case 'moeda':
        return Icons.monetization_on_rounded;
      case 'selos':
      case 'selo':
        return Icons.local_post_office_rounded;
      case 'outros':
        return Icons.star_border_rounded;
      default:
        return Icons.collections_bookmark_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.purple.shade50;
    final Color cardColor = Colors.purple.shade100;
    final Color accentColor = Colors.deepPurple.shade300;
    final Color titleColor = Colors.deepPurple.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Nova Coleção"),
        backgroundColor: accentColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Icon(
                      _iconePorTipo(_tipo),
                      color: accentColor,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome da Coleção",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (value) => _nome = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onSaved: (value) => _descricao = value ?? '',
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Tipo",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    value: _tipo,
                    items: _tipos
                        .map(
                          (tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Row(
                              children: [
                                Icon(_iconePorTipo(tipo), color: accentColor),
                                const SizedBox(width: 8),
                                Text(tipo, style: TextStyle(color: accentColor)),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) =>
                        value == null || value.isEmpty ? "Campo obrigatório" : null,
                    onChanged: (value) => setState(() => _tipo = value!),
                    onSaved: (value) => _tipo = value!,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _salvarColecao,
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}