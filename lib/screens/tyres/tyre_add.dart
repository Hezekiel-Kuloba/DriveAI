import 'package:flutter/material.dart';

class TireRegistration extends StatefulWidget {
  const TireRegistration({super.key});

  @override
  _TireRegistrationState createState() => _TireRegistrationState();
}

class _TireRegistrationState extends State<TireRegistration> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? tireName;
  String? selectedSize;
  String? selectedType;
  String? selectedLoadIndex;
  String? price;

  // Dummy predefined values for dropdowns
  final List<String> tireSizes = ["225/45 R17", "205/55 R16", "245/40 R18"];
  final List<String> tireTypes = [
    "All-season",
    "Summer",
    "Winter",
    "Performance",
    "Off-road"
  ];
  final List<String> loadIndexes = ["91", "94", "98"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Tire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tire Name Input (Text Field)
                TextFormField(
                  decoration: _inputDecoration('Tire Name', Icons.person),
                  onChanged: (value) {
                    tireName = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the tire name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tire Size Dropdown (Predefined options)
                DropdownButtonFormField<String>(
                  decoration:
                      _inputDecoration('Tire Size', Icons.directions_car),
                  value: selectedSize,
                  items: tireSizes.map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: Text(size),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a tire size';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tire Type Dropdown (Predefined options)
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Tire Type', Icons.build),
                  value: selectedType,
                  items: tireTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a tire type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Load Index Dropdown (Predefined options)
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Load Index', Icons.speed),
                  value: selectedLoadIndex,
                  items: loadIndexes.map((index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(index),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLoadIndex = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a load index';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tire Price Input (Text Field)
                TextFormField(
                  decoration: _inputDecoration('Price', Icons.attach_money),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
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
