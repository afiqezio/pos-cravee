import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/models/user.dart';

class AuthRepository {
  final String _loginUrl = 'https://dummyjson.com/auth/login';

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> loginByKey(String username, String pin) async {
    final storedPin = await getUserPin(username);
    return pin == storedPin;
  }

  Future<String> getUserPin(String username) async {
    // Implement your logic to retrieve the user's PIN from a secure source
    // For example, querying a database or secure storage
    return "000000"; // Example PIN for demonstration purposes
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
