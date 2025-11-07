import 'package:flutter/material.dart';
import 'custom_input.dart';
import 'custom_button.dart';
import 'report_card.dart';
import 'create_report_screen.dart';
import 'models/report.dart';
import 'services/reports_service.dart';

class ReportListScreen extends StatefulWidget {
  const ReportListScreen({super.key});

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  final TextEditingController searchController = TextEditingController();
  final ReportsService _reportsService = ReportsService();
  List<Report> reports = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    try {
      final fetchedReports = await _reportsService.getReports();
      setState(() {
        reports = fetchedReports;
        isLoading = false;
        error = null;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: _loadReports,
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

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
                  final report = reports[index];
                  return ReportCard(
                    authorName: report.author,
                    location: report.location,
                    timeAgo: report.time,
                    description: report.description,
                    imageUrl: report.imageUrl,
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
