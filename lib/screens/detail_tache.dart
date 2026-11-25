import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/task.dart';
import '../providers/taches_provider.dart';

/// Contenu du détail : réutilisé en plein écran (téléphone)
/// et dans le panneau de droite (tablette).
class DetailTache extends StatelessWidget {
  final Task tache;
  final VoidCallback onFait;

  const DetailTache({super.key, required this.tache, required this.onFait});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tache.titre,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text('Cours : ${tache.cours}'),
                  Text('Échéance : ${tache.echeanceTexte}'),
                  Text('Statut : ${tache.fait ? 'Terminée' : 'À faire'}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: tache.fait ? null : onFait,
            child: const Text('Marquer comme fait'),
          ),
        ],
      ),
    );
  }
}

/// Écran Détail (téléphone) : ouvert par l'adresse /taches/:id.
class DetailScreen extends ConsumerWidget {
  final String tacheId;

  const DetailScreen({super.key, required this.tacheId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taches = ref.watch(listeTachesProvider);
    final tache = taches.where((t) => t.id == tacheId).firstOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: tache == null
          ? const Center(child: Text('Tâche introuvable'))
          : DetailTache(
              tache: tache,
              onFait: () async {
                await ref.read(tachesProvider.notifier).marquerFait(tache.id);
                if (context.mounted) context.pop();
              },
            ),
    );
  }
}
