import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //atributos
  final FirebaseAuth _auth = FirebaseAuth.instance; // controlar a autenticação do usuário no Firebase
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _senhaField = TextEditingController();
  bool _invisivel = true;

  //método de login
  void _login() async{
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      //AuthWidget -> vai Direcionar para a Tela interna automaticamente
    } on FirebaseAuthException catch (e) {// tartar erro mais específico
      //tratar erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao Fazer Login $e"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _invisivel = !_invisivel;
                    });
                  } , 
                  icon: Icon(_invisivel ? Icons.visibility : Icons.visibility_off))
              ),
              obscureText: _invisivel, //ocultar os caracters da senha
              //icone de olho para ver a senha (opcional)              
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _login, child: Text("Login")),
            TextButton(onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=> RegistroView()));
            }, child: Text("Não tem uma Conta? Registre-se"))
          ],
        ),),
    );
  }
}