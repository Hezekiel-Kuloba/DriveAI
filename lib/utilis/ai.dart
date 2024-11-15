// car_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/constants/endpoints.dart';
import 'package:new_car_app/models/ai.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AiNotifier extends StateNotifier<List<ServiceAI>> {
  AiNotifier() : super([]);

  Future<List<ServiceAI>> getServiceTitles({
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/ai-title');

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
        final serviceTitles = data['entities']
            .map<ServiceAI>((e) => ServiceAI.fromJson(e))
            .toList();

        // Print the result of filtered services titles`
        print('Filtered services titles:');
        for (var service in serviceTitles) {
          print('Service ID: ${service.id}');
        }

        return serviceTitles;
      } else {
        throw Exception('Failed to load services titles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<ServiceAI>> getServiceNames({
    required String token,
    required int titleId,
  }) async {
    final url = Uri.parse('$baseUrl/ai-name');

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
        final serviceNames = data['entities']
            .map<ServiceAI>((e) => ServiceAI.fromJson(e))
            .where((entity) =>
                entity.titleId == titleId) // Use the property of ServiceAI
            .toList();

        // Print the result of filtered services titles`
        print('Filtered services names:');
        for (var service in serviceNames) {
          print('Service ID: ${service.id}');
        }

        return serviceNames;
      } else {
        throw Exception('Failed to load services titles');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final aiProvider = StateNotifierProvider<AiNotifier, List<ServiceAI>>((ref) {
  return AiNotifier();
});
