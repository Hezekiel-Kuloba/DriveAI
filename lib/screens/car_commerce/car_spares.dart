import 'package:flutter/material.dart';

class SparesHorizontalList extends StatefulWidget {
  SparesHorizontalList({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "BMW Engine",
      "brand": "Mercedes-Benz",
      "price": 65000,
      "mileage": 12000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 255,
      "color": "Black",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168128/engine_n8tg6o.png"
    },
    {
      "id": "2",
      "name": "3X Wheel",
      "brand": "BMW",
      "price": 70000,
      "mileage": 10000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 335,
      "color": "White",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "3",
      "name": "Steering",
      "brand": "Audi",
      "price": 75000,
      "mileage": 8000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 335,
      "color": "Gray",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168134/steering_vtxul1.png"
    },
    {
      "id": "4",
      "name": "Tesla Engine",
      "brand": "Tesla",
      "price": 90000,
      "mileage": 5000,
      "fuel_type": "Electric",
      "transmission": "Automatic",
      "horsepower": 670,
      "color": "Red",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168128/engine_n8tg6o.png"
    },
    {
      "id": "5",
      "name": "Engine",
      "brand": "Porsche",
      "price": 85000,
      "mileage": 7000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 541,
      "color": "Blue",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168128/engine_n8tg6o.png"
    },
    {
      "id": "6",
      "name": "Steering",
      "brand": "Land Rover",
      "price": 82000,
      "mileage": 6000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 395,
      "color": "Green",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168134/steering_vtxul1.png"
    },
    {
      "id": "7",
      "name": "Wheel",
      "brand": "Lexus",
      "price": 62000,
      "mileage": 9000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 275,
      "color": "Silver",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    }
  ];

  @override
  _SparesHorizontalListState createState() => _SparesHorizontalListState();
}

class _SparesHorizontalListState extends State<SparesHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Spare Parts',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180, // Set height for the list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.carItems.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  buildCarCard(
                      widget.carItems[index]['name'],
                      widget.carItems[index]['price'],
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
  Widget buildCarCard(String carName, int price, String imageUrl) {
    return SizedBox(
      width: 150, // Fixed width for each card
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 180.0, // Fixed height for cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text(
                '\KSH$price',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
