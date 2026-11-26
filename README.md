# CampusFlow

Application mobile de suivi des cours, échéances et tâches d'un étudiant, construite pas à pas sur 7 séances (Programmation Mobile, Master 1, Université Aube Nouvelle).

## Structure du dépôt

```
campusflow_ecrans/
├── lib/                  application Flutter (écrans, état Riverpod, routes GoRouter, couche API Dio)
├── campusflow_models/    package Dart de la séance 3 (Task, Course, User, fromJson, tests)
├── server/               API simulée avec json-server (séance 7)
├── docs/                 documents de conception (séances 1, 2 et 7)
└── test/                 tests de l'application
```

## Lancer le projet

1. Lancer l'API (Node.js requis) :
   ```bash
   cd server
   npm install
   npm start
   ```
2. Dans un autre terminal, à la racine du dépôt :
   ```bash
   flutter pub get
   flutter run -d chrome
   ```
3. Se connecter avec le compte de démonstration : `aicha@campusflow.bf` / `campus2026`.

Sur l'émulateur Android, l'API est atteinte par `10.0.2.2:3000` (déjà géré dans le code).

## Avancement par séance

| Séance | Contenu |
|---|---|
| 1 | Fiche Android/iOS, autopsie Windows Phone, décision de plateforme (`docs/seance1`) |
| 2 | Persona, parcours, wireframes, design system v1 (`docs/seance2`) |
| 3 | Package `campusflow_models` avec tests |
| 4 | Projet Flutter, thème centralisé |
| 5 | Écrans Échéances, Détail, Formulaire, version tablette (840 dp) |
| 6 | Navigation GoRouter (ShellRoute), état partagé Riverpod, filtres |
| 7 | API json-server, couches Repository, CRUD asynchrone, connexion avec jeton sécurisé (`docs/seance7`) |