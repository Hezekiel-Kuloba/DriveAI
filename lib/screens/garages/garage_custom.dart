import 'package:flutter/material.dart';
import 'package:new_car_app/screens/garages/garage_list.dart';

class GarageCustomHorizontalList extends StatefulWidget {
  GarageCustomHorizontalList({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "Mercedes",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729583478/mercedesLogo_gkrb5c.png"
    },
    {
      "id": "2",
      "name": "BMW",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729583477/bmwLogo_r54ro7.png"
    },
    {
      "id": "3",
      "name": "Audi",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729583475/toyotaLogo_m7cko9.png"
    },
  ];

  @override
  _GarageCustomHorizontalListState createState() =>
      _GarageCustomHorizontalListState();
}

class _GarageCustomHorizontalListState
    extends State<GarageCustomHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Brand Garages',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SizedBox(
        //   height: 130, // Set height for the list
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //     itemCount: widget.carItems.length,
        //     itemBuilder: (context, index) {
        //       return Row(
        //         children: [
        //           buildCarCard(widget.carItems[index]['name'],
        //               widget.carItems[index]['image']),
        //           const SizedBox(width: 8), // Space between cards
        //         ],
        //       );
        //     },
        //   ),
        // ),

        SizedBox(
          height: 130, // Set height for the list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.carItems.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to GarageListScreen on tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GarageListScreen(isPage: true
                              // carBrand: widget.carItems[index]['name'], // Pass the car brand
                              ),
                        ),
                      );
                    },
                    child: buildCarCard(widget.carItems[index]['name'],
                        widget.carItems[index]['image']),
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

  // Widget for displaying a single car card
  Widget buildCarCard(String carName, String imageUrl) {
    return SizedBox(
      width: 120, // Fixed width for each card
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 130.0, // Fixed height for cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                child: Image.network(
                  imageUrl,
                  height: 50,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
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
