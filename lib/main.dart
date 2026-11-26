import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

void main() => runApp(
  // Pas de nouvel essai automatique : l'écran d'erreur « Réessayer » s'affiche tout de suite.
  ProviderScope(
    retry: (nombreEssais, erreur) => null,
    child: const CampusFlowApp(),
  ),
);

class CampusFlowApp extends ConsumerWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'CampusFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.red, useMaterial3: true),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
