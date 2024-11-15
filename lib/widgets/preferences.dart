import 'package:flutter/material.dart';

class PreferencesSlider extends StatefulWidget {
  PreferencesSlider({super.key});

  final List<Map<String, String>> services = [
    {"mechanic": "Hezekiel Kuloba"},
    {"garage": "AutoMark Garage"},
    {"gas_station": "Total Petrol Station"},
    {"charging_station": "Shell EV Charging"},
  ];

  @override
  _PreferencesSliderState createState() => _PreferencesSliderState();
}

class _PreferencesSliderState extends State<PreferencesSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Preferences',
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
              String serviceType = widget.services[index].keys.first;
              String serviceName = widget.services[index].values.first;
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: buildServiceCard(serviceType, serviceName),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single service card with an edit button
  Widget buildServiceCard(String serviceType, String serviceName) {
    IconData icon;
    String label;

    switch (serviceType) {
      case 'mechanic':
        icon = Icons.build;
        label = "Main Mechanic";
        break;
      case 'garage':
        icon = Icons.garage;
        label = "Main Garage";
        break;
      case 'gas_station':
        icon = Icons.local_gas_station;
        label = "Main Petrol Station";
        break;
      case 'charging_station':
        icon = Icons.electric_car;
        label = "Main Charging";
        break;
      default:
        icon = Icons.help_outline;
        label = "Main Service";
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3, // Slight elevation for a more professional look
      child: Container(
        width: 140, // Adjust the width of each card
        padding: const EdgeInsets.all(16.0),
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
                  _showEditDialog(context, serviceType, serviceName);
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
                      (service) => service.values.first == currentName);
                  if (index != -1) {
                    widget.services[index] = {
                      widget.services[index].keys.first: _controller.text
                    };
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
