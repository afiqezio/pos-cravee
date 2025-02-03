import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:possystem/data/models/auth.dart';
import 'package:possystem/data/repo/auth_repo.dart';
import 'package:possystem/features/auth/login/viewmodels/userViewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Viewmodel Provider
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<LoginResponse?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository);
});

class AuthViewModel extends StateNotifier<AsyncValue<LoginResponse?>> {
  final AuthRepository repository;

  AuthViewModel(this.repository) : super(const AsyncData(null));

  Future<bool> login(String username, String password, WidgetRef ref) async {
    try {
      state = const AsyncLoading();
      debugPrint('login: $username, $password');
      final user = await repository
          .login(LoginRequest(username: username, password: password));
      state = AsyncData(user);

      await ref.read(userProvider.notifier).savePreferencesUserData(user.user);
      // Save the access token (change with secure storage)
      final storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: user.accessToken);

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
