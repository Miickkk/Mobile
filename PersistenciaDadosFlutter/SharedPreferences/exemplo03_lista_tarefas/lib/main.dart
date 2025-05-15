import 'package:exemplo03_lista_tarefas/tela_cadastro.dart';
import 'package:exemplo03_lista_tarefas/tela_inicial.dart';
import 'package:exemplo03_lista_tarefas/tela_tarefas.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
        "/": (context)=>TelaInicial(),
        "/cadastro": (context)=>TelaCadastro(),
        "/tarefas": (context)=>TelaTarefas()
    },
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark),
    
    
  ));
}