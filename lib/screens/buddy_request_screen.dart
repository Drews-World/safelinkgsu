import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import '../services/buddy_service.dart';

class BuddyRequestScreen extends StatefulWidget {
  const BuddyRequestScreen({super.key});

  @override
  _BuddyRequestScreenState createState() => _BuddyRequestScreenState();
}

class _BuddyRequestScreenState extends State<BuddyRequestScreen> {
  // Dropdown selections
  String? _selectedLocation;
  String? _selectedDestination;
  String? _selectedGender;

  // Dropdown menu options
  final List<String> _locations = [
    'Adderhold',
    'Library North',
    'Library South',
    'Student Center East',
    'Student Center West',
    'Patton Hall',
    'Piedmont Central',
    'University Commons',
    'Piedmont North',
  ];

  final List<String> _genders = [
    'Male',
    'Female',
    'Any',
  ];

  final BuddyService _buddyService = BuddyService(); // Service instance

  String? _currentUserName; 

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserName(); 
  }


  void _fetchCurrentUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUserName = user.email?.split('@')[0]; 
      });
    }
  }

  // Submit the buddy request
  Future<void> _submitRequest() async {
    if (_selectedLocation != null &&
        _selectedDestination != null &&
        _selectedGender != null &&
        _currentUserName != null) {
      try {
        await _buddyService.addBuddyRequest(
          requesterId: FirebaseAuth.instance.currentUser!.uid, 
          requesterName: _currentUserName!, 
          location: _selectedLocation!,
          destination: _selectedDestination!,
          genderPreference: _selectedGender!,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Buddy request submitted successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit buddy request: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  // Join a buddy request
  Future<void> _joinRequest(Map<String, dynamic> request) async {
    if (_currentUserName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to retrieve user information.')),
      );
      return;
    }

    try {
      await _buddyService.joinBuddyRequest(
        requestId: request['id'],
        joinerId: FirebaseAuth.instance.currentUser!.uid,
        joinerName: _currentUserName!,
        location: request['location'],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request sent to ${request['requesterName']}!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to join the request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Buddy'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Location Dropdown
            const Text(
              'Your Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select your location'),
              items: _locations
                  .map((location) =>
                      DropdownMenuItem(value: location, child: Text(location)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Destination Dropdown
            const Text(
              'Destination',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedDestination,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select your destination'),
              items: _locations
                  .map((destination) =>
                      DropdownMenuItem(value: destination, child: Text(destination)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDestination = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Preferred Gender Dropdown
            const Text(
              'Preferred Gender',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select preferred gender'),
              items: _genders
                  .map((gender) =>
                      DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 165, 73),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _submitRequest,
                child: const Text('Submit Request'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}