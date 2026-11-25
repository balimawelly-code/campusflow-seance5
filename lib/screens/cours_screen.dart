import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/taches_provider.dart';

/// Liste des cours, déduite des tâches, avec le nombre de tâches par cours.
class CoursScreen extends ConsumerWidget {
  const CoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taches = ref.watch(listeTachesProvider);
    final parCours = <String, int>{};
    for (final t in taches) {
      parCours[t.cours] = (parCours[t.cours] ?? 0) + 1;
    }
    if (parCours.isEmpty) {
      return const Center(child: Text('Aucun cours pour le moment'));
    }
    return ListView(
      children: [
        for (final e in parCours.entries)
          ListTile(
            leading: const Icon(Icons.school),
            title: Text(e.key),
            trailing: Text('${e.value} tâche(s)'),
          ),
      ],
    );
  }
}
