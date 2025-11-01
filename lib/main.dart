import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() {
  runApp(const ReportesApp());
}

class ReportesApp extends StatelessWidget {
  const ReportesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reportes_app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
