import 'package:flutter/material.dart';

class ChargingStationsScreen extends StatelessWidget {
  ChargingStationsScreen({super.key});

  final List<Map<String, dynamic>> chargingStations =
      List.generate(15, (index) {
    return {
      "name": "Charging Station ${index + 1}",
      "distance": "${(index + 1) * 0.4} km away",
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Electric Charging Stations'),
      ),
      body: ListView.builder(
        itemCount: chargingStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.ev_station),
            title: Text(chargingStations[index]['name']),
            subtitle: Text(chargingStations[index]['distance']),
          );
        },
      ),
    );
  }
}
