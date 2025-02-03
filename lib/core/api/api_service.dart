// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:possystem/data/models/auth.dart';
// import '../exceptions/network_exception.dart';

// final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// class ApiService {
//   final Dio _dio = Dio(BaseOptions(
//     baseUrl: 'https://dummyjson.com',
//     connectTimeout: const Duration(seconds: 10),
//   ));

//   Future<LoginResponse> login(LoginRequest request) async {
//     try {
//       final response = await _dio.post('/auth/login', data: request.toJson());
//       return LoginResponse.fromJson(response.data);
//     } on DioException catch (e) {
//       throw NetworkException(e.message ?? 'Network error occurred');
//     }
//   }
// }
