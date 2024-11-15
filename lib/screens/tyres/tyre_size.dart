import 'package:flutter/material.dart';

class TyreSizeHorizontalScreen extends StatefulWidget {
  TyreSizeHorizontalScreen({super.key});
  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "155/65R13",
      "price": 65000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "2",
      "name": "155/65R13",
      "price": 70000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "3",
      "name": "155/65R13",
      "price": 75000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "4",
      "name": "155/65R13",
      "price": 90000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "5",
      "name": "155/65R13",
      "price": 85000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "6",
      "name": "155/65R13",
      "price": 82000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "7",
      "name": "155/65R13",
      "price": 62000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    }
  ];
  @override
  _TyreSizeHorizontalScreenState createState() =>
      _TyreSizeHorizontalScreenState();
}

class _TyreSizeHorizontalScreenState extends State<TyreSizeHorizontalScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Tyre Sizes',
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.carItems.length,
            itemBuilder: (context, index) {
              return Row(
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
          height: 150.0, // Fixed height for cards
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
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
