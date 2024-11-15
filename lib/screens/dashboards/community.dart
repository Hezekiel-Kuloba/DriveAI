// Community Screen with TabBar for News, Events, and Top Accounts
import 'package:flutter/material.dart';
import 'package:new_car_app/screens/authentication/login.dart';
import 'package:new_car_app/screens/car_commerce/ecommerce_dashboard.dart';
import 'package:new_car_app/screens/car_events/event.dart';
import 'package:new_car_app/screens/car_gram/accounts.dart';
import 'package:new_car_app/screens/car_news/news.dart';
import 'package:new_car_app/screens/car_news/news_list.dart';
import 'package:new_car_app/screens/dashboards/community.dart';
import 'package:new_car_app/screens/dashboards/dashboard.dart';
import 'package:new_car_app/screens/traffic_jam/traffic_jam.dart';
import 'package:new_car_app/screens/navigation/nav.dart';
import 'package:new_car_app/screens/utils/theme.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80, // Adjust height as needed
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TabBar(
                  indicatorColor: Colors.black, // Keep the indicator color
                  dividerColor:
                      Colors.transparent, // Remove the grey line below the tabs
                  tabs: [
                    Tab(text: 'News'),
                    Tab(text: 'Events'),
                    Tab(text: 'Top Accounts'),
                  ],
                ),
              ),
              // You can add other widgets here if needed, such as icons/buttons.
            ],
          ),
        ),
        body: TabBarView(
          children: [NewsList(), const Accounts(), const Accounts()],
        ),
      ),
    );
  }
}

// Sample Screens for TabBar Navigation
class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: const Center(child: Text("Latest News Data")),
    );
  }
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Events")),
      body: const Center(child: Text("Upcoming Events Data")),
    );
  }
}

class TopAccountsScreen extends StatelessWidget {
  const TopAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Top Accounts")),
      body: const Center(child: Text("Top Accounts Data")),
    );
  }
}
