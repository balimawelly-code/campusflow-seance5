import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Coque de l'application : AppBar + barre de navigation autour de l'écran courant.
class ShellScreen extends StatelessWidget {
  final String emplacement;
  final Widget child;

  const ShellScreen({
    super.key,
    required this.emplacement,
    required this.child,
  });

  static const _adresses = ['/taches', '/cours', '/profil'];
  static const _titres = ['Cette semaine', 'Cours', 'Profil'];

  int get _index {
    final i = _adresses.indexWhere((a) => emplacement.startsWith(a));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titres[_index])),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => context.go(_adresses[i]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.event), label: 'Échéances'),
          NavigationDestination(icon: Icon(Icons.school), label: 'Cours'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
