// user_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/constants/endpoints.dart';
import 'package:new_car_app/models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  Future<String> signUp({
    required String firstname,
    required String lastname,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/sign-up');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user": {
            "first_name": firstname,
            "last_name": lastname,
            "email": email,
            "phone": phoneNumber,
            "password": password,
          }
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        state = User.fromJson(data);
        return 'You have signed up successfully!';
      } else {
        // final errorMessage = data['message'] ?? 'Please fill all the fields';
        final errorMessage = 'Please fill all the fields';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        state = User.fromJson(data);
        return 'You have logged in!';
      } else {
        // final errorMessage = data['message'] ?? 'Please fill all the fields';
        final errorMessage = 'Invalid email or password';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
