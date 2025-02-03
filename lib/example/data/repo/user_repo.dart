import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:possystem/data/models/user.dart';
import 'dart:convert';

class UserRepository {
  final String _baseUrl = 'https://dummyjson.com/users';

  // Fetch all products
  Future<UserResponse> fetchUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return UserResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  // Fetch products by Id
  Future<User> fetchUsersbyId(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception('Failed to fetch user: ${response.statusCode}');
      }
    }
  }

  // Create a new product
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'image': user.image,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }

  // Update an existing product
  Future<User> updateUser(int id, User user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'image': user.image,
      }),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  // Delete a product
  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}

final UserRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
