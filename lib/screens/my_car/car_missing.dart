import 'package:flutter/material.dart';

class ReportMissingCarScreen extends StatefulWidget {
  const ReportMissingCarScreen({super.key});

  @override
  _ReportMissingCarScreenState createState() => _ReportMissingCarScreenState();
}

class _ReportMissingCarScreenState extends State<ReportMissingCarScreen> {
  final _formKey = GlobalKey<FormState>();
  String? manufacturer;
  String? model;
  String? trim;
  String? year;
  String? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Missing Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: _inputDecoration('Manufacturer', Icons.factory),
                onChanged: (value) {
                  manufacturer = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the manufacturer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Model', Icons.model_training),
                onChanged: (value) {
                  model = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Trim', Icons.dashboard),
                onChanged: (value) {
                  trim = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the trim';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Year', Icons.date_range),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  year = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Color', Icons.color_lens),
                onChanged: (value) {
                  color = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the color';
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
                  minimumSize: Size(double.infinity, 60), // Increased height
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
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
