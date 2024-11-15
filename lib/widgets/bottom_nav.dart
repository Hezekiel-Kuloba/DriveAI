import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    StoreScreen(),
    ListScreen(),
    AmenitiesScreen(),
    AIScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, size: 24),
            label: 'Store',
            tooltip: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 24),
            label: 'List',
            tooltip: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer,
                size: 24), // Using offer icon for amenities
            label: 'Amenities',
            tooltip: 'Amenities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.android, size: 24), // Using Android icon for AI
            label: 'AI',
            tooltip: 'AI',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Screen'));
  }
}

class StoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Store Screen'));
  }
}

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('List Screen'));
  }
}

class AmenitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Amenities Screen'));
  }
}

class AIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('AI Screen'));
  }
}
