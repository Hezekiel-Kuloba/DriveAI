import 'package:flutter/material.dart';
import 'package:new_car_app/screens/mechanics/mechanic_profile.dart';
import 'package:new_car_app/screens/mechanics/mechanics_add.dart'; // Import the registration screen

class MechanicsListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mechanics = [
    {
      "id": "1",
      "name": "John Doe",
      "location": "123 Main St, Cityville",
      "rating": 4.5,
      "profile_picture":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": "2",
      "name": "Mike Smith",
      "location": "456 Second St, Cityville",
      "rating": 4.2,
      "profile_picture":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": "3",
      "name": "Sarah Lee",
      "location": "789 Third St, Cityville",
      "rating": 4.7,
      "profile_picture":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
  ];

  MechanicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanics Near Me'),
        // backgroundColor: Colors.black, // Stylish black AppBar
      ),
      body: ListView.builder(
        itemCount: mechanics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ListTile(
              // contentPadding: const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(mechanics[index]['profile_picture']),
                radius: 35,
              ),
              title: Text(
                mechanics[index]['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height: 5), // Add some space between name and details
                  Text(
                    mechanics[index]['location'],
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10), // Space before the rating
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Align rating to the right
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        mechanics[index]['rating'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MechanicProfileScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),

      // Add the floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the MechanicRegistrationScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MechanicRegistrationScreen(),
            ),
          );
        },
        backgroundColor:
            Colors.black, // Stylish black background for the button
        child: const Icon(Icons.add, color: Colors.white), // Add icon
      ),
    );
  }
}
