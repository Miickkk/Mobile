import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegisterView> {
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
      Navigator.pop(context); 
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
              obscureText: _ocultarSenha, 
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
              obscureText: _ocultarConfSenha, 
                       
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _registrar, child: Text("Registrar"))
          ],
        ),),
    );
  }
}