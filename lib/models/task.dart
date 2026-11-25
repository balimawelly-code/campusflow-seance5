// Modèle Task de l'application (avec JSON pour la séance 7).
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

  Task copyWith({
    String? titre,
    String? cours,
    DateTime? echeance,
    bool? fait,
  }) {
    return Task(
      id: id,
      titre: titre ?? this.titre,
      cours: cours ?? this.cours,
      echeance: echeance ?? this.echeance,
      fait: fait ?? this.fait,
    );
  }

  /// Construit une tâche à partir du JSON renvoyé par l'API.
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'].toString(),
    titre: json['titre'] as String,
    cours: json['cours'] as String,
    echeance: DateTime.parse(json['echeance'] as String),
    fait: json['fait'] as bool? ?? false,
  );

  /// Transforme la tâche en JSON pour l'envoyer à l'API.
  Map<String, dynamic> toJson() => {
    'id': id,
    'titre': titre,
    'cours': cours,
    'echeance': echeance.toIso8601String(),
    'fait': fait,
  };

  String get echeanceTexte =>
      '${echeance.day.toString().padLeft(2, '0')}/'
      '${echeance.month.toString().padLeft(2, '0')}/'
      '${echeance.year}';
}
