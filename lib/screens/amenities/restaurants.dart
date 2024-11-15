import 'package:flutter/material.dart';

class RestaurantsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants = List.generate(15, (index) {
    return {
      "name": "Restaurant ${index + 1}",
      "distance": "${(index + 1) * 0.3} km away",
    };
  });

  RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.restaurant),
            title: Text(restaurants[index]['name']),
            subtitle: Text(restaurants[index]['distance']),
          );
        },
      ),
    );
  }
}
