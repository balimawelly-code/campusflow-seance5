import 'package:campusflow_models/campusflow_models.dart';

Future<void> main() async {
  final depot = FakeTaskRepository();
  try {
    final taches = await depot.charger();
    print('${taches.length} tâche(s) : $taches');
  } catch (e) {
    print('Erreur : $e');
  } finally {
    print('Fin du chargement');
  }
}