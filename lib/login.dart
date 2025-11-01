import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_button.dart';
import 'report_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí iría la lógica de autenticación
      // Tras un login exitoso, navegamos a la pantalla de reportes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ReportListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email
              CustomInput(
                text: 'correo',
                label: 'Correo',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              // Password
              CustomInput(
                text: 'contraseña',
                label: 'Contraseña',
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 8),
              Builder(builder: (context) {
                // simple field-level validation when submitting
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 16),
              CustomButton(
                texto: 'Entrar',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
