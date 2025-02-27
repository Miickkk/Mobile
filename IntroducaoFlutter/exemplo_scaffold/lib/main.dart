import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Exemplo Scaffold"),
          backgroundColor: const Color.fromARGB(255, 178, 95, 255),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Text("Ínicio"),
            Text("Conteúdo"),
            Text("Contato"),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content:Text("Ação Realizada")),
            );
          },
          child: Text("Aperte Aqui")),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print('Botão pressionado!');
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}