import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geren_colecoes/controllers/item_controller.dart';
import 'package:geren_colecoes/models/item_model.dart';
import 'package:geren_colecoes/models/colecoes_model.dart'; // importe o modelo Colecao
import 'package:geren_colecoes/view/detalhe_colecoes_screen.dart';

class AdicionarItemScreen extends StatefulWidget {
  final Colecao colecao; // recebe a coleção selecionada

  const AdicionarItemScreen({super.key, required this.colecao});

  @override
  State<StatefulWidget> createState() {
    return _AdicionarItemScreenState();
  }
}

class _AdicionarItemScreenState extends State<AdicionarItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemController = ItemColecaoController();

  late String _nomeItem;
  late String _descricao;
  DateTime _dataAquisicao = DateTime.now();
  late String _valor;
  late String _condicao;

  _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataAquisicao,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataAquisicao) {
      setState(() {
        _dataAquisicao = picked;
      });
    }
  }

  _salvarItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newItem = ItemColecao(
        colecaoId: widget.colecao.id!,
        nome: _nomeItem,
        descricao: _descricao.isEmpty ? "." : _descricao,
        dataAquisicao: _dataAquisicao,
        valor: int.tryParse(_valor) ?? 0,
        condicao: _condicao,
        foto: "",
        detalheEspecifico: "",
      );

      try {
        await _itemController.createItemColecao(newItem);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item criado com sucesso")),
        );

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao adicionar item: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataFormatada = DateFormat("dd/MM/yyyy");
    final Color bgColor = Colors.purple.shade50;
    final Color cardColor = Colors.purple.shade100;
    final Color accentColor = Colors.deepPurple.shade300;
    final Color titleColor = Colors.deepPurple.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Novo Item - Coleção: ${widget.colecao.nome}"),
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
                      Icons.add_box_rounded,
                      color: accentColor,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nome do Item",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Campo obrigatório" : null,
                    onSaved: (newValue) => _nomeItem = newValue!,
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
                    onSaved: (newValue) => _descricao = newValue ?? '',
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: accentColor, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "Data de aquisição: ${dataFormatada.format(_dataAquisicao)}",
                        style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => _selecionarData(context),
                        child: const Text("Selecionar Data"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Valor",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => _valor = newValue ?? "0",
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Condição",
                      labelStyle: TextStyle(color: accentColor),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onSaved: (newValue) => _condicao = newValue ?? '',
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
                      onPressed: _salvarItem,
                      child: const Text("Adicionar Item"),
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