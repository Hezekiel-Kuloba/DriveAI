import 'package:flutter/material.dart';

class TopAccountsList extends StatefulWidget {
  TopAccountsList({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "Toyota",
      "brand": "Mercedes-Benz",
      "price": 65000,
      "mileage": 12000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 255,
      "color": "Black",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    },
    {
      "id": "2",
      "name": "Mercedes",
      "brand": "BMW",
      "price": 70000,
      "mileage": 10000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 335,
      "color": "White",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719553/iris3_cbjjxp.png"
    },
    {
      "id": "3",
      "name": "BMW",
      "brand": "Audi",
      "price": 75000,
      "mileage": 8000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 335,
      "color": "Gray",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    },
    {
      "id": "4",
      "name": "Tesla",
      "brand": "Tesla",
      "price": 90000,
      "mileage": 5000,
      "fuel_type": "Electric",
      "transmission": "Automatic",
      "horsepower": 670,
      "color": "Red",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": "5",
      "name": "Porsche",
      "brand": "Porsche",
      "price": 85000,
      "mileage": 7000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 541,
      "color": "Blue",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": "6",
      "name": "Land Rover",
      "brand": "Land Rover",
      "price": 82000,
      "mileage": 6000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 395,
      "color": "Green",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    },
    {
      "id": "7",
      "name": "Lexus",
      "brand": "Lexus",
      "price": 62000,
      "mileage": 9000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 275,
      "color": "Silver",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg"
    }
  ];

  @override
  _TopAccountsListState createState() => _TopAccountsListState();
}

class _TopAccountsListState extends State<TopAccountsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Top Accounts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150, // Set height for the list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: widget.carItems.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCarCard(
                      widget.carItems[index]['name'],
                      // widget.carItems[index]['price'],
                      widget.carItems[index]['image']),
                  const SizedBox(width: 8), // Space between cards
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single car card
  Widget buildCarCard(String carName, String imageUrl) {
    return SizedBox(
      width: 150, // Fixed width for each card
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 180.0, // Fixed height for cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                child: Image.network(
                  imageUrl,
                  height: 70,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                carName,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
