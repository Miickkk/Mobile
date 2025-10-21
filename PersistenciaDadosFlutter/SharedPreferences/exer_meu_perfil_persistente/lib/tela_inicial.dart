import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();
  String _nome = "";
  String _idade = "";
  bool _darkMode = false;
  bool _salDad = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  // Carregar dados salvos
  _carregarPreferencias() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _nome = _prefs.getString("nome") ?? "";
      _idade = _prefs.getString("idade") ?? "";
      _darkMode = _prefs.getBool("darkMode") ?? false;
      _salDad = _prefs.getBool("salDad") ?? false;
    });
  } // <-- ESTA CHAVE FALTAVA AQUI

  // Trocar tema
  _trocarTema() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = !_darkMode;
      _prefs.setBool("darkMode", _darkMode);
    });
  }

  // Salvar dados
  _salvDad() async {
    _nome = _nomeController.text.trim();
    _idade = _idadeController.text.trim();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_nome.isEmpty || _idade.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos")),
      );
    } else {
      _prefs.setString("nome", _nome);
      _prefs.setString("idade", _idade);
      _prefs.setBool("salDad", true);
      _nomeController.clear();
      _idadeController.clear();
      Navigator.pushReplacementNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bem-vindo ${_nome.isEmpty ? "Visitante" : _nome}"),
          actions: [
            IconButton(
              onPressed: _trocarTema,
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Salvar Dados",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: "Nome"),
              ),
              TextField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: "Senha"),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvDad,
                child: Text("Salvar Dados"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
