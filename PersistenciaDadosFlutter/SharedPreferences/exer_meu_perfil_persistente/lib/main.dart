
import 'package:exer_meu_perfil_persistente/tela_inicial.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: "/",
     routes: {
        "/": (context)=>TelaInicial(),
    },
    theme: ThemeData(brightness: Brightness.light),
    darkTheme: ThemeData(brightness: Brightness.dark),
    
  ));
}