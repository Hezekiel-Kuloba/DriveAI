import 'package:flutter/material.dart';

class FuelPriceSlider extends StatefulWidget {
  FuelPriceSlider({super.key});

  final List<Map<String, String>> services = [
    {"petrol": "180.00", "unit": "per litre"},
    {"diesel": "165.00", "unit": "per litre"},
    {"electric_vehicle": "50.00", "unit": "per kWh"},
  ];

  @override
  _FuelPriceSliderState createState() => _FuelPriceSliderState();
}

class _FuelPriceSliderState extends State<FuelPriceSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Text(
            'Current Fuel Prices',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120, // Fixed height for the list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8.0), // Set left padding
            itemCount: widget.services.length,
            itemBuilder: (context, index) {
              String serviceType = widget.services[index].keys.first;
              String price = widget.services[index].values.first;
              String unit = widget.services[index]["unit"] ?? '';
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: buildServiceCard(serviceType, price, unit),
              );
            },
          ),
        ),
      ],
    );
  }

  // Widget for displaying a single service card with image and price
  Widget buildServiceCard(String serviceType, String price, String unit) {
    String imageUrl;
    String label;

    switch (serviceType) {
      case 'petrol':
        imageUrl =
            "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1726208902/pexels-enginakyurt-12377482_jpouvd.jpg";
        label = "Petrol";
        break;
      case 'diesel':
        imageUrl =
            "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1726208904/pexels-ingo-188024_pbgx0a.jpg";
        label = "Diesel";
        break;
      case 'electric_vehicle':
        imageUrl =
            "https://res.cloudinary.com/dqu3gbrsj/image/upload/v1726208903/chuttersnap-xJLsHl0hIik-unsplash_k8vo6o.jpg";
        label = "Electric Vehicle";
        break;
      default:
        imageUrl = "";
        label = "Unknown Service";
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0, // Set elevation to 0 to remove shadow
      child: Container(
        width: 130.0, // Fixed width for the cards
        height: 100.0, // Fixed height for the cards
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "KSH ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily:
                        'DSEG7Classic', // Apply the DSEG7Classic font here
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              unit,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500, // Faded text for the unit
              ),
            ),
          ],
        ),
      ),
    );
  }
}
