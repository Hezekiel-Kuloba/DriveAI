import 'package:flutter/material.dart';
import 'package:new_car_app/screens/car_commerce/car_list.dart';
import 'package:new_car_app/screens/car_commerce/car_spares.dart';
import 'package:new_car_app/screens/car_news/news.dart';
import 'package:new_car_app/screens/car_news/news_list.dart';
import 'package:new_car_app/screens/my_car/car_notes.dart';
import 'package:new_car_app/screens/my_car/plan_to_buy.dart';
import 'package:new_car_app/widgets/amenity_near_me.dart';
import 'package:new_car_app/widgets/car_details_slider.dart';
import 'package:new_car_app/widgets/fuel_pricing_slider.dart';
import 'package:new_car_app/widgets/main_services.dart';
import 'package:new_car_app/widgets/preferences.dart'; // Ensure the correct path to CarDetailsSlider is used

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsFeedScreen(), // Wrap your ListView inside Expanded or Flexible
            // const SizedBox(height: 20),
            CarDetailsSlider(), // Include CarDetailsSlider with data passed
            const SizedBox(height: 20),
            DriverNecessities(),
            const SizedBox(height: 20),
            FuelPriceSlider(),
            const SizedBox(height: 10),
            PlanToBuySlider(),
            const SizedBox(height: 20),
            MainServicesList(),
            const SizedBox(height: 20),
            PreferencesSlider(),
            const SizedBox(height: 20),
            NearbyServicesSlider(),
            const SizedBox(height: 10),
            SparesHorizontalList(),
            const SizedBox(height: 20),
            CarGridScreen(),
          ],
        ),
      ),
    );
  }
}
