import 'package:flutter/material.dart';

class TyreTypes extends StatefulWidget {
  TyreTypes({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "type": "Off-Road",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "2",
      "type": "4x4 tyres",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "3",
      "type": "Summer Types",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "4",
      "type": "Winter Types",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "5",
      "type": "Run-flat tyres",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "6",
      "type": "All-season tyres",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "7",
      "type": "Van Tyres",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    }
  ];

  @override
  _TyreTypesState createState() => _TyreTypesState();
}

class _TyreTypesState extends State<TyreTypes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Tyre Types',
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
                  buildCarCard(widget.carItems[index]['type'],
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
                textAlign: TextAlign.center,
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
