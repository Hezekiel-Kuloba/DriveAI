import 'package:flutter/material.dart';
import 'package:new_car_app/screens/location/places_list.dart';
import 'package:new_car_app/screens/traffic_jam/traffic_jam.dart';

class NearbyServicesSlider extends StatefulWidget {
  NearbyServicesSlider({super.key});

  final List<Map<String, dynamic>> services = [
    {
      "name": "Gas Station",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730272530/pexels-enginakyurt-12377482_11zon_h1hxdq.jpg",
      "placeType": "gas_station",
      "title": "Petrol Stations",
    },
    {
      "name": "Charging Station",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730272231/stephen-mease-5hbzWe6ens4-unsplash_11zon_axobyt.jpg",
      "placeType": "charging_station",
      "title": "Electric Charging Stations",
    },
    {
      "name": "Garage",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730272227/kate-ibragimova-iFQpqbLMOFU-unsplash_11zon_ba5rli.jpg",
      "placeType": "car_repair",
      "title": "Garages",
    },
    {
      "name": "Restaurant",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730272228/jenn-kosar-jrWoDRmhwRY-unsplash_11zon_yhm42g.jpg",
      "placeType": "restaurant",
      "title": "Restaurants",
    },
    {
      "name": "Driving School",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730273890/anastasiya-badun-bBfxkKwy8Bg-unsplash_11zon_yz4rw3.jpg",
      "placeType": "driving_school",
      "title": "Driving Schools",
    },
    {
      "name": "Hospital",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1730272227/national-cancer-institute-701-FJcjLAQ-unsplash_11zon_mhe432.jpg",
      "placeType": "hospital",
      "title": "Hospitals",
    },
  ];

  @override
  _NearbyServicesSliderState createState() => _NearbyServicesSliderState();
}

class _NearbyServicesSliderState extends State<NearbyServicesSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Near Me',
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
                  fit: BoxFit.cover,
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

  // Navigation logic based on the service type
  void _navigateToService(Map<String, dynamic> service, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacesListScreen(
          placeType: service['placeType'],
          title: service['title'],
        ),
      ),
    );
  }
}
