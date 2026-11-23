class User {
  final String id;
  final String nom;
  final String email;

  const User({required this.id, required this.nom, required this.email});

  User copyWith({String? id, String? nom, String? email}) => User(
        id: id ?? this.id,
        nom: nom ?? this.nom,
        email: email ?? this.email,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        nom: json['nom'] as String,
        email: json['email'] as String,
      );
}