import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Colunas(Column) e Linhas(Row)")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //vertical
          crossAxisAlignment: CrossAxisAlignment.center, //horizontal
          children: [
            Text("Linha 1"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Coluna 1"),
                Text("Coluna 2")
              ],
            ),
            Text("Linha 3"),
            Stack(
             alignment: Alignment.center, // Centraliza os elementos na pilha
             children: [
               Container(
                 width: 200,
                 height: 200,
                 color: Colors.blue,
               ),
          ],
         ),
        ),
      ),
    );
  }
}
