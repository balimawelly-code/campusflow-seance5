import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/taches_demo.dart';
import '../models/task.dart';

/// État partagé des tâches. L'état est immuable : on assigne une NOUVELLE liste.
class TachesNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() => List.of(tachesDemo);

  Future<void> ajouter(Task tache) async {
    state = [...state, tache];
  }

  Future<void> marquerFait(String id) async {
    state = [for (final t in state) t.id == id ? t.copyWith(fait: true) : t];
  }
}

final tachesProvider = NotifierProvider<TachesNotifier, List<Task>>(
  TachesNotifier.new,
);

/// Les écrans lisent la liste par ce provider (il change à la séance 7).
final listeTachesProvider = Provider<List<Task>>(
  (ref) => ref.watch(tachesProvider),
);

// Filtres dérivés
final tachesAFaireProvider = Provider<List<Task>>(
  (ref) => ref.watch(listeTachesProvider).where((t) => !t.fait).toList(),
);

final tachesFaitesProvider = Provider<List<Task>>(
  (ref) => ref.watch(listeTachesProvider).where((t) => t.fait).toList(),
);

final tachesEnRetardProvider = Provider<List<Task>>(
  (ref) => ref
      .watch(listeTachesProvider)
      .where((t) => !t.fait && t.echeance.isBefore(DateTime.now()))
      .toList(),
);
