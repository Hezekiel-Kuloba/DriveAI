import 'package:flutter/material.dart';
import 'package:new_car_app/screens/car_commerce/car_details.dart';

class CarGridScreen extends StatelessWidget {
  CarGridScreen({super.key});

  final List<Map<String, dynamic>> carItems = [
    {
      "id": "1",
      "name": "2024 Mercedes-Benz GLE 350 4MATIC",
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
      "name": "2024 BMW X5 xDrive40i",
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
      "name": "2024 Audi Q7 Premium Plus 55 TFSI",
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
      "name": "2024 Tesla Model X Long Range",
      "brand": "Tesla",
      "price": 90000,
      "mileage": 5000,
      "fuel_type": "Electric",
      "transmission": "Automatic",
      "horsepower": 670,
      "color": "Red",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    },
    {
      "id": "5",
      "name": "2024 Porsche Cayenne Turbo",
      "brand": "Porsche",
      "price": 85000,
      "mileage": 7000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 541,
      "color": "Blue",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    },
    {
      "id": "6",
      "name": "2024 Range Rover Sport P400 SE",
      "brand": "Land Rover",
      "price": 82000,
      "mileage": 6000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 395,
      "color": "Green",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    },
    {
      "id": "7",
      "name": "2024 Lexus RX 350 F SPORT",
      "brand": "Lexus",
      "price": 62000,
      "mileage": 9000,
      "fuel_type": "Gasoline",
      "transmission": "Automatic",
      "horsepower": 275,
      "color": "Silver",
      "year": 2024,
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
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
            'Showroom',
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
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.network(
                            car['image'],
                            height: 100,
                            width: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        car['name'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '\KSH ${car['price']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
