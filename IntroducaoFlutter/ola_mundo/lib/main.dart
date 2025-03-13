// Importa o pacote Flutter, que contém os widgets e ferramentas necessárias para criar o aplicativo.
import 'package:flutter/material.dart';

// A função principal do programa, que é o ponto de entrada da aplicação.
void main() {
  runApp(MyApp()); // Executa o aplicativo, iniciando o widget raiz "MyApp".
}

// Define o widget principal da aplicação.
class MyApp extends StatelessWidget {
  // Construtor do widget MyApp.
  @override
  Widget build(BuildContext context) {
    // Retorna o MaterialApp, que é a base para aplicativos com estilo Material Design.
    return MaterialApp(
      home: Scaffold( // Scaffold fornece uma estrutura básica para uma tela, com barra de app, corpo e outros elementos.
        appBar: AppBar( // Define a barra superior (AppBar) com o título do aplicativo.
          title: Text('Hello World App'), // Título exibido na AppBar.
        ),
        body: Center( // Centraliza os widgets filhos na tela.
          child: Text(
            'Olá, Mundo!', // Exibe o texto "Olá, Mundo!" no centro da tela.
          ),
        ),
      ),
    );
  }
}
