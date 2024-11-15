// car_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/constants/endpoints.dart';
import 'package:new_car_app/models/service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceNotifier extends StateNotifier<List<Service>> {
  ServiceNotifier() : super([]);

  // Update field in user garage
  Future<String> updateServiceField({
    required int? id,
    String? status,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/service-notify/update');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "service_notify": {
            "id": id,
            if (status != null) "status": status,
          },
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        return 'Status field updated successfully!';
      } else {
        throw Exception(data['message'] ?? 'Failed to update status field');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Add Service to garage
  Future<String> addUserService({
    required int userId,
    required int date,
    required int time,
    required String item,
    required String description,
    required String status,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/service-notify/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "service_notify": {
            "userId": userId,
            "date": date,
            "time": time,
            "item": item,
            "description": description,
            "status": status
          },
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['result_code'] == 1) {
        return 'Service added successfully!';
      } else {
        throw Exception(data['message'] ?? 'Failed to add service');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Service>> getUserService({
    required String token,
    required int loggedInUserId,
  }) async {
    final url = Uri.parse('$baseUrl/service-notify');

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
        // Filter service by loggedInUserId
        final userServices = data['entities']
            .where((service) => service['userId'] == loggedInUserId)
            .map<Service>((e) => Service.fromJson(e))
            .toList();

        // Print the result of filtered user services`
        print('Filtered user services:');
        for (var service in userServices) {
          print('Service ID: ${service.id}');
        }

        return userServices;
      } else {
        throw Exception('Failed to load user services');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String> deleteService({
    required String token,
    required int id,
  }) async {
    final url = Uri.parse('$baseUrl/service-notify/delete');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "service_notify": {
            "id": id,
          }
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Service deleted successfully!';
      } else {
        throw Exception(data['message'] ?? 'Failed to delete service');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final serviceProvider =
    StateNotifierProvider<ServiceNotifier, List<Service>>((ref) {
  return ServiceNotifier();
});
