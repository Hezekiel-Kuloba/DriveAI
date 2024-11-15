import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MechanicRegistrationScreen extends StatefulWidget {
  const MechanicRegistrationScreen({super.key});

  @override
  _MechanicRegistrationScreenState createState() =>
      _MechanicRegistrationScreenState();
}

class _MechanicRegistrationScreenState
    extends State<MechanicRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? phoneNumber;
  String? selectedRegion;
  String? selectedArea;
  XFile? _profileImage;

  List<String> services = [""];
  final ImagePicker _picker = ImagePicker();

  // JSON data for regions and areas
  final Map<String, List<String>> regionData = {
    'Region 1': ['Area 1-1', 'Area 1-2', 'Area 1-3'],
    'Region 2': ['Area 2-1', 'Area 2-2', 'Area 2-3'],
    'Region 3': ['Area 3-1', 'Area 3-2', 'Area 3-3'],
  };

  Future<void> _pickProfileImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedImage;
    });
  }

  void _addServiceInput() {
    setState(() {
      services.add('');
    });
  }

  void _removeServiceInput(int index) {
    setState(() {
      services.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mechanic'),
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
                  decoration: _inputDecoration('Full Name', Icons.person),
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
                  decoration: _inputDecoration('Email', Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
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

                // Region Dropdown
                DropdownButtonFormField<String>(
                  value: selectedRegion,
                  decoration:
                      _inputDecoration('Select Region', Icons.location_city),
                  items: regionData.keys.map((region) {
                    return DropdownMenuItem<String>(
                      value: region,
                      child: Text(region),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value;
                      selectedArea = null; // Reset the area when region changes
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a region';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Area Dropdown
                if (selectedRegion != null)
                  DropdownButtonFormField<String>(
                    value: selectedArea,
                    decoration: _inputDecoration('Select Area', Icons.map),
                    items: regionData[selectedRegion]!.map((area) {
                      return DropdownMenuItem<String>(
                        value: area,
                        child: Text(area),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedArea = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an area';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 16),

                // Dynamic Services Inputs
                const Text("Services", style: TextStyle(fontSize: 16)),
                ..._buildServiceInputs(),
                TextButton.icon(
                  onPressed: _addServiceInput,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Service'),
                ),

                const SizedBox(height: 16),
                _profileImage == null
                    ? ElevatedButton.icon(
                        onPressed: _pickProfileImage,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Upload Profile Picture'),
                      )
                    : Column(
                        children: [
                          Image.file(
                            File(_profileImage!.path),
                            height: 150,
                          ),
                          ElevatedButton.icon(
                            onPressed: _pickProfileImage,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Change Profile Picture'),
                          ),
                        ],
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

  // Service Inputs
  List<Widget> _buildServiceInputs() {
    return List.generate(services.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration:
                    _inputDecoration('Service ${index + 1}', Icons.build),
                onChanged: (value) {
                  services[index] = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a service';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              onPressed: () {
                _removeServiceInput(index);
              },
              icon: const Icon(Icons.remove_circle, color: Colors.red),
            ),
          ],
        ),
      );
    });
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
