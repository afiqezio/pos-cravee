import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/data/models/user.dart';
import 'package:possystem/example/data/repo/authRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Viewmodel Provider
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});

class AuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository repository;

  AuthViewModel(this.repository) : super(const AsyncData(null));

  Future<bool> login(String username, String password, WidgetRef ref) async {
    try {
      state = const AsyncLoading();
      debugPrint('login: $username, $password');
      final user = await repository.login(username, password);
      state = AsyncData(user);
      await ref.read(userProvider.notifier).savePreferencesUserData(user);

      return true;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return false;
    }
  }

  void logout(WidgetRef ref) async {
    // Clear user data from storage
    await ref.read(userProvider.notifier).clearUserData();
    state = const AsyncData(null);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// State Provider for Login Status
final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>(
    (ref) => AuthStateNotifier());

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier() : super(false) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userListString = prefs.getString('userList');
    if (userListString != null) {
      state = true;
    } else {
      state = false;
    }
    // final prefs = await SharedPreferences.getInstance();
    // state = prefs.containsKey('accessToken');
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// User Provider
final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  Future<void> savePreferencesUserData(User user) async {
    state = user;
    final prefs = await SharedPreferences.getInstance();
    final String? userListString = prefs.getString('userList');
    List<Map<String, String>> userList = [];

    if (userListString != null) {
      try {
        // Decode the JSON string back to a list of maps
        List<dynamic> decodedList = jsonDecode(userListString);
        userList = decodedList.map((item) {
          return Map<String, String>.from(item as Map<dynamic, dynamic>);
        }).toList();
      } catch (e) {
        debugPrint('Error decoding user list: $e');
        userList = [];
      }
    }

    // Check if the user already exists in the list
    if (!userList
        .any((existingUser) => existingUser['id'] == user.id.toString())) {
      // Create a map for the current user
      final userDetails = {
        'id': user.id.toString(),
        'firstName': user.firstName,
        'lastName': user.lastName,
        'gender': user.gender,
        'image': user.image,
      };
      // Add the current user's details to the list
      userList.add(userDetails);
    }

    // Save the access token (change with secure storage)
    final storage = FlutterSecureStorage();
    await storage.write(key: 'access_token', value: user.accessToken);

    // Save the updated list of user details in SharedPreferences as a JSON string
    await prefs.setString('userList', jsonEncode(userList));
  }

  Future<List<Map<String, String>>> getPreferencesUserList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userListString = prefs.getString('userList');

    if (userListString != null) {
      // Decode the JSON string back to a list of maps
      List<dynamic> userListJson = jsonDecode(userListString);
      return userListJson
          .map((user) => Map<String, String>.from(user))
          .toList();
    }
    return [];
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = null;
  }
}
