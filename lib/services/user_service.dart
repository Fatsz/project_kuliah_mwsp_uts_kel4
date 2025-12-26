import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:project_kuliah_mwsp_uts_kel4/api/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // Singleton instance to share state/streams across app
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // Real-time username stream
  final StreamController<String> _usernameController =
      StreamController<String>.broadcast();
  Stream<String> get usernameStream => _usernameController.stream;
  void _emitUsername(String username) {
    _usernameController.add(username);
  }

  /// Simpan data user ke SharedPreferences
  Future<void> saveUserData({
    required String username,
    required String email,
    String? userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    if (userId != null) {
      await prefs.setString('userId', userId);
    }
    // Emit real-time update
    _emitUsername(username);
  }

  /// Ambil user ID dari SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  /// Ambil username dari SharedPreferences
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  /// Ambil email dari SharedPreferences
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  /// Hapus data user (untuk logout)
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
  }

  /// Fetch all users from the Express backend.
  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse(ApiUrl.base));

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
      Uri.parse('${ApiUrl.users}/register'),
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
      Uri.parse('${ApiUrl.users}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Login gagal: ${response.statusCode}');
    }

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    print('=== LOGIN RESPONSE DEBUG ===');
    print('Response: $responseData');

    // Save user data to SharedPreferences after successful login
    if (responseData['data'] != null) {
      // Backend mengembalikan data dalam field 'data'
      final user = responseData['data'];
      final userId =
          user['id_users']?.toString() ??
          user['id']?.toString() ??
          user['id_user']?.toString() ??
          '';
      print('Saving userId: $userId');
      print('Saving username: ${user['username']}');
      print('Saving email: ${user['email']}');

      await saveUserData(
        username: user['username'] ?? '',
        email: user['email'] ?? '',
        userId: userId,
      );
      _emitUsername(user['username'] ?? '');
    } else if (responseData['user'] != null) {
      // Fallback jika struktur berbeda
      final user = responseData['user'];
      final userId =
          user['id_users']?.toString() ??
          user['id']?.toString() ??
          user['id_user']?.toString() ??
          '';
      print('Saving userId from user: $userId');

      await saveUserData(
        username: user['username'] ?? '',
        email: user['email'] ?? '',
        userId: userId,
      );
      _emitUsername(user['username'] ?? '');
    }

    return responseData;
  }

  /// Update user profile via PATCH.
  Future<void> updateUser({
    required String userId,
    required String username,
    required String email,
    String? password,
  }) async {
    print('=== UPDATE USER DEBUG ===');

    // Parse userId to integer for backend
    final userIdInt = int.tryParse(userId);
    if (userIdInt == null) {
      throw Exception('Invalid userId: $userId');
    }

    print('Sending PATCH to: ${ApiUrl.users}/$userIdInt');
    print('Username: $username');
    print('Email: $email');
    print('Password: ${password != null ? 'PROVIDED' : 'NOT PROVIDED'}');

    final Map<String, dynamic> requestData = {
      'id_users': userIdInt,
      'username': username,
      'email': email,
    };

    // Add password hanya jika disediakan
    if (password != null && password.isNotEmpty) {
      requestData['password'] = password;
    }

    final requestBody = jsonEncode(requestData);
    print('Request body: $requestBody');

    try {
      final response = await http.patch(
        Uri.parse('${ApiUrl.users}/$userIdInt'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        final errorMsg =
            'Backend error ${response.statusCode}: ${response.body}';
        print('ERROR: $errorMsg');
        throw Exception(errorMsg);
      }

      // Update SharedPreferences after successful API call
      await saveUserData(username: username, email: email, userId: userId);

      // Emit real-time update
      _emitUsername(username);

      print('Profile updated successfully in SharedPreferences');
    } catch (e) {
      print('EXCEPTION in updateUser: $e');
      rethrow;
    }
  }
}
