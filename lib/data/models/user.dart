class User {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  // final String? accessToken;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    // this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
      // accessToken: json['accessToken'] as String?,
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

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      users:
          (json['users'] as List).map((user) => User.fromJson(user)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
