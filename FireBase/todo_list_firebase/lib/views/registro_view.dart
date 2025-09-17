import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _senhaField = TextEditingController();
  final TextEditingController _confirmarSenhaField = TextEditingController();
  bool _ocultarSenha = true;
  bool _ocultarConfSenha = true;
  bool _senhaIguais = false;

  void _registrar() async{
    if (_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailField.text.trim(), 
        password: _senhaField.text);
      Navigator.pop(context); //retorna para tela de Login ( Levando info do Usuário)
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao Criar usuário $e"))
      );
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro"),),
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
                      _ocultarSenha = !_ocultarSenha;
                    });
                  } , 
                  icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off))
              ),
              obscureText: _ocultarSenha, //ocultar os caracters da senha
              //icone de olho para ver a senha (opcional)              
            ),
            TextField(
              controller: _confirmarSenhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      _ocultarConfSenha = !_ocultarConfSenha;
                    });
                  } , 
                  icon: Icon(_ocultarConfSenha ? Icons.visibility : Icons.visibility_off)),
              ),
              obscureText: _ocultarConfSenha, //ocultar os caracters da ConfSenha
              //icone de olho para ver a senha (opcional)              
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _registrar, child: Text("Registrar"))
          ],
        ),),
    );
  }
}