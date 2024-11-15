import 'package:flutter/material.dart';
import 'package:new_car_app/screens/location/places_list.dart';
import 'package:new_car_app/screens/traffic_jam/traffic_jam.dart';

class GoogleMapsPlaces extends StatelessWidget {
  const GoogleMapsPlaces({super.key});

  @override
  Widget build(BuildContext  context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Services')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Petrol Stations'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesListScreen(
                  placeType: 'gas_station',
                  title: 'Petrol Stations',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Electric Charging Stations'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesListScreen(
                  placeType: 'charging_station', // Custom search type
                  title: 'Electric Charging Stations',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Garages'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesListScreen(
                  placeType: 'car_repair',
                  title: 'Garages',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Driving Schools'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesListScreen(
                  placeType: 'driving_school', // Custom search type
                  title: 'Driving Schools',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Bus Stations'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesListScreen(
                  placeType: 'bus_station',
                  title: 'Bus Stations',
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Traffic Jams'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrafficScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
