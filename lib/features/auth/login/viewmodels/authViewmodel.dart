import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:possystem/app/app.dart';
import 'package:possystem/data/models/authModel.dart';
import 'package:possystem/data/repo/auth_repo.dart';
import 'package:possystem/features/auth/login/viewmodels/userViewmodel.dart';
import 'package:possystem/features/auth/login/views/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Viewmodel Provider
final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<LoginResponse?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthViewModel(repository, ref);
});

class AuthViewModel extends StateNotifier<AsyncValue<LoginResponse?>> {
  final AuthRepository repository;
  final Ref ref;

  AuthViewModel(this.repository, this.ref) : super(const AsyncData(null));

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    debugPrint('login: $username, $password');
    try {
      final loginResponse = await repository.login(
        LoginRequest(username: username, password: password),
      );
      state = AsyncData(loginResponse);

      await ref
          .read(userProvider.notifier)
          .savePreferencesUserData(loginResponse.user);

      final storage = FlutterSecureStorage();
      const kAccessTokenKey = 'access_token';
      await storage.write(
          key: kAccessTokenKey, value: loginResponse.accessToken);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      throw error.toString();
    }
  }

  void logout() async {
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
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Widget Function
Future<void> loginValidation(
    String email, String password, BuildContext context, WidgetRef ref) async {
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Please fill in both email and password.');
    return;
  }

  try {
    await ref.read(authViewModelProvider.notifier).login(email, password);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => AppPage()),
    );
  } catch (error) {
    // throw Exception(error.toString());
  }
}
