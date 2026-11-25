import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/task.dart';
import '../providers/taches_provider.dart';
import 'detail_tache.dart';

enum Filtre { aFaire, faites, enRetard }

class EcheancesScreen extends ConsumerStatefulWidget {
  const EcheancesScreen({super.key});

  @override
  ConsumerState<EcheancesScreen> createState() => _EcheancesScreenState();
}

class _EcheancesScreenState extends ConsumerState<EcheancesScreen> {
  Filtre _filtre = Filtre.aFaire;
  String? _selectionId;

  List<Task> _tachesFiltrees() => switch (_filtre) {
    Filtre.aFaire => ref.watch(tachesAFaireProvider),
    Filtre.faites => ref.watch(tachesFaitesProvider),
    Filtre.enRetard => ref.watch(tachesEnRetardProvider),
  };

  Task? _selection() {
    for (final t in ref.watch(listeTachesProvider)) {
      if (t.id == _selectionId) return t;
    }
    return null;
  }

  Widget _filtres() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: SegmentedButton<Filtre>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: Filtre.aFaire, label: Text('À faire')),
            ButtonSegment(value: Filtre.faites, label: Text('Faites')),
            ButtonSegment(value: Filtre.enRetard, label: Text('En retard')),
          ],
          selected: {_filtre},
          onSelectionChanged: (s) => setState(() => _filtre = s.first),
        ),
      ),
    );
  }

  Widget _liste(bool large) {
    final taches = _tachesFiltrees();
    if (taches.isEmpty) {
      return const Center(child: Text('Aucune tâche dans cette catégorie'));
    }
    return ListView.builder(
      itemCount: taches.length,
      itemBuilder: (context, i) {
        final t = taches[i];
        return ListTile(
          leading: Icon(
            t.fait ? Icons.check_circle : Icons.assignment_outlined,
          ),
          title: Text(t.titre, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text('${t.cours} · ${t.echeanceTexte}'),
          selected: large && t.id == _selectionId,
          onTap: () {
            if (large) {
              setState(() => _selectionId = t.id);
            } else {
              context.push('/taches/${t.id}');
            }
          },
        );
      },
    );
  }

  Widget _contenu() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final large = constraints.maxWidth >= 840;
        if (!large) return _liste(false);

        final sel = _selection();
        return Row(
          children: [
            Expanded(flex: 2, child: _liste(true)),
            const VerticalDivider(width: 1),
            Expanded(
              flex: 3,
              child: sel == null
                  ? const Center(child: Text('Sélectionne une tâche'))
                  : DetailTache(
                      tache: sel,
                      onFait: () =>
                          ref.read(tachesProvider.notifier).marquerFait(sel.id),
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _filtres(),
          Expanded(child: _contenu()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/taches/nouvelle'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
