import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Columns and Rows")),
        body: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, //alinhamento eixo principal
            crossAxisAlignment:
                CrossAxisAlignment.center, //alinhamento eixo secundario
            children: [
              Text("Linha 1"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Coluna 1"), Text("Coluna 2")],
              ),
              Text("Linha 3"),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.star) )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
