import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/session_provider.dart';
import '../screens/cours_screen.dart';
import '../screens/detail_tache.dart';
import '../screens/echeances_screen.dart';
import '../screens/ecran_connexion.dart';
import '../screens/formulaire_screen.dart';
import '../screens/profil_screen.dart';
import '../screens/shell_screen.dart';

/// Le routeur réagit à la session : sans jeton (ou après un 401), on va sur /login.
final routerProvider = Provider<GoRouter>((ref) {
  final rafraichir = ValueNotifier<int>(0);
  ref.listen(sessionProvider, (_, __) => rafraichir.value++);
  ref.onDispose(rafraichir.dispose);

  return GoRouter(
    initialLocation: '/taches',
    refreshListenable: rafraichir,
    redirect: (context, state) {
      final session = ref.read(sessionProvider);
      if (session.isLoading) return null;
      final connecte = session.value ?? false;
      final surLogin = state.matchedLocation == '/login';
      if (!connecte && !surLogin) return '/login';
      if (connecte && surLogin) return '/taches';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (c, s) => const EcranConnexion()),
      ShellRoute(
        builder: (context, state, child) =>
            ShellScreen(emplacement: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: '/taches', builder: (c, s) => const EcheancesScreen()),
          GoRoute(path: '/cours', builder: (c, s) => const CoursScreen()),
          GoRoute(path: '/profil', builder: (c, s) => const ProfilScreen()),
        ],
      ),
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
});
