import 'package:flutter/material.dart';

class HospitalsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hospitals = List.generate(15, (index) {
    return {
      "name": "Hospital ${index + 1}",
      "distance": "${(index + 1) * 0.6} km away",
    };
  });

  HospitalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Hospitals'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.local_hospital),
            title: Text(hospitals[index]['name']),
            subtitle: Text(hospitals[index]['distance']),
          );
        },
      ),
    );
  }
}
