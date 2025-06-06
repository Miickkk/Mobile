import 'package:flutter/material.dart';
import 'package:geren_colecoes/controllers/item_controller.dart';
import 'package:geren_colecoes/models/colecao_model.dart';
import 'package:geren_colecoes/view/home_screen.dart';

class CadastroColecaoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CadastroColecaoScreenState();
}

class _CadastroColecaoScreenState extends State<CadastroColecaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerColecao = ColecaoController();

  late String _titulo;
  late String _categoria;
  late String _descricao;
  late String _proprietario;
  late String _valorEstimado;
  late String _localArmazenado;
  bool _itemRaro = false;

  _salvarColecao() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final novaColecao = Colecao(
        titulo: _titulo,
        categoria: _categoria,
        descricao: _descricao,
        proprietario: _proprietario,
        valorEstimado: _valorEstimado,
        itemRaro: _itemRaro,
        localArmazenado: _localArmazenado,
      );

      await _controllerColecao.createColecao(novaColecao);

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nova Coleção")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Título da Coleção"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _titulo = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Categoria"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _categoria = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Descrição"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _descricao = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Proprietário"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _proprietario = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Valor Estimado"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _valorEstimado = value!,
              ),

              TextFormField(
                decoration: InputDecoration(labelText: "Local de Armazenamento"),
                validator: (value) => value!.isEmpty ? "Campo obrigatório!" : null,
                onSaved: (value) => _localArmazenado = value!,
              ),

              SwitchListTile(
                title: Text("Item Raro?"),
                value: _itemRaro,
                onChanged: (value) {
                  setState(() {
                    _itemRaro = value;
                  });
                },
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarColecao,
                child: Text("Cadastrar Coleção"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
