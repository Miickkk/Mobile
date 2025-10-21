//flutter create --plaforms=android --empty 
//ola_mundo_dependecias

import 'package:flutter/material.dart';

void main(){ // método necessário para rodar a aplicação
  MyApp();
}

class MyApp extends StatelessWidget {
  get Fluttertoast => null;
 //classe inicial 
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // material app - material basse de desenvolvimento
      home: Scaffold( //página inicial usando uma tela padrão
        appBar: AppBar( 
          title: Text("App Olá Mundo!!!"),
        ),
        body: Center( 
          child: ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Olá, Mundo!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }, 
            child: Text("Mostrar Mensagem")),
        ),
      ),
    );
  }
  
}

class Toast {
  static get LENGTH_SHORT => null;
}

class ToastGravity {
  static get CENTER => null;
}
