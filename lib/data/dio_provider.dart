import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/session_provider.dart';
import 'token_storage.dart';

/// Sur l'émulateur Android, "localhost" désigne l'émulateur : on utilise 10.0.2.2.
String adresseApi() {
  if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3000';
  return 'http://localhost:3000';
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: adresseApi(),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      // Ajoute le jeton à chaque requête.
      onRequest: (options, handler) async {
        final jeton = await ref.read(tokenStorageProvider).lire();
        if (jeton != null) options.headers['Authorization'] = 'Bearer $jeton';
        handler.next(options);
      },
      // 401 : le jeton est refusé -> on se déconnecte (le routeur renvoie vers /login).
      onError: (erreur, handler) async {
        final estLogin = erreur.requestOptions.path == '/login';
        if (erreur.response?.statusCode == 401 && !estLogin) {
          await ref.read(sessionProvider.notifier).deconnecter();
        }
        handler.next(erreur);
      },
    ),
  );
  return dio;
});
