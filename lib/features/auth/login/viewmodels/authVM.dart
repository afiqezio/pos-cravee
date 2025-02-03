// // auth_viewmodel.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:possystem/data/repo/authRepo.dart';

// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(ref.read(authRepositoryProvider)),
// );

// class AuthViewModel extends StateNotifier<AuthState> {
//   final AuthRepository _repository;

//   AuthViewModel(this._repository) : super(AuthState.initial());

//   Future<void> login(String email, String password) async {
//     state = state.copyWith(isLoading: true, error: null);

//     final result =
//         await AsyncValue.guard(() => _repository.login(email, password));

//     state = result.when(
//       data: (response) {
//         // Handle successful login
//         return state.copyWith(
//           isLoading: false,
//           isSuccess: true,
//           token: response.accessToken,
//         );
//       },
//       error: (error, _) => state.copyWith(
//         isLoading: false,
//         error: error.toString(),
//       ),
//       loading: () => state.copyWith(isLoading: true),
//     );
//   }
// }

// // auth_state.dart
// @immutable
// class AuthState {
//   final bool isLoading;
//   final bool isSuccess;
//   final String? error;
//   final String? token;

//   const AuthState({
//     this.isLoading = false,
//     this.isSuccess = false,
//     this.error,
//     this.token,
//   });

//   AuthState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     String? error,
//     String? token,
//   }) {
//     return AuthState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       error: error ?? this.error,
//       token: token ?? this.token,
//     );
//   }

//   static AuthState initial() => const AuthState();
// }
