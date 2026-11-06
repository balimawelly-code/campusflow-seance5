// Version minimale. Si tu as déjà ton Task de la séance 3 (campusflow_models),
// copie-le ici à la place et adapte les champs utilisés dans les écrans.
class Task {
  final String id;
  final String titre;
  final String cours;
  final DateTime echeance;
  final bool fait;

  Task({
    required this.id,
    required this.titre,
    required this.cours,
    required this.echeance,
    this.fait = false,
  });

  Task copyWith({String? titre, String? cours, DateTime? echeance, bool? fait}) {
    return Task(
      id: id,
      titre: titre ?? this.titre,
      cours: cours ?? this.cours,
      echeance: echeance ?? this.echeance,
      fait: fait ?? this.fait,
    );
  }

  String get echeanceTexte =>
      '${echeance.day.toString().padLeft(2, '0')}/'
      '${echeance.month.toString().padLeft(2, '0')}/'
      '${echeance.year}';
}
