import 'package:flutter/material.dart';
import 'routes.dart';

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
    );
  }
}