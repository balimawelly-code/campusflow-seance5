class Course {
  final String code;
  final String intitule;
  final String enseignant;

  const Course({
    required this.code,
    required this.intitule,
    required this.enseignant,
  });

  Course copyWith({String? code, String? intitule, String? enseignant}) =>
      Course(
        code: code ?? this.code,
        intitule: intitule ?? this.intitule,
        enseignant: enseignant ?? this.enseignant,
      );

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        code: json['code'] as String,
        intitule: json['intitule'] as String,
        enseignant: json['enseignant'] as String,
      );
}