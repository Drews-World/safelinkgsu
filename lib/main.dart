import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const SafeLinkApp());
}

class SafeLinkApp extends StatelessWidget {
  const SafeLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeLink GSU',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: appRoutes, 
      onGenerateRoute: (settings) {
        
        if (settings.name == '/chat' || settings.name == '/carpoolChat') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => ChatScreen(buddyName: args['buddyName']!),
          );
        }
        return null; 
      },
    );
  }
}