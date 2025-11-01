import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_button.dart';
import 'report_list_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nombreController = TextEditingController();
  final _apellidoPController = TextEditingController();
  final _apellidoMController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoPController.dispose();
    _apellidoMController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí iría la lógica de registro
      // Tras un registro simulado, navegamos a la pantalla de reportes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ReportListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomInput(
                text: 'nombre',
                label: 'Nombre',
                controller: _nombreController,
              ),
              CustomInput(
                text: 'apellidoP',
                label: 'Apellido Paterno',
                controller: _apellidoPController,
              ),
              CustomInput(
                text: 'apellidoM',
                label: 'Apellido Materno',
                controller: _apellidoMController,
              ),
              CustomInput(
                text: 'correo',
                label: 'Correo',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomInput(
                text: 'telefono',
                label: 'Telefono',
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
              ),
              CustomInput(
                text: 'password',
                label: 'Contraseña',
                controller: _passwordController,
                isPassword: true,
              ),
              CustomInput(
                text: 'confirm',
                label: 'Confirmar Contraseña',
                controller: _confirmController,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              CustomButton(
                texto: 'Registrar',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
