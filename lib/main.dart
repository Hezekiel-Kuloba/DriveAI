import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_car_app/screens/authentication/login.dart';
import 'package:new_car_app/screens/authentication/register.dart';
import 'package:new_car_app/screens/car_ai/car_ai.dart';
import 'package:new_car_app/screens/car_commerce/ecommerce_dashboard.dart';
import 'package:new_car_app/screens/car_gram/account.dart';
import 'package:new_car_app/screens/dashboards/community.dart';
import 'package:new_car_app/screens/dashboards/dashboard.dart';
import 'package:new_car_app/screens/navigation/nav.dart';
import 'package:new_car_app/screens/traffic_jam/traffic_jam.dart';
import 'package:new_car_app/screens/utils/theme.dart';
import 'package:new_car_app/utilis/user.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motor Wise',
      theme: AppThemes.lightTheme,
      // darkTheme: AppThemes.darkTheme,
      // themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/community': (context) => Community(),
        '/news': (context) => NewsScreen(),
        '/events': (context) => EventsScreen(),
        '/top_accounts': (context) => TopAccountsScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const SignUpScreen(),
      },
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = [
    const Dashboard(),
    EcommerceDashboard(),
    TrafficScreen(),
    CarAIScreen(),
    CarProfilePage(),
    CarAppNavigationScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // 2 tabs: For You and Community
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Adjust height as needed
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TabBar
            Expanded(
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                tabs: [
                  Tab(text: 'For You'),
                  Tab(text: 'Community'),
                ],
                indicatorColor: Colors.black, // Customize the indicator color
              ),
            ),
            // Notification Icon
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Handle notification action
              },
            ),
            // Sign In Button

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                (user?.user?.email != null && user!.user!.email!.length > 7)
                    ? '${user.user!.email!.substring(0, 6)}...'
                    : (user?.user?.email ?? 'Sign In'),
                overflow: TextOverflow
                    .ellipsis, // Ensures ellipsis if text is too long
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _pages[_selectedIndex], // For You content
          const Community(), // Community content
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 24),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.traffic, size: 24), // Traffic
            label: 'Traffic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android, size: 24), // AI
            label: 'AI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more, size: 24),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
