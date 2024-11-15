import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Markdown rendering
import 'package:new_car_app/utilis/service.dart'; // Assuming you have the provider imported

class ServiceAIScreen extends ConsumerStatefulWidget {
  final String itemName;
  final String carName;

  const ServiceAIScreen({
    Key? key,
    required this.itemName,
    required this.carName,
  }) : super(key: key);

  @override
  _ServiceAIScreenState createState() => _ServiceAIScreenState();
}

class _ServiceAIScreenState extends ConsumerState<ServiceAIScreen> {
  bool isLoading = true; // Set loading to true initially
  String details = '';
  bool _hasFetchedSuccessfully = false;

  @override
  void initState() {
    super.initState();
    if (!mounted || _hasFetchedSuccessfully) return;
    Future.delayed(Duration.zero, _fetchServiceAIDetails);
  }

  Future<void> _fetchServiceAIDetails() async {
    try {
      // Set the loading state to true
      setState(() {
        isLoading = true;
      });

      // Call the API method from the notifier
      final serviceDetails =
          await ref.read(serviceProvider.notifier).getServiceAIDetailsFromAPI(
                itemName: widget.itemName,
                carName: widget.carName,
              );

      setState(() {
        _hasFetchedSuccessfully = true;
        details = serviceDetails;
      });
    } catch (e) {
      // Handle any errors here (you can show a Snackbar, or an alert dialog)
      print('Error: $e');
    } finally {
      // Set the loading state to false when the API call is completed
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceState = ref.watch(serviceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service AI Details'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : details.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Markdown(
                    data: details,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                      h1: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      h2: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      p: const TextStyle(fontSize: 16),
                      listBullet: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Failed to fetch details. Please try again.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchServiceAIDetails,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
    );
  }
}
