// car_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/constants/endpoints.dart';
import 'package:new_car_app/models/car.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_car_app/models/user.dart';
import 'package:new_car_app/utilis/user.dart';

class CarNotifier extends StateNotifier<List<Entity>> {
  CarNotifier() : super([]);

  // Add car to garage
  Future<String> addCarToGarage({
    required int carId,
    required int userId,
    required int mileage,
    required String mileageUnit,
    required String fuelType,
    required String serviceDate,
    required String currencyType,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/user-garage/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user_garage": {
            "carId": carId,
            "userId": userId,
            "mileage": mileage,
            "mileageUnit": mileageUnit,
            "fuelType": fuelType,
            "serviceDate": serviceDate,
            "dailyFuelExpenditure": 0,
            "monthlyFuelExpenditure": 0,
            "CurrencyType": currencyType,
          },
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        return 'Car added to your garage successfully!';
      } else {
        throw Exception(data['message'] ?? 'Failed to add car');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

// Update field in user garage
  Future<String> updateGarageField({
    required int? id,
    int? mileage,
    String? fuelType,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/user-garage/update');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "user_garage": {
            "id": id,
            if (mileage != null) "mileage": mileage,
            if (fuelType != null) "fuelType": fuelType,
          },
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        return 'Garage field updated successfully!';
      } else {
        throw Exception(data['message'] ?? 'Failed to update field');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch all cars
  Future<List<Entity>> getCars({
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/admin-garage');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['entities'] != null) {
        return List<Entity>.from(
            data['entities'].map((e) => Entity.fromJson(e)));
      } else {
        throw Exception('Failed to load cars');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Entity>> getUserCars({
    required String token,
    required int loggedInUserId,
  }) async {
    final url = Uri.parse('$baseUrl/user-garage');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['entities'] != null) {
        // Filter cars by loggedInUserId
        final userCars = data['entities']
            .where((entity) => entity['userId'] == loggedInUserId)
            .map<Entity>((e) => Entity.fromJson(e))
            .toList();

        // Print the result of filtered user cars
        print('Filtered user cars:');
        for (var car in userCars) {
          print('Car ID: ${car.id}, Name: ${car.name}, Model: ${car.model}');
        }

        return userCars;
      } else {
        throw Exception('Failed to load user cars');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final carProvider = StateNotifierProvider<CarNotifier, List<Entity>>((ref) {
  return CarNotifier();
});
