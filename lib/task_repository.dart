import 'models/task.dart';

abstract class TaskRepository {
  Future<List<Task>> charger();
}

class FakeTaskRepository implements TaskRepository {
  final bool echec;
  const FakeTaskRepository({this.echec = false});

  @override
  Future<List<Task>> charger() async {
    await Future.delayed(const Duration(seconds: 1));

    if (echec) {
      throw Exception('Réseau coupé');
    }

    final donnees = <Map<String, dynamic>>[
      {'titre': 'TP Dart', 'echeance': '2026-11-05T10:00:00'},
      {
        'titre': 'Projet Flutter',
        'echeance': '2026-11-20T23:59:00',
        'description': 'Première maquette'
      },
    ];

    return donnees.map(Task.fromJson).toList();
  }
}