import 'package:flutter/material.dart';

import 'view/tela_infografico_view.dart';
import 'view/tela_inicial_view.dart';
import 'view/tela_tarefas_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => TelaInicial(),
        "/tarefas": (context) => TelaTarefas(),
        "/infografico": (context) => TelaInfografico(),
      },
    ),
  );
}
