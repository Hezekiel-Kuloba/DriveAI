import 'package:flutter/material.dart';
import 'package:new_car_app/screens/fuel/fuel.dart';
import 'package:new_car_app/screens/garages/garage.dart';
import 'package:new_car_app/screens/mechanics/mechanics.dart';
import 'package:new_car_app/screens/service/car_service.dart';
import 'package:new_car_app/screens/tyres/tyres.dart';

class MainServicesList extends StatefulWidget {
  MainServicesList({super.key});

  final List<Map<String, dynamic>> services = [
    {
      "name": "Service Car",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729668841/service_tlqwpr.png",
      "placeType": "gas_station",
      "title": "Petrol Stations",
    },
    {
      "name": "Garage",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729669182/garage_11zon_ygppj2.png",
      "placeType": "charging_station",
      "title": "Electric Charging Stations",
    },
    {
      "name": "Mechanic",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729668835/mechanic_mf4ydr.png",
      "placeType": "car_repair",
      "title": "Garages",
    },
    {
      "name": "Fuel",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729668835/fuel_ackuof.png",
      "placeType": "restaurant",
      "title": "Restaurants",
    },
    {
      "name": "Tyres",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png",
      "placeType": "restaurant",
      "title": "Tyres",
    },
  ];

  @override
  _MainServicesListState createState() => _MainServicesListState();
}

// Method to build individual service cards
Widget buildServiceCard(String name, String imageUrl) {
  return Container(
    width: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image on the card
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            imageUrl,
            height: 100,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

class _MainServicesListState extends State<MainServicesList> {
  void _navigateToService(Map<String, dynamic> service, BuildContext context) {
    switch (service['name']) {
      case 'Service Car':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceScreen()),
        );
        break;
      case 'Garage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GarageServiceScreen()),
        );
        break;
      case 'Mechanic':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MechanicServiceScreen()),
        );
        break;
      case 'Fuel':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FuelServiceScreen()),
        );
        break;
      case 'Tyres':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TyreServiceScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Features',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 130, // Set height for the list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        _navigateToService(widget.services[index], context),
                    child: buildServiceCard(
                      widget.services[index]['name'],
                      widget.services[index]['imageUrl'],
                    ),
                  ),
                  const SizedBox(width: 8), // Space between cards
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single service card
  Widget buildServiceCard(String serviceName, String imageUrl) {
    return SizedBox(
      width: 130, // Fixed width for each card
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 135.0, // Fixed height for cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                child: Image.network(
                  imageUrl,
                  height: 60,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                serviceName,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
