import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key});

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  CarouselSliderController carouselController = CarouselSliderController();
  String licensePlate = "ABC1234";
  String vehicleColor = "Black";
  String mileage = "25,000 km";

  final Map<String, dynamic> carDetails = {
    "name": "Mercedes-Benz",
    "model": "2024 Mercedes-Benz GLE-Class SUV",
    "trim": "GLE 350 4MATIC",
    "engine": "2.0L Inline-4 Turbocharged",
    "power": "255 hp",
    "torque": "295 lb-ft",
    "transmission": "9-Speed Automatic",
    "drivetrain": "4MATIC All-Wheel Drive",
    "acceleration": "0-60 mph in 7.0 seconds",
    "fuel_consumption": "8.1 km/L city, 11.1 km/L highway",
    "images": [
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png",
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719553/iris3_cbjjxp.png",
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719557/iris2_elkm52.png",
    ]
  };

  TextEditingController licensePlateController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController mileageController = TextEditingController();

  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    licensePlateController.text = licensePlate;
    vehicleColorController.text = vehicleColor;
    mileageController.text = mileage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editable fields section as cards that open a modal
            buildEditableCard('License Plate', licensePlateController),
            buildEditableCard('Vehicle Color', vehicleColorController),
            buildEditableCard('Mileage', mileageController),

            const SizedBox(height: 16),

            // Slider for car images with a timer and dots
            buildImageSlider(),

            const SizedBox(height: 16),

            // Car features displayed as cards with varying sizes
            buildFeatureCards(),
          ],
        ),
      ),
    );
  }

  // Method to create a card that opens a modal dialog for editing
  Widget buildEditableCard(String label, TextEditingController controller) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(controller.text),
        trailing: const Icon(Icons.edit),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(labelText: 'Edit $label'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (label == 'License Plate') {
                            licensePlate = controller.text;
                          } else if (label == 'Vehicle Color') {
                            vehicleColor = controller.text;
                          } else if (label == 'Mileage') {
                            mileage = controller.text;
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Method to create the image slider with a timer and dots
  Widget buildImageSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Car Images",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: carDetails['images'].length,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                carDetails['images'][index],
                fit: BoxFit.cover,
              ),
            );
          },
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true, // Enable auto-play
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                // Handle slide change if needed
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: currentImageIndex,
            count: carDetails['images'].length,
            effect: const WormEffect(
              dotWidth: 10,
              dotHeight: 10,
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFeatureCards() {
    return GridView.count(
      crossAxisCount: 2, // Two cards per row
      shrinkWrap: true, // Ensures the grid doesn't expand infinitely in height
      physics:
          const NeverScrollableScrollPhysics(), // Prevent scrolling inside the grid
      childAspectRatio:
          1, // Adjusts the aspect ratio (width/height) of the cards
      mainAxisSpacing: 8, // Vertical space between cards
      crossAxisSpacing: 8, // Horizontal space between cards
      padding: const EdgeInsets.all(8), // Adds padding around the grid
      children: [
        buildFeatureCard(Icons.directions_car, 'Model', carDetails['model']),
        buildFeatureCard(Icons.build, 'Trim Level', carDetails['trim']),
        buildFeatureCard(Icons.settings, 'Engine', carDetails['engine']),
        buildFeatureCard(Icons.flash_on, 'Power', carDetails['power']),
        buildFeatureCard(Icons.speed, 'Torque', carDetails['torque']),
        buildFeatureCard(
            Icons.transform, 'Transmission', carDetails['transmission']),
        buildFeatureCard(
            Icons.all_inclusive, 'Drivetrain', carDetails['drivetrain']),
        buildFeatureCard(
            Icons.timer, 'Acceleration', carDetails['acceleration']),
        buildFeatureCard(Icons.local_gas_station, 'Fuel Consumption',
            carDetails['fuel_consumption']),
      ],
    );
  }

  // Method to build individual feature cards with customizable size and text
  // Method to build individual feature cards with customizable size and text
  // Method to build individual feature cards with customizable size and text
  Widget buildFeatureCard(IconData icon, String feature, String value,
      {double fontSize = 16, double cardHeight = 150, double iconSize = 40}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: cardHeight, // Increased height for more content
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to start
          children: [
            Icon(icon, size: iconSize), // Larger icon at the top-left corner
            const SizedBox(height: 8),
            Text(
              feature,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2, // Allows up to 2 lines for the feature text
              overflow: TextOverflow.ellipsis, // Handles overflow with ellipsis
            ),
            const SizedBox(height: 8),
            Expanded(
              // Makes the value text take the remaining space
              child: Text(
                value,
                style: const TextStyle(fontSize: 14),
                overflow:
                    TextOverflow.visible, // Text wraps instead of overflowing
              ),
            ),
          ],
        ),
      ),
    );
  }
}
