import 'package:flutter/material.dart';

class ServiceAIScreen extends StatelessWidget {
  final String itemName;
  final String carName;

  const ServiceAIScreen({
    Key? key,
    required this.itemName,
    required this.carName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service AI Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Name: $itemName', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text('Car Name: $carName', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
