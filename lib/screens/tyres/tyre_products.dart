import 'package:flutter/material.dart';
import 'package:new_car_app/screens/car_commerce/car_details.dart';

class CarGridScreen extends StatelessWidget {
  CarGridScreen({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "michellin",
      "price": 65000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "2",
      "name": "michellin",
      "price": 70000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "3",
      "name": "michellin",
      "price": 75000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "4",
      "name": "BridgeStone",
      "price": 90000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "5",
      "name": "BridgeStone",
      "price": 85000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "6",
      "name": "BridgeStone",
      "price": 82000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    },
    {
      "id": "7",
      "name": "michellin",
      "price": 62000,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Text
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Text(
            'Store',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8,
          ),
          itemCount: carItems.length,
          itemBuilder: (context, index) {
            final car = carItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarDetailScreen(),
                  ),
                );
              },
              child: SizedBox(
                height: 150, // Set fixed height here
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center horizontally
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.network(
                            car['image'],
                            height: 70,
                            width: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          car['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign:
                              TextAlign.center, // Center text within its bounds
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '\KSH ${car['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign:
                              TextAlign.center, // Center text within its bounds
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
