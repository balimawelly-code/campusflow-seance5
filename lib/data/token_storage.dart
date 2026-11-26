import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Le jeton est rangé dans le stockage sécurisé, jamais en clair.
class TokenStorage {
  static const _cle = 'jeton';
  final _stockage = const FlutterSecureStorage();

  Future<String?> lire() => _stockage.read(key: _cle);
  Future<void> ecrire(String jeton) => _stockage.write(key: _cle, value: jeton);
  Future<void> effacer() => _stockage.delete(key: _cle);
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
