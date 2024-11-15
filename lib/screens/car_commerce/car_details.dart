import 'package:flutter/material.dart';

class CarDetailScreen extends StatelessWidget {
  final Map<String, dynamic> car = {
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
        "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car['name']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Swipeable image carousel
          Expanded(
            child: PageView(
              children: [
                Image.network(
                  car['image'],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                // Additional car images could be added here
                Image.network(
                  car['image'],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          // Price and Buy section with sticky action bar
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car name and brand
                    Text(
                      car['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Brand: ${car['brand']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Price
                    Text(
                      '\$${car['price']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    // Car availability status (could be dynamic)
                    const Text(
                      'In stock',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Divider
                    const Divider(),
                    // Car details section
                    buildCarDetailRow('Mileage', '${car['mileage']} miles'),
                    buildCarDetailRow('Fuel Type', car['fuel_type']),
                    buildCarDetailRow('Transmission', car['transmission']),
                    buildCarDetailRow('Horsepower', '${car['horsepower']} HP'),
                    buildCarDetailRow('Color', car['color']),
                    buildCarDetailRow('Year', '${car['year']}'),
                    const Divider(),
                    const SizedBox(height: 8),
                    // Section for other details like features, reviews, or related products
                    const Text(
                      'Car Features',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text('Feature 1: Example of a feature...'),
                    const Text('Feature 2: Example of another feature...'),
                  ],
                ),
              ),
            ),
          ),
          // Sticky Contact Seller and Buy button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Black background
                      padding: const EdgeInsets.all(15.0),
                    ),
                    onPressed: () {
                      // Implement Buy functionality
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Purchase Car'),
                          content: const Text(
                              'Are you sure you want to purchase this car?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Buy'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // White text
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      side:
                          const BorderSide(color: Colors.black), // Black border
                      padding: const EdgeInsets.all(15.0),
                    ),
                    onPressed: () {
                      // Implement contact functionality
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Contact Seller'),
                          content: const Text(
                              'Would you like to contact the seller?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Contact'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Contact Seller',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Black text
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
