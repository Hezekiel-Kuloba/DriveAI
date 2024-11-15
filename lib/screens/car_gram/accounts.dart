import 'package:flutter/material.dart';
import 'package:new_car_app/screens/car_commerce/car_list.dart';
import 'package:new_car_app/screens/car_gram/normal_accounts.dart';
import 'package:new_car_app/screens/car_gram/search_account.dart';
import 'package:new_car_app/screens/car_gram/top_accounts.dart';
import 'package:new_car_app/screens/car_news/news.dart';
import 'package:new_car_app/screens/car_news/news_list.dart';
import 'package:new_car_app/screens/my_car/car_list.dart';
import 'package:new_car_app/widgets/amenity_near_me.dart';
import 'package:new_car_app/widgets/car_details_slider.dart';
import 'package:new_car_app/widgets/ecommerce_horizontal_list.dart';
import 'package:new_car_app/widgets/ecommerce_slider.dart';
import 'package:new_car_app/widgets/fuel_pricing_slider.dart';
import 'package:new_car_app/widgets/main_services.dart'; // Ensure the correct path to CarDetailsSlider is used

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Coming soon',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SearchBarWidget(),
    //         // const SizedBox(height: 20),
    //         TopAccountsList(),
    //         // const SizedBox(height: 20),
    //         CarAccountListWidget()
    //       ],
    //     ),
    //   ),
    // );
  }
}
