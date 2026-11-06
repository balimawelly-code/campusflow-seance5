import 'package:flutter/material.dart';
import '../data/taches_demo.dart';
import '../models/task.dart';
import 'detail_tache.dart';
import 'formulaire_screen.dart';

class EcheancesScreen extends StatefulWidget {
  const EcheancesScreen({super.key});

  @override
  State<EcheancesScreen> createState() => _EcheancesScreenState();
}

class _EcheancesScreenState extends State<EcheancesScreen> {
  final List<Task> _taches = List.of(tachesDemo);
  int _onglet = 0;
  String? _selectionId;

  Task? get _selection {
    for (final t in _taches) {
      if (t.id == _selectionId) return t;
    }
    return null;
  }

  void _marquerFait(Task t) {
    setState(() {
      final i = _taches.indexWhere((x) => x.id == t.id);
      _taches[i] = t.copyWith(fait: true);
    });
  }

  Future<void> _ajouter() async {
    final nouvelle = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (_) => const FormulaireScreen()),
    );
    if (nouvelle != null) setState(() => _taches.add(nouvelle));
  }

  void _ouvrir(Task t, bool large) {
    if (large) {
      setState(() => _selectionId = t.id);
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => DetailScreen(tache: t, onFait: _marquerFait),
        ),
      );
    }
  }

  Widget _liste(bool large) {
    return ListView.builder(
      itemCount: _taches.length,
      itemBuilder: (context, i) {
        final t = _taches[i];
        return ListTile(
          leading: Icon(t.fait ? Icons.check_circle : Icons.assignment_outlined),
          title: Text(t.titre, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text('${t.cours} · ${t.echeanceTexte}'),
          selected: large && t.id == _selectionId,
          onTap: () => _ouvrir(t, large),
        );
      },
    );
  }

  Widget _contenuEcheances() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final large = constraints.maxWidth >= 840;
        if (!large) return _liste(false);

        final sel = _selection;
        return Row(
          children: [
            Expanded(flex: 2, child: _liste(true)),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 3,
              child: sel == null
                  ? const Center(child: Text('Sélectionne une tâche'))
                  : DetailTache(tache: sel, onFait: () => _marquerFait(sel)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const titres = ['Cette semaine', 'Cours', 'Profil'];
    return Scaffold(
      appBar: AppBar(title: Text(titres[_onglet])),
      body: _onglet == 0
          ? _contenuEcheances()
          : Center(child: Text('${titres[_onglet]} : prochaine séance')),
      floatingActionButton: _onglet == 0
          ? FloatingActionButton(
              onPressed: _ajouter,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (i) => setState(() => _onglet = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.event), label: 'Échéances'),
          NavigationDestination(icon: Icon(Icons.school), label: 'Cours'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
