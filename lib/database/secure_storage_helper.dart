import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  SecureStorageHelper._();

  static const _storage = FlutterSecureStorage();
  static const _accessTokenKey = "access_token";

  static Future<void> setAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  static Future<void> removeAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }
}
