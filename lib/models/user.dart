// user_model.dart
class UserResponse {
  final String? message;
  final String? token;
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone; // Changed from String? to int?
  final String? password;
  final String? role;

  UserResponse({
    this.message,
    this.token,
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      id: json['id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone, // Convert back to string for JSON
      'password': password,
      'role': role,
    };
  }
}

class User {
  final int? resultCode;
  final UserResponse? user;
  final String? token;

  User({
    this.resultCode,
    this.user,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      resultCode: json['result_code'],
      user: json['user'] != null ? UserResponse.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result_code': resultCode,
      'user': user?.toJson(),
      'token': token,
    };
  }
}
