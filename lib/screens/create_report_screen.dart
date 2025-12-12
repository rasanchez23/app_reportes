import 'package:flutter/material.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../services/api_service.dart';

class CreateReportScreen extends StatefulWidget {
  final String? username;
  const CreateReportScreen({Key? key, this.username}) : super(key: key);

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleCreateReport() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final result = await ApiService.createReport(
        title: _titleController.text,
        description: _descriptionController.text,
        author: widget.username ?? 'Usuario',
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reporte creado exitosamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear reporte'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Razón del reporte',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Título',
                  hintText: 'Ingresa el título del reporte',
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El título es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Descripción',
                  hintText: 'Describe el problema',
                  controller: _descriptionController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La descripción es requerida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomInput(
                  label: 'Contenido adicional',
                  hintText: 'Información adicional',
                  controller: _contentController,
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Imágenes',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[50],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Toca para añadir imágenes',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CustomButton(
                  label: 'PUBLICAR',
                  onPressed: _handleCreateReport,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
