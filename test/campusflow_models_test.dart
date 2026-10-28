import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  test('copyWith modifie un champ et garde les autres', () {
    final t = Task(titre: 'TP Dart', echeance: DateTime(2026, 11, 5));
    final fini = t.copyWith(terminee: true);

    expect(fini.terminee, isTrue);
    expect(fini.titre, 'TP Dart');
    expect(t.terminee, isFalse); // l'original n'a pas changé
  });

  test('fromJson construit une Task correcte', () {
    final t = Task.fromJson({
      'titre': 'Projet',
      'echeance': '2026-11-20T23:59:00',
    });

    expect(t.titre, 'Projet');
    expect(t.echeance.year, 2026);
    expect(t.terminee, isFalse);
    expect(t.description, isNull);
  });

  test('le dépôt en échec lève une exception', () {
    const depot = FakeTaskRepository(echec: true);
    expect(depot.charger(), throwsException);
  });
}