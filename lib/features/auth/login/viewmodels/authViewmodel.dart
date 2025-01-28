import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:possystem/data/repo/authRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/models/user.dart';

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
      final user = await repository.login(username, password);

      state = AsyncData(user);
      // Store user details locally
      await ref.read(userProvider.notifier).saveUserData(user);
      return true; // Login success
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return false; // Login failed
    }
  }

  void logout(WidgetRef ref) async {
    // Clear user data from storage
    await ref.read(userProvider.notifier).clearUserData();
    state = const AsyncData(null);
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>(
    (ref) => AuthStateNotifier());

class AuthStateNotifier extends StateNotifier<bool> {
  AuthStateNotifier() : super(false) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.containsKey('accessToken');
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Future<void> loadUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userMap = {
  //     'firstName': prefs.getString('firstName') ?? '',
  //     'lastName': prefs.getString('lastName') ?? '',
  //     'gender': prefs.getString('gender') ?? '',
  //     'image': prefs.getString('image') ?? '',
  //     'accessToken': prefs.getString('accessToken') ?? '',
  //   };
  //   state = User.fromJson(userMap);
  // }

  Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    for (var entry in user.toJson().entries) {
      await prefs.setString(entry.key, entry.value.toString());
    }
    state = user;
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = null;
  }
}
