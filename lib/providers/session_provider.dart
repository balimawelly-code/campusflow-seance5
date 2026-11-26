import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dio_provider.dart';
import '../data/token_storage.dart';

/// État : true = connecté (un jeton est présent), false = déconnecté.
class SessionNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async =>
      (await ref.read(tokenStorageProvider).lire()) != null;

  Future<void> connecter(String email, String motDePasse) async {
    final reponse = await ref
        .read(dioProvider)
        .post('/login', data: {'email': email, 'motDePasse': motDePasse});
    await ref
        .read(tokenStorageProvider)
        .ecrire(reponse.data['jeton'] as String);
    state = const AsyncData(true);
  }

  Future<void> deconnecter() async {
    await ref.read(tokenStorageProvider).effacer();
    state = const AsyncData(false);
  }
}

final sessionProvider = AsyncNotifierProvider<SessionNotifier, bool>(
  SessionNotifier.new,
);
