import 'package:flutter/material.dart';
// import 'package:possystem/data/models/user.dart';

@immutable
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

@immutable
class LoginResponse {
  final String accessToken;
  // final User user;

  const LoginResponse({
    required this.accessToken,
    // required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['token'],
        // user: User.fromJson({
        //   'id': json['id'],
        //   'username': json['username'],
        //   'email': json['email'],
        //   'firstName': json['firstName'],
        //   'lastName': json['lastName'],
        //   'gender': json['gender'],
        //   'image': json['image'],
        // }),
      );
}
