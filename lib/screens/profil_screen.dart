import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_provider.dart';
import '../providers/taches_provider.dart';

class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 16),
          const Text('Aïcha Ouédraogo', style: TextStyle(fontSize: 20)),
          const Text('aicha@campusflow.bf'),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: () async {
              await ref.read(sessionProvider.notifier).deconnecter();
              ref.invalidate(tachesProvider);
            },
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}
