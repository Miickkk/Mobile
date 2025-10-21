import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // pegar usuário atual
  User? get currentUser => _auth.currentUser;

  // login com email e senha
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception("Erro ao fazer login: $e");
    }
  }

  // registrar usuário
  Future<User?> register(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception("Erro ao registrar usuário: $e");
    }
  }

  // logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
