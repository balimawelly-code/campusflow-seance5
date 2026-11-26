import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dio_provider.dart';
import '../data/task_repository.dart';
import '../models/task.dart';

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => ApiTaskRepository(ref.watch(dioProvider)),
);

/// AsyncNotifier : l'état est un AsyncValue (chargement / erreur / données).
class TachesNotifier extends AsyncNotifier<List<Task>> {
  TaskRepository get _repo => ref.read(taskRepositoryProvider);

  @override
  Future<List<Task>> build() => ref.watch(taskRepositoryProvider).lister();

  Future<void> recharger() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repo.lister);
  }

  Future<void> ajouter(Task tache) async {
    final creee = await _repo.creer(tache);
    state = AsyncData([...?state.value, creee]); // nouvelle liste (immuable)
  }

  Future<void> basculer(Task tache) async {
    final maj = await _repo.basculer(tache);
    state = AsyncData([
      for (final t in state.value ?? <Task>[]) t.id == maj.id ? maj : t,
    ]);
  }

  /// Même nom que la séance 6 : les écrans n'ont pas besoin de changer.
  Future<void> marquerFait(String id) async {
    final tache = state.value?.where((t) => t.id == id).firstOrNull;
    if (tache == null || tache.fait) return;
    await basculer(tache);
  }

  Future<void> supprimer(String id) async {
    await _repo.supprimer(id);
    state = AsyncData([
      for (final t in state.value ?? <Task>[])
        if (t.id != id) t,
    ]);
  }
}

final tachesProvider = AsyncNotifierProvider<TachesNotifier, List<Task>>(
  TachesNotifier.new,
);

/// Liste « simple » pour les écrans (vide pendant le chargement ou en erreur).
final listeTachesProvider = Provider<List<Task>>(
  (ref) => ref.watch(tachesProvider).value ?? <Task>[],
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
