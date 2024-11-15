import 'package:flutter/material.dart';
import 'package:new_car_app/screens/my_car/add_car.dart';

class CarListScreen extends StatelessWidget {
  final List<Map<String, String>> carList = [
    {
      "name": "Mercedes",
      "model": "2024 Mercedes-Benz GLE-Class SUV",
      "trim_level": "GLE 350 4MATIC",
      "plate_number": "ABC-1234",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    },
    {
      "name": "BMW",
      "model": "2024 BMW X5",
      "trim_level": "xDrive40i",
      "plate_number": "XYZ-9876",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719553/iris3_cbjjxp.png"
    },
    {
      "name": "Audi",
      "model": "2024 Audi Q7",
      "trim_level": "Premium Plus 55 TFSI",
      "plate_number": "LMN-4567",
      "image":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png"
    }
  ];

  CarListScreen({super.key});

  // Method to show delete confirmation dialog
  void _showDeleteDialog(BuildContext context, String carName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Car'),
          content: Text('Are you sure you want to delete $carName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform deletion logic here
                Navigator.of(context).pop();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car List'),
      ),
      body: ListView.builder(
        itemCount: carList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      carList[index]['image']!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Car name and delete button in a row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        carList[index]['name']!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteDialog(context, carList[index]['name']!);
                        },
                      ),
                    ],
                  ),

                  // Model, trim, plate number rows with icons
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.directions_car, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          carList[index]['model']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.settings, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        carList[index]['trim_level']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.confirmation_number, color: Colors.grey),
                      const SizedBox(width: 10),
                      Text(
                        'Plate Number: ${carList[index]['plate_number']!}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Floating action button to add a new car
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Car page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCarScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Placeholder for AddCarScreen
