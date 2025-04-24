import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light, //define como tema claro inicial
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _darkMode = false;

  @override 
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  void _carregarPreferencias() async {
    //carregar as preferencias pelo SharedPreferences
    SharedPreferences prefs = SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs
    })
  }
}

//build
@override
Widget build(BuildContext context) {
  return AnimatedTheme(data: _darkMode ? ThemeData.light(),
  duration: Duration(microseconds: 500),
  child: Scaffold(
    appBar: AppBar(title: Text("Teste DrakMode"),),
    body: Center(
      child: Switch(
        value: _darkMode, 
        onChanged: (value) => mudarDarkMode()),
        ),
  )
  );
}
