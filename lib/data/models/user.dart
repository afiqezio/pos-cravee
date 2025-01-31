import 'dart:convert';

class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String? accessToken;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      accessToken: json['accessToken'] as String?,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'username': username,
  //     'email': email,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'gender': gender,
  //     'image': image,
  //     'accessToken': accessToken,
  //   };
  // }
}

class UserResponse {
  final List<User> users;
  final int total;
  final int skip;
  final int limit;

  UserResponse({
    required this.users,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory UserResponse.fromJson(String source) {
    final json = jsonDecode(source);
    print('UserResponse.fromJson: ${json['users']}');
    return UserResponse(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  // User toUser() {
  //   if (users.isNotEmpty) {
  //     return users.first;
  //   } else {
  //     throw Exception("No users found in UserResponse");
  //   }
  // }
}
