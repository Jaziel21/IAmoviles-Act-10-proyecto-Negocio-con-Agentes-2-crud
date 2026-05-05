import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth_page.dart';
import 'package:myapp/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si el estado de la conexión está esperando, muestra un indicador de carga
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        // Si hay un usuario (snapshot tiene datos), muestra la página principal
        if (snapshot.hasData) {
          return const HomePage();
        }
        
        // Si no hay usuario, muestra la página de autenticación
        return const AuthPage();
      },
    );
  }
}
