class Task {
  final String titre;
  final DateTime echeance;
  final bool terminee;
  final String? description;

  const Task({
    required this.titre,
    required this.echeance,
    this.terminee = false,
    this.description,
  });

  Task copyWith({
    String? titre,
    DateTime? echeance,
    bool? terminee,
    String? description,
  }) =>
      Task(
        titre: titre ?? this.titre,
        echeance: echeance ?? this.echeance,
        terminee: terminee ?? this.terminee,
        description: description ?? this.description,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        titre: json['titre'] as String,
        echeance: DateTime.parse(json['echeance'] as String),
        terminee: json['terminee'] as bool? ?? false,
        description: json['description'] as String?,
      );

  @override
  String toString() => 'Task($titre, terminee: $terminee)';
}