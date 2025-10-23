import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:somativa_rp/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;

  bool _senhaOculta = true;

  void _login() async {
    try {
      await _authController.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green[800],
          content: Text("Falha ao fazer login: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1F0E), 
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.email_outlined, color: Colors.greenAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent.shade400, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _senhaField,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.greenAccent),
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _senhaOculta = !_senhaOculta;
                  }),
                  icon: Icon(
                    _senhaOculta ? Icons.visibility : Icons.visibility_off,
                    color: Colors.greenAccent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green.shade700),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent.shade400, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              obscureText: _senhaOculta,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                "Entrar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterView()),
              ),
              child: const Text(
                "Não tem uma conta? Registre-se",
                style: TextStyle(color: Colors.greenAccent, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
