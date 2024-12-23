import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/buddy_screen.dart';
import 'screens/carpool_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/buddy_request_screen.dart';
import 'main_scaffold.dart';
import 'screens/requests_screen.dart';
import 'screens/carpool_request_screen.dart';
import 'screens/carpool_requests_screen.dart';
import 'screens/chat_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const MainScaffold(),
  '/buddy': (context) => const BuddyScreen(),
  '/carpool': (context) => const CarpoolScreen(),
  '/login': (context) => const AuthScreen(),
  '/buddyRequest': (context) => const BuddyRequestScreen(),
  '/requests': (context) => const RequestsScreen(),
  '/carpoolRequest': (context) => const CarpoolRequestScreen(),
  '/carpoolRequests': (context) => const CarpoolRequestsScreen(),
};


Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  if (settings.name == '/chatscreen') {
    final args = settings.arguments as Map<String, String>;
    return MaterialPageRoute(
      builder: (context) => ChatScreen(buddyName: args['buddyName']!),
    );
  }
  return null; 
}