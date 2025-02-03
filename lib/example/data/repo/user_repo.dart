import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/core/api/api_service.dart';
import 'package:possystem/core/exceptions/api_exception.dart';
import 'package:possystem/data/models/user.dart';

class UserRepository {
  static const String _endpoint = '/users';

  final ApiService _apiService;

  UserRepository(this._apiService);

  // Fetch all users
  Future<UserResponse> fetchUsers() async {
    try {
      final data = await _apiService.get(_endpoint);
      return UserResponse.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to fetch users: ${e.message}');
    }
  }

  // Fetch user by id
  Future<User> fetchUserById(String id) async {
    try {
      final data = await _apiService.get('$_endpoint/$id');
      return User.fromJson(data);
    } on ApiException catch (e) {
      if (e.statusCode == 404) {
        throw Exception('User not found');
      }
      throw Exception('Failed to fetch user: ${e.message}');
    }
  }

  // Create a new user
  Future<User> createUser(User user) async {
    try {
      final data = await _apiService.post(
        _endpoint,
        {
          'username': user.username,
          'email': user.email,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'gender': user.gender,
          'image': user.image,
        },
      );
      return User.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to create user: ${e.message}');
    }
  }

  // Update an existing user
  Future<User> updateUser(int id, User user) async {
    try {
      final data = await _apiService.put(
        '$_endpoint/$id',
        {
          'username': user.username,
          'email': user.email,
          'firstName': user.firstName,
          'lastName': user.lastName,
          'gender': user.gender,
          'image': user.image,
        },
      );
      return User.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to update user: ${e.message}');
    }
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    try {
      await _apiService.delete('$_endpoint/$id');
    } on ApiException catch (e) {
      throw Exception('Failed to delete user: ${e.message}');
    }
  }

  // Search users
  Future<UserResponse> searchUsers(String query) async {
    try {
      final data = await _apiService.get(
        '$_endpoint/search',
        queryParameters: {'q': query},
      );
      return UserResponse.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to search users: ${e.message}');
    }
  }

  // Filter users
  Future<UserResponse> filterUsers({
    String? gender,
    int? limit,
    int? skip,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        if (gender != null) 'gender': gender,
        if (limit != null) 'limit': limit,
        if (skip != null) 'skip': skip,
      };

      final data = await _apiService.get(
        _endpoint,
        queryParameters: queryParams,
      );
      return UserResponse.fromJson(data);
    } on ApiException catch (e) {
      throw Exception('Failed to filter users: ${e.message}');
    }
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService);
});
