import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:possystem/core/exceptions/api_exception.dart';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:4000/api';

  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint').replace(
        queryParameters: queryParameters?.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Request failed',
          statusCode: response.statusCode,
        );
      }
    } on FormatException {
      throw const ApiException(message: 'Invalid response format from server');
    } on http.ClientException {
      throw const ApiException(message: 'Network error occurred');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Request failed',
          statusCode: response.statusCode,
        );
      }
    } on FormatException {
      throw const ApiException(message: 'Invalid response format from server');
    } on http.ClientException {
      throw const ApiException(message: 'Network error occurred');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.put(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Request failed',
          statusCode: response.statusCode,
        );
      }
    } on FormatException {
      throw const ApiException(message: 'Invalid response format from server');
    } on http.ClientException {
      throw const ApiException(message: 'Network error occurred');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final request = http.Request('DELETE', Uri.parse('$_baseUrl$endpoint'));

      request.headers.addAll({
        'Content-Type': 'application/json',
        ...?headers,
      });

      if (body != null) {
        request.body = jsonEncode(body);
      }

      final streamedResponse = await _client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Request failed',
          statusCode: response.statusCode,
        );
      }
    } on FormatException {
      throw const ApiException(message: 'Invalid response format from server');
    } on http.ClientException {
      throw const ApiException(message: 'Network error occurred');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  void dispose() {
    _client.close();
  }
}

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  final apiService = ApiService();
  ref.onDispose(() => apiService.dispose());
  return apiService;
});
