import 'package:flutter/material.dart';

class GarageDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> garage;

  const GarageDetailsScreen({super.key, required this.garage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(garage['garage'] ?? 'Garage Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Garage: ${garage['garage']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Location: ${garage['location']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Contact: ${garage['contact']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Services Offered:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: garage['services']?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(garage['services'][index]['name']),
                    subtitle: Text(
                      'Price: ${garage['services'][index]['price']}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
