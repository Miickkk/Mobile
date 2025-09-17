//widget de autenticação de usuario =-> direcionar o usuário logado para as telas de navegação

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //direcionamento de telas dinâmico, 
    //direciona o Usuáro de acordo com as informações salvas no cache(snapshot)
    return StreamBuilder<User?>(//o Stream builder vai depender do usuário existir ou não 
      stream: FirebaseAuth.instance.authStateChanges(), //modifica o caminho ao mudar o estado do usuário 
      builder: (context, snapshot){
        //se Snapshot tem dados, significa que o usuário está logado
        if(snapshot.hasData){
          return TarefasView();
        }
        //caso Contrario
        return LoginView();
      });
  }
}