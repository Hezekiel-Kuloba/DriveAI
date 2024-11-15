import 'package:flutter/material.dart';

class GasStationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> gasStations = List.generate(15, (index) {
    return {
      "name": "Gas Station ${index + 1}",
      "distance": "${(index + 1) * 0.5} km away",
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Gas Stations'),
      ),
      body: ListView.builder(
        itemCount: gasStations.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: Text(gasStations[index]['name']),
            subtitle: Text(gasStations[index]['distance']),
          );
        },
      ),
    );
  }
}
