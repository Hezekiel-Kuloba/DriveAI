import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GarageProfileScreen extends StatelessWidget {
  // Dummy garage JSON data with contact information added
  final Map<String, dynamic> garage = {
    "id": 1,
    "name": "AutoFix Garage",
    "image":
        "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
    "rating": 4.8,
    "region": "Nairobi",
    "location": "Upperhill",
    "phone": "+254712345678",
    "email": "info@autofixgarage.com",
    "services": [
      {"name": "Oil Change", "price": "\$40"},
      {"name": "Tire Replacement", "price": "\$70"},
      {"name": "Brake Repair", "price": "\$90"},
      {"name": "Transmission Repair", "price": "\$200"},
      {"name": "Battery Replacement", "price": "\$100"},
      {"name": "Suspension Check", "price": "\$60"},
      {"name": "AC Repair", "price": "\$80"},
      {"name": "Engine Diagnostics", "price": "\$50"},
      {"name": "Tire Alignment", "price": "\$55"},
      {"name": "Car Wash", "price": "\$20"}
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(garage['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_pin),
            onPressed: () {
              // Add location functionality
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Book Appointment Functionality
        },
        label: const Text('Book Appointment'),
        icon: const Icon(Icons.calendar_today),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image slider
              CarouselSlider(
                options: CarouselOptions(
                  height: 150, // Reduce the size of the image container
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: Duration(seconds: 3),
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    // Handle page change if needed
                  },
                ),
                items: [
                  garage['image'],
                  "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
                  "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(40), // Border radius
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            i,
                            fit: BoxFit
                                .contain, // Image fits within the container
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),

              // Garage Name and Rating
              Text(
                garage['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${garage['rating']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Garage Location,
              Text(
                '${garage['location']}, ${garage['region']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Important Contact Information
              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 10),
                  Text(garage['phone'], style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 10),
                  Text(garage['email'], style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 20),

              // Services Offered
              const Text(
                'Services Offered',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: garage['services'].length,
                itemBuilder: (context, index) {
                  final service = garage['services'][index];
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            service['price'],
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
