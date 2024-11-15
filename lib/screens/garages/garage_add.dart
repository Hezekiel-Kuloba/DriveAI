import 'dart:io';

import 'package:flutter/material.dart';

class GarageRegistration extends StatefulWidget {
  const GarageRegistration({super.key});

  @override
  _GarageRegistrationState createState() => _GarageRegistrationState();
}

class _GarageRegistrationState extends State<GarageRegistration> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? phoneNumber;
  String? region;
  String? area;
  String? services;

  List<String> availableAreas = [];

  final List<Map<String, dynamic>> regions = [
    {
      "region": "Nairobi",
      "areas": ["Westlands", "Kilimani", "Langata"]
    },
    {
      "region": "Mombasa",
      "areas": ["Nyali", "Likoni", "Kizingo"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Garage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: _inputDecoration('Garage Name', Icons.person),
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the garage name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: _inputDecoration('Phone Number', Icons.phone),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Dropdown for Region
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Region', Icons.location_city),
                  items: regions.map((regionData) {
                    return DropdownMenuItem<String>(
                      value: regionData['region'],
                      child: Text(regionData['region']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      region = value;
                      // Update areas based on the selected region
                      availableAreas = regions.firstWhere(
                          (element) => element['region'] == value)['areas'];
                      area = null; // Reset selected area
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a region';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Dropdown for Area
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Area', Icons.map),
                  items: availableAreas.map((area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      area = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an area';
                    }
                    return null;
                  },
                  // Disable dropdown if no region is selected
                  isExpanded: true,
                  disabledHint: const Text('Select a region first'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: _inputDecoration('Services', Icons.build),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (value) {
                    services = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the services';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle form submission
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(double.infinity, 60), // Increased height
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      icon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
    );
  }
}
