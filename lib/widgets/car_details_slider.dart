import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/constants/endpoints.dart';
import 'package:new_car_app/models/car.dart';
import 'package:new_car_app/screens/authentication/login.dart';
import 'package:new_car_app/screens/my_car/add_car.dart';
import 'package:new_car_app/utilis/car.dart';
import 'package:new_car_app/utilis/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';

class CarDetailsSlider extends ConsumerStatefulWidget {
  @override
  _CarDetailsSliderState createState() => _CarDetailsSliderState();
}

class _CarDetailsSliderState extends ConsumerState<CarDetailsSlider> {
  List<Entity> userCars = [];
  List<Entity> userVehicles = [];
  Map<int, String> carImages = {};
  bool _isFetching = false;
  bool _hasFetchedSuccessfully = false;

  @override
  void initState() {
    super.initState();
    if (!mounted || _hasFetchedSuccessfully) return;
    Future.delayed(Duration.zero, fetchUserCars);
  }

  Future<void> updateUserCars(int id,
      {int? newMileage, String? newFuelType}) async {
    final user = ref.watch(userProvider);
    final token = user!.token;

    try {
      final message = await ref.read(carProvider.notifier).updateGarageField(
            id: id,
            mileage: newMileage,
            fuelType: newFuelType,
            token: token!,
          );

      // Show success alert
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      ).then((_) {
        // Refresh the state after dialog is closed
        fetchUserCars();
      });
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> fetchUserCars() async {
    if (_isFetching) return;
    final user = ref.watch(userProvider);
    if (user == null || user.token == null) {
      // Show a modal dialog if the user is not logged in or token is missing
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              // title: Text('Login Required'),
              content: Text('You need to log in to see your cars.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: Text('Later'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            );
          },
        );
      });
      return;
    }

    final token = user.token;
    final loggedInUserId = user.user?.id;
    _isFetching = true;
    try {
      setState(() {
        userCars.clear();
        carImages.clear();
      });

      final userCarsList = await ref
          .read(carProvider.notifier)
          .getUserCars(token: token!, loggedInUserId: loggedInUserId!);

      // Print the JSON data of userCarsList for debugging
      print('Fetched userCarsList JSON: ${jsonEncode(userCarsList)}');

      for (var car in userCarsList) {
        final carDetails = await _fetchCarDetails(car.carId!, token);
        final carImageUrl = await _fetchCarImageUrl(carDetails.images!, token);

        print('Fetched car details: ${carDetails.toJson()}');
        print('Fetched image URL for car ID ${carDetails.id}: $carImageUrl');

        setState(() {
          userCars.add(carDetails.copyWith(
            id: car.id,
            carId: car.carId,
            mileage: car.mileage,
            fuelType: car.fuelType,
          ));

          print("Original car ID: ${car.carId}");
          var updatedCar = car.copyWith(mileage: car.mileage! + 100);
          print("Updated car ID: ${updatedCar.carId}");
          if (carImageUrl != null) {
            carImages[carDetails.id] = carImageUrl;
            print("Added image URL for car ID ${carDetails.id}: $carImageUrl");
          }
        });
      }

      setState(() {
        _hasFetchedSuccessfully = true;
      });
    } catch (e) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to load cars or images: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    } finally {
      _isFetching = false;
    }
  }

  Future<void> deleteCar(int id, String token) async {
    // Show a confirmation modal before deletion
    final shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Car'),
          content: Text('Are you sure you want to delete this car?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel deletion
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm deletion
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return; // Exit if the user chose not to delete

    final url = Uri.parse('$baseUrl/user-garage/delete');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "user_garage": {
          "id": id,
        }
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        userCars
            .removeWhere((car) => car.id == id); // Remove the car from the list
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Car deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete car: ${response.body}')),
      );
    }
  }

  Future<Entity> _fetchCarDetails(int carId, String token) async {
    final url = Uri.parse('$baseUrl/admin-garage');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['entities'] != null) {
      final car = data['entities'].firstWhere((car) => car['id'] == carId);
      return Entity.fromJson(car);
    } else {
      throw Exception('Car details not found');
    }
  }

  Future<String?> _fetchCarImageUrl(int imageId, String token) async {
    final url = Uri.parse('$baseUrl/car-image');
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['entities'] != null) {
      final image =
          data['entities'].firstWhere((image) => image['id'] == imageId);
      return 'https://cars.sandbox.co.ke:8177' +
          image['images'].replaceAll('"', '');
    } else {
      throw Exception('Car image not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "My Vehicles" text and "Add" icon
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                const Text(
                  'My Vehicles',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCarScreen()),
                    );
                  },
                  child: const Icon(
                    Icons.add,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),

          // List of cars
          for (int carIndex = 0; carIndex < userCars.length; carIndex++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Car's main image
                    SizedBox(
                      height: 150,
                      child: () {
                        final imageUrl = carImages[userCars[carIndex].carId];
                        print(
                            "Image URL for car ID ${userCars[carIndex].carId}: $imageUrl");
                        return buildImageCard(imageUrl);
                      }(),
                    ),

                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        if (user?.token != null) {
                          await deleteCar(userCars[carIndex].id,
                              user!.token!); // Pass `id` here
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildFeatureCard(Icons.directions_car, 'Model',
                          userCars[carIndex].model ?? 'Unknown'),
                      buildFeatureCard(Icons.speed, 'Power',
                          userCars[carIndex].power ?? 'Unknown'),
                      buildFeatureCard(Icons.settings, 'Trim',
                          userCars[carIndex].trim ?? 'Unknown'),
                      buildFeatureCard(Icons.browse_gallery_rounded, 'Engine',
                          userCars[carIndex].engine ?? 'Unknown'),
                      buildFeatureCard(Icons.settings_power, 'Torque',
                          userCars[carIndex].torque ?? 'Unknown'),
                      buildFeatureCard(Icons.transform, 'Transmission',
                          userCars[carIndex].transmission ?? 'Unknown'),
                      buildFeatureCard(Icons.directions, 'Drivetrain',
                          userCars[carIndex].drivetrain ?? 'Unknown'),
                      buildFeatureCard(
                          Icons.local_gas_station,
                          'Fuel Consumption',
                          userCars[carIndex].fuelConsumption ?? 'N/A'),
                      // New feature cards for mileage and fuel type
                      buildFeatureCard(Icons.speed, 'Mileage',
                          userCars[carIndex].mileage?.toString() ?? 'N/A',
                          id: userCars[carIndex].id,
                          isEditable: true,
                          field: 'mileage',
                          initialValue: userCars[carIndex].mileage),
                      buildFeatureCard(Icons.local_gas_station, 'Fuel Type',
                          userCars[carIndex].fuelType ?? 'N/A',
                          id: userCars[carIndex].id,
                          isEditable: true,
                          field: 'fuelType',
                          initialValue: userCars[carIndex].fuelType),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildImageCard(String? imageUrl) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: 300.0,
            height: 150.0,
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error, size: 50),
                    )
                  : Center(
                      child:
                          CircularProgressIndicator()), // Loading spinner for null imageUrl
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFeatureCard(IconData icon, String label, String serviceName,
      {int? id,
      bool isEditable = false,
      String field = '',
      dynamic initialValue}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Container(
        width: 140,
        height: 180,
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
            if (isEditable)
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () async {
                    final newValue = await showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        dynamic updatedValue = initialValue;
                        return AlertDialog(
                          title: Text('Edit $label'),
                          content: TextField(
                            keyboardType: field == 'mileage'
                                ? TextInputType.number
                                : TextInputType.text,
                            onChanged: (value) {
                              updatedValue = field == 'mileage'
                                  ? int.tryParse(value)
                                  : value;
                            },
                            controller: TextEditingController(
                                text: initialValue.toString()),
                            decoration: InputDecoration(
                              labelText: 'New $label',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(null);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(updatedValue);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );

                    if (newValue != null) {
                      // Update field via API
                      await updateUserCars(id!,
                          newMileage: field == 'mileage' ? newValue : null,
                          newFuelType: field == 'fuelType' ? newValue : null);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
