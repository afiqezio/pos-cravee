import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    await prefs.setString('userList', jsonEncode(userList));
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = null;
  }
}
