import 'package:flutter/material.dart';
import 'package:new_car_app/screens/garages/garage_profile.dart';

class GarageListScreen extends StatelessWidget {
  // GarageListScreen({super.key});

  final bool isPage;

  GarageListScreen({super.key, this.isPage = false});

  final List<Map<String, dynamic>> garageList = [
    {
      "id": 1,
      "name": "AutoFix Garage",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.8,
      "reviews": 320,
      "region": "Nairobi",
      "location": "Upperhill"
    },
    {
      "id": 2,
      "name": "Speedy Repairs",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.5,
      "reviews": 180,
      "region": "Nairobi",
      "location": "Westlands"
    },
    {
      "id": 3,
      "name": "Metro Garage",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.2,
      "reviews": 200,
      "region": "Nairobi",
      "location": "Kilimani"
    },
    {
      "id": 4,
      "name": "FixIt Auto Shop",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.7,
      "reviews": 250,
      "region": "Nairobi",
      "location": "Parklands"
    },
    {
      "id": 5,
      "name": "All-Star Mechanics",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.1,
      "reviews": 100,
      "region": "Nairobi",
      "location": "CBD"
    },
    {
      "id": 6,
      "name": "Prime Auto Services",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.9,
      "reviews": 400,
      "region": "Nairobi",
      "location": "Kasarani"
    },
    {
      "id": 7,
      "name": "Quick Fix Garage",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
      "rating": 4.6,
      "reviews": 230,
      "region": "Nairobi",
      "location": "Lavington"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPage
          ? AppBar(
              title: const Text('Garage List'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(); // Go back
                },
              ),
            )
          : null, // No AppBar when used as a container
      body: ListView.builder(
        itemCount: garageList.length,
        physics: isPage
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(), // Scrolling behavior depends on mode
        itemBuilder: (context, index) {
          var garage = garageList[index];
          return GestureDetector(
            onTap: () {
              // Navigate to GarageProfileScreen only if in page mode
              if (isPage) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GarageProfileScreen(),
                  ),
                );
              }
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garage Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(garage['image']),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Garage Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(garage['name'],
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            Text(
                              '${garage['rating']}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text('${garage['region']}, ${garage['location']}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
