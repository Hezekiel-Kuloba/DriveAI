import 'package:flutter/material.dart';
import 'package:new_car_app/screens/authentication/login.dart';
import 'package:new_car_app/screens/car_commerce/ecommerce_dashboard.dart';
import 'package:new_car_app/screens/dashboards/community.dart';
import 'package:new_car_app/screens/dashboards/dashboard.dart';
import 'package:new_car_app/screens/traffic_jam/traffic_jam.dart';
import 'package:new_car_app/screens/navigation/nav.dart';
import 'package:new_car_app/screens/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motor Wise',
      theme: AppThemes.lightTheme, // Light theme by default
      darkTheme: AppThemes.darkTheme, // Dark theme
      themeMode: ThemeMode.system, // Switch based on system settings
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/community': (context) => Community(),
        '/news': (context) => NewsScreen(),
        '/events': (context) => EventsScreen(),
        '/top_accounts': (context) => TopAccountsScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Dashboard(),
    EcommerceDashboard(),
    TrafficScreen(),
    CarAppNavigationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "Community" Tab with Active State and Navigation
              _buildTabButton(context, 'For You', 0, '/'),
              _buildTabButton(context, 'Community', 1, '/community'),
              // Notification Icon
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notification action
                },
              ),
              // Sign In Button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 24),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.traffic, size: 24),
            label: 'Traffic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android, size: 24),
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more, size: 24),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildTabButton(
      BuildContext context, String title, int index, String route) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: _selectedIndex == index ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:new_car_app/screens/my_car/add_car.dart';

class CarDetailsSlider extends StatefulWidget {
  CarDetailsSlider({super.key});

  final Map<String, dynamic> carDetails = {
    "name": "Mercedes-Benz",
    "model": "2024 Mercedes-Benz GLE-Class SUV",
    "trim": "GLE 350 4MATIC",
    "engine": "2.0L Inline-4 Turbocharged",
    "power": "255 hp",
    "torque": "295 lb-ft",
    "transmission": "9-Speed Automatic",
    "drivetrain": "4MATIC All-Wheel Drive",
    "acceleration": "0-60 mph in 7.0 seconds",
    "fuel_consumption": "8.1 km/L city, 11.1 km/L highway",
    "images": [
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    ]
  };

  @override
  _CarDetailsSliderState createState() => _CarDetailsSliderState();
}

class _CarDetailsSliderState extends State<CarDetailsSlider> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> featureItems = [
      buildImageCard(), // First slide with the car image
      buildFeatureCard(0), // First 2 feature cards
      buildFeatureCard(2), // Next 2 feature cards
      buildFeatureCard(4), // Next 2 feature cards
      buildFeatureCard(6), // Next 2 feature cards
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Vehicles',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCarScreen(),
                  ),
                ),
                child: Row(
                  children: const [
                    // Text(
                    //   'Change',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(width: 4),
                    Icon(Icons.edit, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: featureItems,
          ),
        ),
      ],
    );
  }

  // Widget for displaying the car image inside a card
  Widget buildImageCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 300.0, // Set a fixed width for the image card
          height: 150.0, // Fixed height for the image card
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.carDetails['images'][0],
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  // Builds a row of feature cards
  Widget buildFeatureCard(int startIndex) {
    List<Widget> features = [];

    // Add two feature cards side by side
    features.add(buildFeatureCardItem(
      Icons.directions_car,
      widget.carDetails.keys.elementAt(startIndex),
      widget.carDetails.values.elementAt(startIndex),
    ));
    if (startIndex + 1 < widget.carDetails.length) {
      features.add(buildFeatureCardItem(
        Icons.flash_on,
        widget.carDetails.keys.elementAt(startIndex + 1),
        widget.carDetails.values.elementAt(startIndex + 1),
      ));
    }

    return Row(children: features);
  }

  // Widget for displaying a single feature card
  Widget buildFeatureCardItem(IconData icon, String feature, String value,
      {double fontSize = 16, double iconSize = 30}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: 150.0, // Fixed width for feature cards
          height: 150.0, // Fixed height for feature cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: iconSize),
              const SizedBox(height: 8),
              Text(
                feature,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final List<Map<String, dynamic>> serviceDetails = [
    {
      "serviceDate": "2024-10-17",
      "id": 1,
    },
    {
      "serviceLocation": "Nairobi, Kenya",
      "id": 1,
    },
    {
      "serviceGarage": "AutoMark Service",
      "id": 2,
    },
    {
      "serviceMechanic": "Hezekiel Kuloba",
      "id": 3,
    },
  ];

  // JSON data for service checklist
  final List<Map<String, dynamic>> serviceChecklist = [
    {"name": "Oil Change", "done": false},
    {"name": "Gear Oil", "done": false},
    {"name": "Brake Fluid", "done": true},
    {"name": "Air Filter", "done": false},
  ];

  final Map<String, IconData> _iconMap = {
    "serviceDate": Icons.calendar_today,
    "serviceLocation": Icons.location_on,
    "serviceGarage": Icons.car_repair,
    "serviceMechanic": Icons.person,
    "timer": Icons.timer,
  };

  // New cards for Service AI and Service Notes
  final List<Map<String, dynamic>> additionalServiceOptions = [
    {
      "title": "Service AI",
      "icon": Icons.smart_toy,
    },
    {
      "title": "Service Notes",
      "icon": Icons.note_alt,
    },
  ];

// For future navigation
  void _navigateToServiceOption(String option) {
    // Placeholder function for navigation
    // e.g., Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreenAI()));
  }

  void _addServiceDate() {
    // Function to handle adding a new service date
  }

  void _editServiceDetail(int id) {
    // Function to handle editing service detail
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Service'),
        centerTitle: true, // This centers the title
      ),
      body: SingleChildScrollView(
        // Enclose everything inside a scrollable view
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer card
            _buildTimerCard(),
            const SizedBox(height: 16), // Spacing between timer card and list

            // Top title and Add button
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Service Details',
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Horizontal list of service cards
            SizedBox(
              height: 180, // Adjust height for the horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: serviceDetails.length,
                itemBuilder: (context, index) {
                  final service = serviceDetails[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: _buildServiceCard(service),
                  );
                },
              ),
            ),

            const SizedBox(height: 16), // Spacing between lists

            // SizedBox(
            //   height: 100, // Adjust the height as needed
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal, // Horizontal scrolling
            //     itemCount: additionalServiceOptions
            //         .length, // Length of the options list
            //     itemBuilder: (context, index) {
            //       final option = additionalServiceOptions[
            //           index]; // Get the option for the current index
            //       return Padding(
            //         padding: const EdgeInsets.only(
            //             right: 8.0), // Padding between cards
            //         child: _buildServiceOptionCard(
            //             option), // Build the service option card
            //       );
            //     },
            //   ),
            // ),

            const SizedBox(height: 16), // Spacing between lists

            // Service checklist title
            const Text(
              'Service Checklist',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Vertical list of service checklist items
            Column(
              children: serviceChecklist.map((item) {
                return _buildServiceChecklistItem(item);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerCard() {
    // Assuming we're showing the countdown for the first service date
    final DateTime currentDate = DateTime.now();
    final DateTime nextServiceDate = DateFormat('yyyy-MM-dd')
        .parse("2024-10-17"); // Use service date from JSON
    final int daysRemaining = nextServiceDate.difference(currentDate).inDays;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center the content
          children: [
            Icon(
              _iconMap['timer'], // Use mapped icon for timer
              size: 48, // Larger icon for better visibility
              color: Colors.red,
            ),
            const SizedBox(height: 12), // Increased spacing for better layout
            const Text(
              'Days Remaining to Service Date',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
            const SizedBox(height: 8),
            Text(
              '$daysRemaining days',
              style: const TextStyle(
                fontSize: 22, // Increase the font size for emphasis
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual service cards
  Widget _buildServiceCard(Map<String, dynamic> service) {
    String key = service.keys.first; // Get the first key from the map
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        width: 140, // Adjust card width
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _iconMap[key], // Use mapped icon for the service detail
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              key == 'serviceLocation'
                  ? 'Service Location'
                  : key == 'serviceGarage'
                      ? 'Service Garage'
                      : key == 'serviceDate'
                          ? 'Date To Service'
                          : 'Service Mechanic',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              service[key],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editServiceDetail(service['id']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build service checklist items
  Widget _buildServiceChecklistItem(Map<String, dynamic> item) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        leading: Checkbox(
          value: item['done'],
          onChanged: (bool? newValue) {
            setState(() {
              item['done'] = newValue!;
            });
          },
        ),
        title: Text(
          item['name'],
          style: TextStyle(
            fontSize: 16,
            decoration:
                item['done'] ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

// Widget to build individual Service AI and Service Notes cards
Widget _buildServiceOptionCard(Map<String, dynamic> option) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 3,
    child: InkWell(
      onTap: () => _navigateToServiceOption(option['title']),
      child: Container(
        height: 160, // Adjust card height if needed
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              option['icon'],
              size: 25,
              // color: Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              option['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void _navigateToServiceOption(String option) {
  // Placeholder function for navigation
  // e.g., Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreenAI()));
}


Widget _buildTimerCard(Service service) {
    final DateTime currentDate = DateTime.now();
    final DateTime serviceDate = DateTime.fromMillisecondsSinceEpoch(service.date!);
    final int daysRemaining = serviceDate.difference(currentDate).inDays;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(_iconMap['timer'], size: 48, color: Colors.red),
            const SizedBox(height: 12),
            const Text(
              'Days Remaining to Service Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$daysRemaining days',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
