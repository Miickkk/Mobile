import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  // Carrega o valor salvo do modo escuro
  void _carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  // Alterna o modo escuro e salva a preferência
  void _mudarDarkMode(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = valor;
    });
    await prefs.setBool('darkMode', valor);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(title: Text("Teste DarkMode")),
        body: Center(
          child: Switch(
            value: _darkMode,
            onChanged: _mudarDarkMode,
          ),
        ),
      ),
    );
  }
}
