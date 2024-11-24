import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/buddy_screen.dart';
import 'screens/carpool_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/buddy_request_screen.dart';
import 'main_scaffold.dart';
import 'screens/requests_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const MainScaffold(),
  '/buddy': (context) => const BuddyScreen(),
  '/carpool': (context) => const CarpoolScreen(),
  '/login': (context) => const AuthScreen(),
  '/buddyRequest': (context) => const BuddyRequestScreen(),
  '/requests': (context) => const RequestsScreen(),
};