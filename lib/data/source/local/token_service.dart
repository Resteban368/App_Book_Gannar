import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  final _storage = const FlutterSecureStorage();
  Future<String?> getToken() async {
    try {
    final token = await _storage.read(key: "token");

    return token;
      
    } catch (e, s) {
      print(" error en el getToken $e ==> $s");
    }
  }

  Future setToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  Future cleanToken() async {
    print("cleanToken");
    await _storage.delete(key: "token");
  }
}
