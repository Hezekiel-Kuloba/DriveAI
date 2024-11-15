import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/models/car.dart';
import 'package:new_car_app/utilis/car.dart';
import 'package:new_car_app/utilis/service.dart';
import 'package:new_car_app/utilis/user.dart';

class AddServiceScreen extends ConsumerStatefulWidget {
  const AddServiceScreen({super.key});

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends ConsumerState<AddServiceScreen> {
  String? item;
  String? description;
  String? status;
  int? date;
  final TextEditingController itemController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Service Item Field
              TextFormField(
                controller: itemController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.build),
                  labelText: 'Service Item',
                  helperText: 'Enter the service item name',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (value) => item = value,
              ),
              const SizedBox(height: 20.0),

              // Service Description Field
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'Description',
                  helperText: 'Enter a brief description of the service',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (value) => description = value,
              ),
              const SizedBox(height: 20.0),

              // Service Date Field
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Service Date',
                  helperText: 'Enter the service date (YYYYMMDD)',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  date = int.tryParse(value);
                },
              ),
              const SizedBox(height: 40.0), // Space before button

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56, // Match input field height
                child: ElevatedButton(
                  onPressed: () async {
                    final token = ref.watch(userProvider)?.token;
                    final userId = ref.watch(userProvider)?.user?.id;

                    if (token != null && userId != null) {
                      await ref.read(serviceProvider.notifier).addUserService(
                            date: date!,
                            time: 123,
                            item: item!,
                            description: description!,
                            token: token,
                            userId: userId,
                            status: 'pending',
                          );

                      // Show confirmation modal
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content:
                                Text('Service has been added successfully.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .pushReplacementNamed('/');
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('No user token or user ID found!')),
                      );
                    }
                  },
                  child: Text('Add Service Notification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
