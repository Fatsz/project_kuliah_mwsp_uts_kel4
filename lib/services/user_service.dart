import 'dart:convert';

import 'package:http/http.dart' as http;

class UserService {
  // Gunakan 10.0.2.2 untuk Android emulator (localhost di komputer host)
  // Untuk perangkat fisik, ganti dengan IP address komputer (misal: http://192.168.1.5:4000/users)
  // Untuk iOS simulator, gunakan http://localhost:4000/users
  static const String _baseUrl = 'http://192.168.1.101:4000/users';

  /// Fetch all users from the Express backend.
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data pengguna: ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is List<dynamic>) {
      return decoded;
    }

    throw Exception('Format respons tidak sesuai');
  }

  /// Create a new user via POST.
  Future<void> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal membuat pengguna: ${response.statusCode}');
    }
  }

  /// Login user via POST.
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Login gagal: ${response.statusCode}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
