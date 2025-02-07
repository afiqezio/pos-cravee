// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:possystem/core/api/api_service.dart';
// import 'package:possystem/core/exceptions/api_exception.dart';
// import 'package:possystem/data/models/authModel.dart';

// class AuthRepository {
//   static const String _loginEndpoint = '/auth/login';

//   final ApiService _apiService;

//   AuthRepository(this._apiService);

//   Future<LoginResponse> login(LoginRequest request) async {
//     try {
//       final data = await _apiService.post(
//         _loginEndpoint,
//         request.toJson(),
//       );

//       return LoginResponse.fromJson(data);
//     } on ApiException catch (e) {
//       if (e.statusCode == 401) {
//         throw ApiException(
//             message: 'Incorrect username or password',
//             statusCode: e.statusCode);
//       }
//       throw e.message;
//     }
//   }

//   Future<bool> loginByKey(String username, String pin) async {
//     try {
//       final storedPin = await getUserPin(username);
//       return pin == storedPin;
//     } catch (e) {
//       throw Exception('PIN verification failed: $e');
//     }
//   }

//   Future<String> getUserPin(String username) async {
//     // Implement your logic to retrieve the user's PIN from a secure source
//     // For example, querying a database or secure storage
//     return "000000"; // Example PIN for demonstration purposes
//   }
// }

// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return AuthRepository(apiService);
// });
