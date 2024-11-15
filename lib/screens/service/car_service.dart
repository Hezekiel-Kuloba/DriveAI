import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:new_car_app/models/service.dart';
import 'package:new_car_app/screens/fuel/fuel.dart';
import 'package:new_car_app/screens/garages/garage.dart';
import 'package:new_car_app/screens/mechanics/mechanics.dart';
import 'package:new_car_app/screens/service/service_add.dart';
import 'package:new_car_app/screens/service/service_titles.dart';
import 'package:new_car_app/screens/tyres/tyres.dart';
import 'package:new_car_app/utilis/service.dart';
import 'package:new_car_app/utilis/user.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen> {
  List<Service> userServices = [];
  bool _isFetching = false;
  bool _hasFetchedSuccessfully = false;
  final Map<String, IconData> _iconMap = {
    'timer': Icons.timer,
    'serviceLocation': Icons.location_on,
    'serviceGarage': Icons.garage,
    'serviceDate': Icons.calendar_today,
    'serviceMechanic': Icons.build,
  };

  final List<Map<String, dynamic>> features = [
    {
      "name": "SERVICE AI",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1731564168/3d-render-robot-searching_11zon_xiwjwn.jpg",
      "placeType": "gas_station",
      "title": "Petrol Stations",
    },
    {
      "name": "Garage",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729669182/garage_11zon_ygppj2.png",
      "placeType": "charging_station",
      "title": "Electric Charging Stations",
    },
    {
      "name": "Mechanic",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729668835/mechanic_mf4ydr.png",
      "placeType": "car_repair",
      "title": "Garages",
    },
    {
      "name": "Fuel",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729668835/fuel_ackuof.png",
      "placeType": "restaurant",
      "title": "Restaurants",
    },
    {
      "name": "Tyres",
      "imageUrl":
          "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1729168132/wheel_ja1m0k.png",
      "placeType": "restaurant",
      "title": "Tyres",
    },
  ];

  @override
  void initState() {
    super.initState();
    if (!mounted || _hasFetchedSuccessfully) return;
    Future.delayed(Duration.zero, fetchUserServices);
  }

  Map<int, String> _serviceStatuses =
      {}; // Tracks each service status by its ID

  Future<void> updateUserService(int id, {String? status}) async {
    final user = ref.watch(userProvider);
    final token = user!.token;

    try {
      final message =
          await ref.read(serviceProvider.notifier).updateServiceField(
                id: id,
                status: status,
                token: token!,
              );

      // Update local service status on success
      setState(() {
        _serviceStatuses[id] = status!;
      });

      // Show success dialog
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
          }).then((_) => fetchUserServices());
    } catch (e) {
      // Show error dialog
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
          });
    }
  }

  Future<void> deleteUserCars(int id, String token) async {
    final user = ref.watch(userProvider);
    final token = user!.token;
    try {
      final message = await ref.read(serviceProvider.notifier).deleteService(
            id: id,
            token: token!,
          );

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
      );
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete: $e'),
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

  Future<void> fetchUserServices() async {
    if (_isFetching) return;
    final user = ref.watch(userProvider);
    final token = user!.token;
    final loggedInUserId = user.user?.id;
    _isFetching = true;
    try {
      final userServiceList = await ref
          .read(serviceProvider.notifier)
          .getUserService(token: token!, loggedInUserId: loggedInUserId!);

      setState(() {
        _hasFetchedSuccessfully = true;
        userServices = userServiceList;
      });

      _serviceStatuses = {
        for (var service in userServiceList) service.id: service.status!
      };
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
    }
  }

  Widget _buildStatusButtons(int serviceId) {
    String? status = _serviceStatuses[serviceId];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Completed Button
        ElevatedButton(
          onPressed: () => updateUserService(serviceId, status: 'Completed'),
          style: ElevatedButton.styleFrom(
            foregroundColor:
                status == 'Completed' ? Colors.white : Colors.green,
            backgroundColor:
                status == 'Completed' ? Colors.green : Colors.white,
            side: BorderSide(
              color: Colors.green,
            ),
          ),
          child: Text('Completed'),
        ),
        const SizedBox(width: 20),
        // Pending Button
        ElevatedButton(
          onPressed: () => updateUserService(serviceId, status: 'Pending'),
          style: ElevatedButton.styleFrom(
            foregroundColor: status == 'Pending' ? Colors.white : Colors.orange,
            backgroundColor: status == 'Pending' ? Colors.orange : Colors.white,
            side: BorderSide(
              color: Colors.orange,
            ),
          ),
          child: Text('Pending'),
        ),
      ],
    );
  }

  Widget _buildTimerCard(int serviceId, String token, Service service) {
    // Assuming we're showing the countdown for the first service date
    final DateTime currentDate = DateTime.now();
    final DateTime nextServiceDate =
        DateTime.fromMillisecondsSinceEpoch(service.date!);
    final int daysRemaining = nextServiceDate.difference(currentDate).inDays;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Timer Card
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.8, // Adjust width
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center the content
                children: [
                  Icon(
                    Icons.timer, // Use mapped icon for timer
                    size: 48, // Larger icon for better visibility
                    color: Colors.red,
                  ),
                  const SizedBox(
                      height: 12), // Increased spacing for better layout
                  const Text(
                    'Days Remaining to Service Date',
                    style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$daysRemaining days',
                    style: const TextStyle(
                      fontSize: 19, // Increase the font size for emphasis
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                ],
              ),
            ),
          ),
        ),
        // Delete Icon
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await deleteUserCars(serviceId, token);
          },
        ),
      ],
    );
  }

  Widget _buildServiceCard(Service service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: Container(
            height: 150,
            width: 130,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconMap['serviceDate'], size: 25),
                const SizedBox(height: 8),
                Text(
                  'Date To Service',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('MM/dd/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(service.date!)),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: Container(
            height: 150,
            width: 130,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(_iconMap['serviceMechanic'], size: 25),
                const SizedBox(height: 8),
                Text(
                  'Service Item',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  service.item ?? 'N/A',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Method to build individual service cards
  Widget buildServiceCardOne(String serviceName, String imageUrl) {
    return SizedBox(
      width: 130, // Fixed width for each card
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 135.0, // Fixed height for cards
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
                child: Image.network(
                  imageUrl,
                  height: 60,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                serviceName,
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Add this method inside the _ServiceScreenState class
  Widget _buildDescriptionCard(String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        height: 150,
        width: 300, // Adjust width
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description,
              size: 25,
              // color: Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              'Description',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToService(Map<String, dynamic> service, BuildContext context) {
    switch (service['name']) {
      case 'SERVICE AI':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceAICategories()),
        );
        break;
      case 'Garage':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GarageServiceScreen()),
        );
        break;
      case 'Mechanic':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MechanicServiceScreen()),
        );
        break;
      case 'Fuel':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FuelServiceScreen()),
        );
        break;
      case 'Tyres':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TyreServiceScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Details'),
      ),
      body: userServices.isEmpty
          ? Center(child: Text('No Services Available'))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                    child: Text(
                      'Features',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 130, // Set height for the list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: features.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  _navigateToService(features[index], context),
                              child: buildServiceCardOne(
                                features[index]['name'],
                                features[index]['imageUrl'],
                              ),
                            ),
                            const SizedBox(width: 8), // Space between cards
                          ],
                        );
                      },
                    ),
                  ),
                  // Top Container with Service Notifications and Add Icon
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Text(
                            'Service Notifications',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddServiceScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: userServices.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final service = userServices[index];
                      return Column(
                        children: [
                          _buildTimerCard(service.id,
                              ref.read(userProvider)!.token!, service),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 180,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildServiceCard(service),
                                const SizedBox(width: 10),
                                _buildDescriptionCard(service.description ??
                                    'No description available'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          _buildStatusButtons(service.id),

                          const SizedBox(height: 10),

                          Divider(
                              thickness: 1,
                              color: Colors.grey), // Horizontal line
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
