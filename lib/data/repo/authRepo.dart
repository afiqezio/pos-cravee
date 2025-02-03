// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:possystem/core/api/api_service.dart';
// import 'package:possystem/core/exceptions/app_exception.dart';
// import 'package:possystem/data/models/auth.dart';
// import 'package:possystem/core/exceptions/network_exception.dart';

// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   return AuthRepository(ref.read(apiServiceProvider));
// });

// class AuthRepository {
//   final ApiService _apiService;

//   AuthRepository(this._apiService);

//   Future<LoginResponse> login(String email, String password) async {
//     try {
//       return await _apiService
//           .login(LoginRequest(email: email, password: password));
//     } on NetworkException {
//       rethrow;
//     } catch (e) {
//       throw AppException('Login failed: ${e.toString()}');
//     }
//   }

//   Future<bool> loginByKey(String username, String pin) async {
//     final storedPin = await getUserPin(username);
//     return pin == storedPin;
//   }

//   Future<String> getUserPin(String username) async {
//     // Implement your logic to retrieve the user's PIN from a secure source
//     // For example, querying a database or secure storage
//     return "000000"; // Example PIN for demonstration purposes
//   }
// }
