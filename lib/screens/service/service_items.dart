import 'package:flutter/material.dart';
import 'package:new_car_app/models/ai.dart';
import 'package:new_car_app/screens/service/service_ai.dart';
import 'package:new_car_app/utilis/ai.dart';
import 'package:new_car_app/utilis/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceItems extends ConsumerStatefulWidget {
  final int serviceId;

  ServiceItems({required this.serviceId});

  @override
  _ServiceItemsState createState() => _ServiceItemsState();
}

class _ServiceItemsState extends ConsumerState<ServiceItems> {
  List<ServiceAI> category = [];
  bool _isFetching = false;
  bool _hasFetchedSuccessfully = false;

  @override
  void initState() {
    super.initState();
    print('Service ID in ServiceItems items: ${widget.serviceId}');
    if (!mounted || _hasFetchedSuccessfully) return;
    Future.delayed(Duration.zero, fetchServiceItems);
  }

  Future<void> fetchServiceItems() async {
    if (_isFetching) return;

    final user = ref.watch(userProvider);
    final token = user!.token;
    _isFetching = true;
    try {
      final serviceCategory = await ref
          .read(aiProvider.notifier)
          .getServiceNames(token: token!, titleId: widget.serviceId);

      setState(() {
        _hasFetchedSuccessfully = true;
        category = serviceCategory;
      });

      print('Fetched car name data is: ${serviceCategory}');
      print('Fetched car category data is: ${category}');
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Items')),
      body: _isFetching
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    final item = category[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.build, color: Colors.orange),
                        title: Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        onTap: () => _showCarNameDialog(context, item.name),
                      ),
                    );
                  }),
            ),
    );
  }

  // Function to display the car name input dialog
  Future<void> _showCarNameDialog(BuildContext context, String itemName) async {
    TextEditingController carNameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Car Name'),
          content: TextField(
            controller: carNameController,
            decoration: InputDecoration(
              labelText: 'Car Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final carName = carNameController.text;
                if (carName.isNotEmpty) {
                  Navigator.of(context).pop(); // Close the dialog
                  _navigateToServiceAIScreen(context, itemName, carName);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to navigate to ServiceAIScreen
  void _navigateToServiceAIScreen(
      BuildContext context, String itemName, String carName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceAIScreen(
          itemName: itemName,
          carName: carName,
        ),
      ),
    );
  }
}
