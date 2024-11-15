import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/models/car.dart';
import 'package:new_car_app/utilis/car.dart';
import 'package:new_car_app/utilis/user.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedTrim;
  int? selectedYear;
  String? selectedColor;
  final TextEditingController plateController = TextEditingController();
  List<Entity> carData = [];

  Future<void> fetchCars() async {
    final token = ref.watch(userProvider)?.token;

    if (token != null) {
      final cars = await ref.watch(carProvider.notifier).getCars(token: token);
      setState(() {
        carData = cars;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user token found!')),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    if (carData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final List<String?> brands =
        carData.map((car) => car.name).toSet().toList();
    final List<String?> models = selectedBrand == null
        ? []
        : carData
            .where((car) => car.name == selectedBrand)
            .map((car) => car.model)
            .toSet()
            .toList();
    final List<String?> trims = selectedModel == null
        ? []
        : carData
            .where((car) => car.model == selectedModel)
            .map((car) => car.trim)
            .toSet()
            .toList();
    final List<int?> years = selectedTrim == null
        ? []
        : carData
            .where((car) => car.trim == selectedTrim)
            .map((car) => car.year)
            .toSet()
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Brand Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Car Brand',
                  prefixIcon: Icon(Icons.directions_car),
                ),
                value: selectedBrand,
                items: brands.map((brand) {
                  return DropdownMenuItem<String>(
                      value: brand, child: Text(brand!));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBrand = value;
                    selectedModel = null;
                    selectedTrim = null;
                    selectedYear = null;
                    selectedColor = null;
                  });
                },
              ),

              const SizedBox(height: 16.0), // Space between fields

              // Model Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Car Model',
                  prefixIcon: Icon(Icons.directions_car_outlined),
                ),
                value: selectedModel,
                items: models.map((model) {
                  return DropdownMenuItem<String>(
                      value: model, child: Text(model!));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedModel = value;
                    selectedTrim = null;
                    selectedYear = null;
                  });
                },
              ),

              const SizedBox(height: 16.0), // Space between fields

              // Trim Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Trim Level',
                  prefixIcon: Icon(Icons.build),
                ),
                value: selectedTrim,
                items: trims.map((trim) {
                  return DropdownMenuItem<String>(
                      value: trim, child: Text(trim!));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTrim = value;
                    selectedYear = null;
                  });
                },
              ),

              const SizedBox(height: 16.0), // Space between fields

              // Year Dropdown
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Car Year',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                value: selectedYear,
                items: years.map((year) {
                  return DropdownMenuItem<int>(
                      value: year, child: Text(year.toString()));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
              ),

              const SizedBox(height: 16.0), // Space between fields

              SizedBox(
                width: double.infinity,
                height: 56, // Match input field height
                child: ElevatedButton(
                  onPressed: () async {
                    final carId = carData
                        .firstWhere((car) => car.model == selectedModel)
                        .id;
                    final token = ref.watch(userProvider)?.token;
                    final userId = ref.watch(userProvider)?.user?.id;

                    if (token != null && userId != null) {
                      await ref.read(carProvider.notifier).addCarToGarage(
                            carId: carId,
                            mileage: 0,
                            mileageUnit: 'km',
                            fuelType: 'petrol',
                            serviceDate: DateTime.now().toIso8601String(),
                            currencyType: 'Ksh',
                            token: token,
                            userId: userId,
                          );

                      // Show confirmation modal
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Car has been added to your garage.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.of(context).pushReplacementNamed(
                                      '/'); // Redirect to HomeScreen
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
                  child: Text('Add Car to Garage'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
