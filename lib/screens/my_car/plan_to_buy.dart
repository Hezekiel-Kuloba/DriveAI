import 'package:flutter/material.dart';

class PlanToBuySlider extends StatefulWidget {
  PlanToBuySlider({super.key});

  final Map<String, dynamic> carDetails = {
    "current price": "100,000 KSH",
    "target price": "100,000 KSH",
    "percentage remaining": "60%",
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
      "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1725719234/iris_qoqqml.png"
    ]
  };

  @override
  _PlanToBuySliderState createState() => _PlanToBuySliderState();
}

class _PlanToBuySliderState extends State<PlanToBuySlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Plan To Buy',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: () {
                  _showEditDialog(
                      context, "Plan To Buy", ""); // Your edit action
                },
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildFeatureCardItem("Model", widget.carDetails["model"],
                  icon: Icons.model_training),
              buildCurrentPriceCard(),
              buildTargetPriceCard(),
              buildImageCard(),
              buildFeatureCardItem("Trim", widget.carDetails["trim"],
                  icon: Icons.tune),
              buildFeatureCardItem("Engine", widget.carDetails["engine"],
                  icon: Icons.power),
              buildFeatureCardItem("Power", widget.carDetails["power"],
                  icon: Icons.power),
              buildFeatureCardItem("Torque", widget.carDetails["torque"],
                  icon: Icons.gas_meter),
              buildFeatureCardItem(
                  "Transmission", widget.carDetails["transmission"],
                  icon: Icons.tire_repair),
              buildFeatureCardItem(
                  "Drivetrain", widget.carDetails["drivetrain"],
                  icon: Icons.drive_eta),
              buildFeatureCardItem(
                  "Acceleration", widget.carDetails["acceleration"],
                  icon: Icons.speed),
              buildFeatureCardItem(
                  "Fuel Consumption", widget.carDetails["fuel_consumption"],
                  icon: Icons.local_gas_station),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImageCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 300.0,
          height: 170.0,
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.carDetails['images'][0],
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentPriceCard() {
    return buildEditableCard(
      label: "Saved Amount",
      percentageRemaining: widget.carDetails["percentage remaining"],
      serviceName: widget.carDetails["current price"],
      icon: Icons.edit, // Show the edit icon for Target Price
    );
  }

  Widget buildTargetPriceCard() {
    return buildEditableCard(
      label: "Target Price",
      serviceName: widget.carDetails["target price"],
      icon: Icons.edit, // Show the edit icon for Target Price
    );
  }

  Widget buildEditableCard(
      {required String label,
      required String serviceName,
      IconData? icon,
      String? percentageRemaining}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: 150.0,
          height: 170.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Left align the text
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically center the content
            children: [
              if (percentageRemaining != null) ...[
                const SizedBox(height: 8),
                Text(
                  percentageRemaining,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8), // Small gap between label and value

              // Use Text.rich to style part of the text differently
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: serviceName.split(' ')[0], // The price part
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold, // Make price bold
                      ),
                    ),
                    TextSpan(
                      text: ' ${serviceName.split(' ').sublist(1).join(' ')}',
                      style: const TextStyle(
                        fontSize: 17, // Keep the rest of the text normal
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Spacer(), // This ensures content pushes to the top, and leaves space at the bottom

              if (icon != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(icon, size: 20),
                    onPressed: () {
                      _showEditDialog(context, label, serviceName);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFeatureCardItem(String feature, String value,
      {IconData? icon, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: 150.0,
          height: 170.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Left align the text
            mainAxisAlignment: icon == null
                ? MainAxisAlignment
                    .center // Vertically center for no-icon cards
                : MainAxisAlignment
                    .start, // Normal alignment if there's an icon
            children: [
              if (icon != null) Icon(icon, size: 30),
              if (icon != null)
                const SizedBox(height: 16), // Small gap if icon exists
              Text(
                feature,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8), // Small gap between feature and value
              Text(
                value,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

// Dummy function for edit dialog
  void _showEditDialog(BuildContext context, String label, String serviceName) {
    // Edit action here
  }
}
