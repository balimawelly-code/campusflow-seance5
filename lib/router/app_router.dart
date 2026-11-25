import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/cours_screen.dart';
import '../screens/detail_tache.dart';
import '../screens/echeances_screen.dart';
import '../screens/formulaire_screen.dart';
import '../screens/profil_screen.dart';
import '../screens/shell_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/taches',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Connexion : séance 7'))),
    ),
    // La barre de navigation est dans le ShellRoute.
    ShellRoute(
      builder: (context, state, child) =>
          ShellScreen(emplacement: state.matchedLocation, child: child),
      routes: [
        GoRoute(path: '/taches', builder: (c, s) => const EcheancesScreen()),
        GoRoute(path: '/cours', builder: (c, s) => const CoursScreen()),
        GoRoute(path: '/profil', builder: (c, s) => const ProfilScreen()),
      ],
    ),
    // Écrans plein écran (sans barre de navigation). "nouvelle" avant ":id".
    GoRoute(
      path: '/taches/nouvelle',
      builder: (c, s) => const FormulaireScreen(),
    ),
    GoRoute(
      path: '/taches/:id',
      builder: (c, s) => DetailScreen(tacheId: s.pathParameters['id']!),
    ),
  ],
);
