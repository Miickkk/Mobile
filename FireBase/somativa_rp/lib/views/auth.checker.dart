
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:somativa_rp/views/login_view.dart';
import 'package:somativa_rp/views/home_view.dart';
import 'package:somativa_rp/views/home_view.dart';
import 'package:somativa_rp/views/login_view.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.greenAccent,
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const HomeView();
        }

        return const LoginView();
      },
    );
  }
}
