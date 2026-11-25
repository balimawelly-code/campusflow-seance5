import 'package:campusflow_ecrans/models/task.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Task.fromJson lit les champs et toJson les réécrit', () {
    final tache = Task.fromJson({
      'id': 1,
      'titre': 'Rendre le TP',
      'cours': 'Programmation Mobile',
      'echeance': '2026-11-30T23:59:00',
      'fait': false,
    });

    expect(tache.id, '1');
    expect(tache.titre, 'Rendre le TP');
    expect(tache.echeance.day, 30);
    expect(tache.fait, false);
    expect(tache.toJson()['cours'], 'Programmation Mobile');
  });

  test('copyWith ne change que le champ demandé', () {
    final tache = Task(
      id: '1',
      titre: 'Rendre le TP',
      cours: 'Programmation Mobile',
      echeance: DateTime(2026, 11, 30),
    );
    final faite = tache.copyWith(fait: true);

    expect(faite.fait, true);
    expect(faite.titre, tache.titre);
    expect(tache.fait, false); // l'original ne change pas (immuable)
  });
}
