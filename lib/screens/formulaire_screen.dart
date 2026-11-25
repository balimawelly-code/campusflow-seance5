import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/task.dart';
import '../providers/taches_provider.dart';

class FormulaireScreen extends ConsumerStatefulWidget {
  const FormulaireScreen({super.key});

  @override
  ConsumerState<FormulaireScreen> createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends ConsumerState<FormulaireScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titre = TextEditingController();
  final _cours = TextEditingController();
  DateTime _echeance = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() {
    _titre.dispose();
    _cours.dispose();
    super.dispose();
  }

  Future<void> _choisirDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _echeance,
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _echeance = d);
  }

  Future<void> _enregistrer() async {
    if (!_formKey.currentState!.validate()) return;
    final t = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titre: _titre.text.trim(),
      cours: _cours.text.trim(),
      echeance: _echeance,
    );
    try {
      await ref.read(tachesProvider.notifier).ajouter(t);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Tâche enregistrée')));
      context.pop();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enregistrement impossible')),
      );
    }
  }

  String? _requis(String? v, String message) =>
      (v == null || v.trim().isEmpty) ? message : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouvelle tâche')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titre,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _requis(v, 'Titre requis'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cours,
                decoration: const InputDecoration(
                  labelText: 'Cours',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => _requis(v, 'Cours requis'),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.event),
                title: Text(
                  'Échéance : ${_echeance.day.toString().padLeft(2, '0')}/'
                  '${_echeance.month.toString().padLeft(2, '0')}/${_echeance.year}',
                ),
                trailing: TextButton(
                  onPressed: _choisirDate,
                  child: const Text('Changer'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _enregistrer,
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
