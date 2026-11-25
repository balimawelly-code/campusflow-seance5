import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 16),
          Text('Aïcha Ouédraogo', style: TextStyle(fontSize: 20)),
          Text('aicha@campusflow.bf'),
        ],
      ),
    );
  }
}
