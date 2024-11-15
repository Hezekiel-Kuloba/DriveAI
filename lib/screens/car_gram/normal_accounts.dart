import 'package:flutter/material.dart';

// List of Car Accounts
class CarAccountListWidget extends StatelessWidget {
  // Example JSON data for car accounts
  final List<Map<String, dynamic>> carAccounts = [
    {
      "id": 1,
      "name": "Mercedes",
      "profilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    },
    {
      "id": 2,
      "name": "BMW",
      "profilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    },
    {
      "id": 3,
      "name": "Audi",
      "profilePic":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: carAccounts.length,
          itemBuilder: (context, index) {
            final account = carAccounts[index];
            return CarAccountItem(
              name: account['name'],
              profilePic: account['profilePic'],
            );
          },
        ),
      ],
    );
  }
}

// Individual Car Account Item
class CarAccountItem extends StatelessWidget {
  final String name;
  final String profilePic;

  const CarAccountItem({
    required this.name,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profilePic),
        ),
        title: Text(name),
      ),
    );
  }
}
