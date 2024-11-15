import 'package:flutter/material.dart';

class MechanicProfileScreen extends StatelessWidget {
  // Dummy mechanic JSON data
  final Map<String, dynamic> mechanic = {
    "id": "1",
    "name": "John Doe",
    "location": "123 Main St, Cityville",
    "rating": 4.5,
    "services": [
      {"name": "Engine Repair", "price": "\$120"},
      {"name": "Tire Replacement", "price": "\$70"},
      {"name": "Oil Change", "price": "\$40"},
      {"name": "Battery Replacement", "price": "\$100"},
      {"name": "Transmission Repair", "price": "\$200"}
    ],
    "profile_picture":
        "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725801467/mechanic_rxr9xu.jpg",
    "contact": {"phone": "+123456789", "email": "johndoe@mechanic.com"}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mechanic['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(mechanic['profile_picture']),
                radius: 60,
              ),
              const SizedBox(height: 20),
              Text(
                mechanic['name'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                mechanic['location'],
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              // Rating Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < mechanic['rating'].toInt()
                        ? Icons.star
                        : Icons.star_half,
                    color: Colors.yellow,
                  );
                }),
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
                itemCount: mechanic['services'].length,
                itemBuilder: (context, index) {
                  final service = mechanic['services'][index];
                  IconData icon;

                  // Assigning unique icons based on service names
                  switch (service['name']) {
                    case 'Engine Repair':
                      icon = Icons.settings_input_component;
                      break;
                    case 'Tire Replacement':
                      icon = Icons.tire_repair;
                      break;
                    case 'Oil Change':
                      icon = Icons.local_gas_station;
                      break;
                    case 'Battery Replacement':
                      icon = Icons.battery_charging_full;
                      break;
                    case 'Transmission Repair':
                      icon = Icons.settings_input_component;
                      break;
                    default:
                      icon = Icons.build;
                  }

                  return Card(
                    elevation: 5,
                    child: Stack(
                      children: [
                        // Icon in the top-left corner
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Icon(
                            icon,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        // Service details
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, top: 10, right: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                service['price'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Contact Mechanic
              ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: const Text('Contact Mechanic'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactMechanicScreen(mechanic: mechanic),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.phone),
        tooltip: 'Call Mechanic',
      ),
    );
  }
}

// Contact Mechanic Screen
class ContactMechanicScreen extends StatelessWidget {
  final Map<String, dynamic> mechanic;

  const ContactMechanicScreen({required this.mechanic, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact ${mechanic['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone: ${mechanic['contact']['phone']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${mechanic['contact']['email']}',
              style: const TextStyle(fontSize: 18),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text('Call Now'),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MechanicProfileScreen(),
  ));
}
