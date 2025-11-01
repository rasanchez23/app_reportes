import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'login.dart';
import 'sign_up.dart';
import 'report_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Moved welcome text here, slightly above the login button
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(
                texto: 'Iniciar Sesión',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                texto: 'Registro',
                colorFondo: const Color.fromARGB(255, 163, 163, 163),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
              ),
              const SizedBox(height: 12),
              CustomButton(
                texto: 'Ver reportes',
                colorFondo: const Color.fromARGB(255, 33, 150, 243),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReportListScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
