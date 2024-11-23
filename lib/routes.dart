import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/buddy_screen.dart';
import 'screens/carpool_screen.dart';
import 'screens/auth_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/buddy': (context) => const BuddyScreen(),
  '/carpool': (context) => const CarpoolScreen(),
  '/login': (context) => const AuthScreen(), 
};