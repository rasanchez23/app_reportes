import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_button.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    // For now we don't persist the report. Simply pop back to the list.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publicar Reporte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomInput(
              text: 'titulo',
              label: 'Título',
              controller: _titleController,
            ),
            CustomInput(
              text: 'descripcion',
              label: 'Descripción',
              controller: _descController,
            ),
            CustomInput(
              text: 'ubicacion',
              label: 'Ubicación',
              controller: _locationController,
            ),
            const SizedBox(height: 12),
            CustomButton(
              texto: 'Publicar',
              onPressed: _submit,
              colorFondo: const Color.fromARGB(255, 0, 150, 136),
            )
          ],
        ),
      ),
    );
  }
}
