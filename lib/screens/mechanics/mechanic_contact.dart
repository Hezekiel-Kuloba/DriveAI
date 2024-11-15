import 'package:flutter/material.dart';

class ContactMechanicScreen extends StatelessWidget {
  final Map<String, dynamic> mechanic;

  const ContactMechanicScreen({required this.mechanic, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact ${mechanic['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phone:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              mechanic['contact']['phone'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              mechanic['contact']['email'],
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text('Call Mechanic'),
              onPressed: () {
                // Logic for calling mechanic
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Email Mechanic'),
              onPressed: () {
                // Logic for emailing mechanic
              },
            ),
          ],
        ),
      ),
    );
  }
}
