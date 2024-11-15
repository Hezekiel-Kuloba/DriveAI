import 'package:flutter/material.dart';
import 'package:new_car_app/screens/fuel/fuel_add.dart';
import 'package:new_car_app/screens/fuel/fuel_expenditure.dart';
import 'package:new_car_app/screens/fuel/fuel_near_me.dart';
import 'package:new_car_app/screens/fuel/fuel_prices.dart';
import 'package:intl/intl.dart'; // For price formatting

class FuelServiceScreen extends StatefulWidget {
  const FuelServiceScreen({super.key});

  @override
  _FuelServiceScreenState createState() => _FuelServiceScreenState();
}

class _FuelServiceScreenState extends State<FuelServiceScreen> {
  final List<Map<String, dynamic>> services = [
    {}, // First card will be empty with a large plus icon
    {
      "id": 1,
      "fuel": "Automark Fuel",
      "location": "Nairobi, Kenya",
      "services": [
        {"name": "Oil Change", "price": "2500"},
        {"name": "Tire Replacement", "price": "5000"}
      ]
    },
    {
      "id": 2,
      "fuel": "QuickFix Fuel",
      "location": "Mombasa, Kenya",
      "services": [
        {"name": "Brake Inspection", "price": "1500"},
        {"name": "Engine Diagnostics", "price": "3000"}
      ]
    },
  ];

  final List<Map<String, dynamic>> fuelServices = [
    {"name": "Oil Change", "price": 2500, "checked": false},
    {"name": "Tire Replacement", "price": 5000, "checked": false},
    {"name": "Brake Inspection", "price": 1500, "checked": false},
    {"name": "Oil Change", "price": 2500, "checked": false},
    {"name": "Tire Replacement", "price": 5000, "checked": false},
    {"name": "Brake Inspection", "price": 1500, "checked": false},
  ];

  bool _isChecked = false; // Initial checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Services'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: services.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final service = services[index];
                          if (service.isEmpty) {
                            return _buildAddServiceCard();
                          } else {
                            return _buildServiceCard(service);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Fuels Near Me section, no need for Expanded here
            FuelPriceSlider(),
            fuelExpenditureSlider(),
            SizedBox(
              height: 600, // Set a fixed height for visibility
              child: FuelStationsNearMe(),
            ),
            // Fuel Services List

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: List.generate(fuelServices.length, (index) {
                  final service = fuelServices[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      leading: Checkbox(
                        value: service['checked'], // Dynamic checkbox value
                        onChanged: (bool? newValue) {
                          setState(() {
                            service['checked'] = newValue ??
                                false; // Update individual checkbox state
                          });
                        },
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'],
                            maxLines: 2, // Limit the service name to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatPrice(service['price']),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format the price
  String _formatPrice(int price) {
    final formatter = NumberFormat.currency(symbol: "Ksh", decimalDigits: 0);
    return formatter.format(price);
  }

  // Card with a large plus icon for adding a new service
  Widget _buildAddServiceCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: SizedBox(
        width: 140,
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.add, size: 50, color: Colors.grey),
            onPressed: () {
              // Navigate to FuelAddScreen when the plus icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FuelStationRegistration()),
              );
            },
          ),
        ),
      ),
    );
  }

  // Widget to build individual service cards
  Widget _buildServiceCard(Map<String, dynamic> service) {
    return GestureDetector(
      child: Card(
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
              Text(
                service['fuel'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                service['location'],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () => _editServiceDetail(service['id']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => _deleteServiceDetail(service['id']),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editServiceDetail(int id) {
    // Handle edit action
  }

  void _deleteServiceDetail(int id) {
    // Handle delete action
  }
}
