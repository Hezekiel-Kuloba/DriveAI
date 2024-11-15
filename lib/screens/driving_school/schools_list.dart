import 'package:flutter/material.dart';
import 'package:new_car_app/screens/driving_school/school_profile.dart';

class DrivingSchoolsListScreen extends StatelessWidget {
  final List drivingSchools = [
    {
      "id": 1,
      "name": "A1 Driving School",
      "region": "Region A",
      "area": "City Center",
      "rating": 4.8,
      "photo_url":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": 2,
      "name": "Speedy Driving School",
      "region": "Region B",
      "area": "Suburbs",
      "rating": 4.5,
      "photo_url":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driving Schools")),
      body: ListView.builder(
        itemCount: drivingSchools.length,
        itemBuilder: (context, index) {
          final school = drivingSchools[index];
          return ListTile(
            leading: Image.network(school['photo_url']),
            title: Text(school['name']),
            subtitle: Text('${school['region']}, ${school['area']}'),
            trailing: Text('Rating: ${school['rating']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DrivingSchoolProfileScreen(schoolId: school['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
