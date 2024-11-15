import 'package:flutter/material.dart';

class DriverNecessities extends StatefulWidget {
  DriverNecessities({super.key});

  final List<Map<String, String>> services = [
    {"mileage": "100 Km"},
    {"Next Service Date": "1 Jan 2024"},
    {"Daily Fuel Expenditure": "10,000 Ksh"},
    // Uncomment and add more services as needed
    // {"charging_station": "Shell EV Charging"},
  ];

  @override
  _DriverNecessitiesState createState() => _DriverNecessitiesState();
}

class _DriverNecessitiesState extends State<DriverNecessities> {
  // Mapping service types to icons
  final Map<String, IconData> _iconMap = {
    "mileage": Icons.speed,
    "Next Service Date": Icons.calendar_today,
    "Daily Fuel Expenditure": Icons.local_gas_station,
    // Add more mappings as needed
    // "charging_station": Icons.ev_station,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Driver Necessities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 180, // Set a fixed height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              String serviceType =
                  widget.services[index].keys.first; // Get the key
              String serviceName =
                  widget.services[index].values.first; // Get the value
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: buildServiceCard(
                  _iconMap[serviceType]!, // Get the corresponding icon
                  serviceType,
                  serviceName,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildServiceCard(IconData icon, String label, String serviceName) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3, // Slight elevation for a more professional look
      child: Container(
        width: 140, // Adjust the width of each card
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 36),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              serviceName,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  _showEditDialog(context, label, serviceName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Shows a dialog for editing service details
  void _showEditDialog(
      BuildContext context, String serviceType, String currentName) {
    final TextEditingController _controller =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $serviceType'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter new name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  // Update the service name
                  final index = widget.services.indexWhere(
                      (service) => service[serviceType] == currentName);
                  if (index != -1) {
                    widget.services[index][serviceType] = _controller.text;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
