import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/buddy_screen.dart';
import 'screens/carpool_screen.dart';
import 'screens/emergency_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BuddyScreen(),
    CarpoolScreen(),
    EmergencyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped, 
        type: BottomNavigationBarType.fixed, 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Buddy System',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Carpool',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Emergency',
          ),
        ],
        selectedItemColor: Colors.blueAccent, 
        unselectedItemColor: Colors.grey, 
      ),
    );
  }
}