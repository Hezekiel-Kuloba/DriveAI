import 'package:flutter/material.dart';

class CarAppNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: ListView(
        children: [
          // Sign In
          ListTile(
            leading: Icon(Icons.login),
            title: const Text('Sign In'),
            onTap: () {
              // Navigate to Sign In screen
            },
          ),
          const Divider(),

          // Sell Your Car
          ListTile(
            leading: Icon(Icons.directions_car),
            title: const Text('Sell Your Car'),
            onTap: () {
              // Navigate to Sell Your Car screen
            },
          ),
          const Divider(),

          // Notifications
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to Notifications screen
            },
          ),
          const Divider(),

          // My Documents
          ListTile(
            leading: Icon(Icons.description),
            title: const Text('My Documents'),
            onTap: () {
              // Navigate to My Documents screen
            },
          ),
          const Divider(),

          // Car Service
          ListTile(
            leading: Icon(Icons.car_repair),
            title: const Text('Car Service'),
            onTap: () {
              // Navigate to Car Service screen
            },
          ),
          const Divider(),

          // Mechanics
          ListTile(
            leading: Icon(Icons.build),
            title: const Text('Mechanics'),
            onTap: () {
              // Navigate to Mechanics screen
            },
          ),
          const Divider(),

          // Garages
          ListTile(
            leading: Icon(Icons.garage),
            title: const Text('Garages'),
            onTap: () {
              // Navigate to Garages screen
            },
          ),
          const Divider(),

          // Request Missing Vehicle
          ListTile(
            leading: Icon(Icons.report),
            title: const Text('Report Missing Vehicle'),
            onTap: () {
              // Navigate to Report Missing Vehicle screen
            },
          ),
          const Divider(),

          // Become an Uber Driver
          ListTile(
            leading: Icon(Icons.directions_car_filled),
            title: const Text('Become an Uber Driver'),
            onTap: () {
              // Navigate to Become an Uber Driver screen
            },
          ),
          const Divider(),

          // Manage Your Fleet
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: const Text('Manage Your Fleet'),
            onTap: () {
              // Navigate to Manage Your Fleet screen
            },
          ),
          const Divider(),

          // Book Driving Test
          ListTile(
            leading: Icon(Icons.school),
            title: const Text('Book Driving Test'),
            onTap: () {
              // Navigate to Book Driving Test screen
            },
          ),
          const Divider(),

          // Rent a Car
          ListTile(
            leading: Icon(Icons.directions_car),
            title: const Text('Rent a Car'),
            onTap: () {
              // Navigate to Rent a Car screen
            },
          ),
          const Divider(),

          // Become a Car Renter
          ListTile(
            leading: Icon(Icons.directions_car_outlined),
            title: const Text('Become a Car Renter'),
            onTap: () {
              // Navigate to Become a Car Renter screen
            },
          ),
          const Divider(),

          // Car Events
          ListTile(
            leading: Icon(Icons.event),
            title: const Text('Car Events'),
            onTap: () {
              // Navigate to Car Events screen
            },
          ),
          const Divider(),

          // Share Car App
          ListTile(
            leading: Icon(Icons.share),
            title: const Text('Share Car App'),
            onTap: () {
              // Implement sharing functionality
            },
          ),
          const Divider(),

          // About
          ListTile(
            leading: Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Navigate to About screen
            },
          ),
          const Divider(),

          // Donate
          ListTile(
            leading: Icon(Icons.volunteer_activism),
            title: const Text('Donate'),
            onTap: () {
              // Navigate to Donate screen
            },
          ),
          const Divider(),

          // Language
          ListTile(
            leading: Icon(Icons.language),
            title: const Text('Language'),
            onTap: () {
              // Navigate to Language settings
            },
          ),
          const Divider(),

          // Help & Settings
          ListTile(
            leading: Icon(Icons.help_outline),
            title: const Text('Help & Settings'),
            onTap: () {
              // Navigate to Help & Settings screen
            },
          ),
        ],
      ),
    );
  }
}
