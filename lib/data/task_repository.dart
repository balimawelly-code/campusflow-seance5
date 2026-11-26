import 'package:dio/dio.dart';

import '../models/task.dart';

/// Contrat : les écrans ne connaissent que cette interface, jamais Dio.
abstract class TaskRepository {
  Future<List<Task>> lister();
  Future<Task> creer(Task tache);
  Future<Task> basculer(Task tache); // coche / décoche
  Future<void> supprimer(String id);
}

/// Implémentation réelle : appelle l'API avec Dio.
class ApiTaskRepository implements TaskRepository {
  ApiTaskRepository(this._dio);
  final Dio _dio;

  @override
  Future<List<Task>> lister() async {
    final r = await _dio.get<List<dynamic>>('/taches');
    return r.data!
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Task> creer(Task tache) async {
    final r = await _dio.post<Map<String, dynamic>>(
      '/taches',
      data: tache.toJson(),
    );
    return Task.fromJson(r.data!);
  }

  @override
  Future<Task> basculer(Task tache) async {
    final r = await _dio.patch<Map<String, dynamic>>(
      '/taches/${tache.id}',
      data: {'fait': !tache.fait},
    );
    return Task.fromJson(r.data!);
  }

  @override
  Future<void> supprimer(String id) async {
    await _dio.delete('/taches/$id');
  }
}

/// Implémentation en mémoire, pour les tests.
class FakeTaskRepository implements TaskRepository {
  FakeTaskRepository([List<Task>? initiales]) : _taches = [...?initiales];
  final List<Task> _taches;

  Future<void> _attente() => Future.delayed(const Duration(milliseconds: 200));

  @override
  Future<List<Task>> lister() async {
    await _attente();
    return List.of(_taches);
  }

  @override
  Future<Task> creer(Task tache) async {
    await _attente();
    _taches.add(tache);
    return tache;
  }

  @override
  Future<Task> basculer(Task tache) async {
    await _attente();
    final maj = tache.copyWith(fait: !tache.fait);
    final i = _taches.indexWhere((t) => t.id == tache.id);
    if (i >= 0) _taches[i] = maj;
    return maj;
  }

  @override
  Future<void> supprimer(String id) async {
    await _attente();
    _taches.removeWhere((t) => t.id == id);
  }
}
