import 'package:flutter/material.dart';
import 'package:new_car_app/models/ai.dart';
import 'package:new_car_app/screens/service/service_items.dart';
import 'package:new_car_app/utilis/ai.dart';
import 'package:new_car_app/utilis/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceAICategories extends ConsumerStatefulWidget {
  @override
  _ServiceAICategoriesState createState() => _ServiceAICategoriesState();
}

class _ServiceAICategoriesState extends ConsumerState<ServiceAICategories> {
  List<ServiceAI> category = [];
  bool _isFetching = false;
  bool _hasFetchedSuccessfully = false;
  String baseUrl =
      "https://cars.sandbox.co.ke:8177"; // Define your base URL here

  @override
  void initState() {
    super.initState();
    if (!mounted || _hasFetchedSuccessfully) return;
    Future.delayed(Duration.zero, fetchServiceCategories);
  }

  Future<void> fetchServiceCategories() async {
    if (_isFetching) return;
    final user = ref.watch(userProvider);
    final token = user!.token;
    _isFetching = true;
    try {
      final serviceCategory =
          await ref.read(aiProvider.notifier).getServiceTitles(token: token!);

      setState(() {
        _hasFetchedSuccessfully = true;
        category = serviceCategory;
      });
    } catch (e) {
      print(e);
    } finally {
      _isFetching = false;
    }
  }

  Widget buildServiceCard(String serviceName, String imageUrl) {
    // Remove leading and trailing quotes if present
    final cleanedImageUrl = imageUrl.replaceAll('"', '').trim();
    final fullImageUrl =
        "$baseUrl$cleanedImageUrl"; // Concatenate base URL with cleaned image path

    print(
        "Image URL: $fullImageUrl"); // Print cleaned image URL to the terminal

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
                  fullImageUrl,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Categories'),
      ),
      body: _isFetching
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3 / 2, // Adjusts height relative to width
                ),
                itemCount: category.length,
                itemBuilder: (context, index) {
                  final service = category[index];
                  print('Navigating with service ID: ${service.id}');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ServiceItems(serviceId: service.id),
                        ),
                      );
                    },
                    child: buildServiceCard(service.name, service.images!),
                  );
                },
              ),
            ),
    );
  }
}

class ServiceDetailPage extends StatelessWidget {
  final ServiceAI service;

  ServiceDetailPage({required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(service.images ?? ''),
            SizedBox(height: 16),
            Text(
              service.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Additional service details can be displayed here
          ],
        ),
      ),
    );
  }
}
