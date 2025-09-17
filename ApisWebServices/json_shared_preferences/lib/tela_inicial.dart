import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_shared_preferences/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  final bool temaEscuro;
  final String nomeUsuario;

  // construtor
  TelaInicial({required this.temaEscuro, required this.nomeUsuario});

  @override
  State<StatefulWidget> createState() {
    return _TelaInicialState();
  }
}

class _TelaInicialState extends State<TelaInicial> {
  late bool _temaEscuro;
  late TextEditingController
  _nomeController; // manipulação de texto dentro de TextFields

  @override
  void initState() {
    super.initState();
    _temaEscuro = widget.temaEscuro; // acessando o valor do widgetful
    _nomeController = TextEditingController(text: widget.nomeUsuario);
  }

  // métodos para modificação das configurações
  void _salvarConfiguracoes() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> config = {
      "temaEscuro": _temaEscuro,
      "nome": _nomeController.text.trim(),
    };
    String jsonString = json.encode(config);
    prefs.setString("config", jsonString);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Configurações Salvas com Sucesso!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preferências do Usuário")),
      body: Padding(
        padding: EdgeInsets.all(16.0), 
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: _temaEscuro, 
              onChanged: (bool value){
                setState(() {
                  _temaEscuro = value;
                });
              }),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome do Usuário"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: ()async{
                _salvarConfiguracoes();
                // reiniciar o app para aplciar o tema
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ConfigPage()));

              },
              child: Text("Salvar Preferencias"),),
            SizedBox(height: 20,),
            Divider(),
            Text("Configurações Atuais:", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 16,),
            Text("Tema: ${_temaEscuro ? "Escuro" : "Claro"}"),
            Text("Nome do Usuário: ${_nomeController.text}")
          ],
        )),
    );
  }
}
