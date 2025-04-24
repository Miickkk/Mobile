import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: UserNamePage()));
}

//Classe da Página

class UserNamePage extends StatefulWidget {
  @override
  _UserNamePageState createState() => _UserNamePageState();
}


class _UserNamePageState extends State<UserNamePage> {
  TextEditingController _controller = TextEditingController();
  String _nomeSalvo = "";


  @override
  void initState() {
    super.initState();
    _carregarNomeSalvo();
  }


  void _carregarNomeSalvo() async {
    // usar o SharedPreferences para carrear as informações salvas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeSalvo = prefs.getString("nome") ?? "";
    });
  }


  void _salvarNome() async {
    //usar o sharedPreferences para salvar informações
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nome", _controller.text);
    _carregarNomeSalvo(); //setState para atualizar a tela
    _controller.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 173, 255),
        title: Text(
          "Bem-Vindo ${_nomeSalvo == "" ? "Visitante" : _nomeSalvo}",
          style: TextStyle(
            fontSize: 24,
            color: const Color.fromARGB(255, 130, 60, 209),
          ),
        ),
      ),

      
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Digite seu nome"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _salvarNome, child: Text("Salvar")),
          ],
        ),
      ),
    );
  }
}
