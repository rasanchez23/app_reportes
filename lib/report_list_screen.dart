import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_button.dart';
import 'report_card.dart';
import 'create_report_screen.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    final reports = [
      {
        'author': 'Ana García',
        'location': 'Centro de la ciudad',
        'time': 'Hace 2 horas',
        'description': 'Problema con el alumbrado público en la calle principal',
        'image': null,
      },
      {
        'author': 'Carlos Mendoza',
        'location': 'Parque Central',
        'time': 'Hace 4 horas',
        'description': 'Basura acumulada en los contenedores del parque',
        'image': null,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed de Reportes'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              // use the existing CustomButton for the "Agregar" action
              child: CustomButton(
                texto: '+ Agregar',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CreateReportScreen()),
                  );
                },
                colorFondo: const Color.fromARGB(255, 0, 150, 136),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            // Search / filter input using existing CustomInput
            CustomInput(
              text: '',
              label: 'Buscar reportes',
              controller: searchController,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final r = reports[index];
                  return ReportCard(
                    authorName: r['author']!,
                    location: r['location']!,
                    timeAgo: r['time']!,
                    description: r['description']!,
                    imageUrl: r['image'],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
