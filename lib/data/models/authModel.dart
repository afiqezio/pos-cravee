import 'package:flutter/material.dart';
import 'package:possystem/data/models/user.dart';

@immutable
class LoginRequest {
  final String username;
  final String password;

  const LoginRequest({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

@immutable
class LoginResponse {
  final String accessToken;
  final User user;

  const LoginResponse({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['accessToken'],
        user: User.fromJson({
          'id': json['id'],
          'username': json['username'],
          'email': json['email'],
          'firstName': json['firstName'],
          'lastName': json['lastName'],
          'gender': json['gender'],
          'image': json['image'],
        }),
      );
}
