import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // 10.0.2.2 is "localhost" from inside the Android emulator
  // If using a real device on the same Wi-Fi, use your PC's local IP instead (e.g. 192.168.x.y)
  // If testing on web or iOS simulator, use http://127.0.0.1:8000/api
  final String _baseUrl = 'http://10.0.2.2:8000/api';
  final _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/auth/login/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('LOGIN status: ${response.statusCode}');
      debugPrint('LOGIN body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(key: 'access', value: data['access']);
        await _storage.write(key: 'refresh', value: data['refresh']);
        return {'success': true};
      }

      // Return server error message so UI can display it
      final errorData = jsonDecode(response.body);
      final message = errorData['detail'] ?? 'Identifiants incorrects.';
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('LOGIN exception: $e');
      return {
        'success': false,
        'message': 'Impossible de joindre le serveur. Vérifiez votre connexion.',
      };
    }
  }

  Future<Map<String, dynamic>> register(
      String username, String password, String email, String phone) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/auth/register/'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'username': username,
              'password': password,
              'email': email,
              'phone': phone,
            }),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('REGISTER status: ${response.statusCode}');
      debugPrint('REGISTER body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _storage.write(key: 'access', value: data['access']);
        await _storage.write(key: 'refresh', value: data['refresh']);
        return {'success': true};
      }

      // Parse and return server validation errors
      final errorData = jsonDecode(response.body);
      String message = 'Erreur lors de la création du compte.';
      if (errorData is Map) {
        final messages = errorData.values
            .expand((v) => v is List ? v : [v])
            .map((v) => v.toString())
            .toList();
        if (messages.isNotEmpty) message = messages.join('\n');
      }
      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint('REGISTER exception: $e');
      return {
        'success': false,
        'message': 'Impossible de joindre le serveur. Vérifiez votre connexion.',
      };
    }
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access');
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  /// Get the auth header for authenticated requests
  Future<Map<String, String>> get authHeaders async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
