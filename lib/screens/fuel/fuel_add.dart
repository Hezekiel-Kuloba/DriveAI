import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FuelStationRegistration extends StatefulWidget {
  const FuelStationRegistration({super.key});

  @override
  _FuelStationRegistrationState createState() =>
      _FuelStationRegistrationState();
}

class _FuelStationRegistrationState extends State<FuelStationRegistration> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;

  String? region;
  String? area;
  String? services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Petrol Station'),
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
                  decoration:
                      _inputDecoration('Petrol Station Name', Icons.person),
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: _inputDecoration('Region', Icons.location_city),
                  onChanged: (value) {
                    region = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the region';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: _inputDecoration('Area', Icons.map),
                  onChanged: (value) {
                    area = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the area';
                    }
                    return null;
                  },
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
                      return 'Notes';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
