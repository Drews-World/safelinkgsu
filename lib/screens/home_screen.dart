import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        leading: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.14159), 
          child: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/HomeScreenBackground.png', 
            fit: BoxFit.cover,
          ),
          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Text content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.0), 
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to SafeLink GSU!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gill Sans Bold' ,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your all-in-one platform for safe, secure, and connected commuting at Georgia State University.',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Current Features',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    '• Walking Buddy System: Connect with fellow students to walk safely around campus, especially at night.\n'
                    '• Carpool Finder: Match with students commuting from similar locations for a cost-effective and sustainable ride-sharing experience.\n'
                    '• Safety Timer & GPS Tracking: Keep track of your commutes and walks in real-time, with automatic alerts for added security.\n'
                    '• Emergency Button: Contact GSU Police instantly with your location in case of emergencies.\n'
                    '• Feedback and Ratings: Review your buddy or carpool experiences to ensure accountability and improve connections.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Coming Soon',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '• 🌍 Multi-College Platform: Expanding SafeLink to students across other universities.\n'
                    '• 🚌 Shuttle Integration: Track GSU shuttles in real-time for more convenient commutes.\n'
                    '• 👮‍♀️ GSU PD Integration: Deeper connection with campus police for enhanced safety and rapid response.\n'
                    '• 💬 Chat Rooms: Secure spaces to coordinate plans and interact with your campus community.\n'
                    '• 🎉 Buddy System for Events: Find companions attending the same classes or events.\n'
                    '• 🔐 GSU SSO Authentication: Seamless and secure login with your GSU credentials.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}