import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'SafeLinkGSU',
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      onGenerateRoute: onGenerateRoute,
    );
  }
}