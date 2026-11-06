import 'package:flutter/material.dart';
import 'screens/echeances_screen.dart';

void main() => runApp(const CampusFlowApp());

class CampusFlowApp extends StatelessWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      home: const EcheancesScreen(),
    );
  }
}
