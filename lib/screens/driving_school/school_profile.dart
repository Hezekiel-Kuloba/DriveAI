import 'package:flutter/material.dart';

class DrivingSchoolProfileScreen extends StatelessWidget {
  final int schoolId;

  DrivingSchoolProfileScreen({required this.schoolId});

  final Map<int, Map<String, dynamic>> schoolProfiles = {
    1: {
      "id": 1,
      "name": "A1 Driving School",
      "description": "A1 Driving School offers professional driving lessons.",
      "courses": [
        {"course_name": "Beginner Course", "price": 200},
        {"course_name": "Advanced Course", "price": 300}
      ],
      "contacts": {
        "phone": "+123456789",
        "email": "info@a1drivingschool.com",
        "website": "https://www.a1drivingschool.com"
      },
      "location": {
        "address": "123 Main St, City Center",
        "region": "Region A",
        "area": "City Center"
      },
      "rating": 4.8,
      "photo_url":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    }
  };

  @override
  Widget build(BuildContext context) {
    final profile = schoolProfiles[schoolId];

    return Scaffold(
      appBar: AppBar(title: Text(profile!['name'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(profile['photo_url']),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(profile['description'],
                  style: const TextStyle(fontSize: 16)),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Courses Offered:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...profile['courses'].map<Widget>((course) {
              return ListTile(
                title: Text(course['course_name']),
                trailing: Text("\$${course['price']}"),
              );
            }).toList(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Contact Info:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text("Phone: ${profile['contacts']['phone']}"),
            ),
            ListTile(
              title: Text("Email: ${profile['contacts']['email']}"),
            ),
            ListTile(
              title: Text("Website: ${profile['contacts']['website']}"),
            ),
          ],
        ),
      ),
    );
  }
}
