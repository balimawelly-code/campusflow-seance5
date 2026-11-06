import 'package:flutter/material.dart';
import '../models/task.dart';

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
                  Text(tache.titre, style: Theme.of(context).textTheme.titleLarge),
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

/// Écran Détail (téléphone).
class DetailScreen extends StatelessWidget {
  final Task tache;
  final void Function(Task) onFait;

  const DetailScreen({super.key, required this.tache, required this.onFait});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail')),
      body: DetailTache(
        tache: tache,
        onFait: () {
          onFait(tache);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
