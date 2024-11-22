import 'package:flutter/material.dart';
class BuddyScreen extends StatelessWidget {
  const BuddyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buddy System')),
      body: Center(
        child: Text('Request a Buddy feature coming soon!'),
      ),
    );
  }
}