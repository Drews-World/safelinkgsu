import 'package:flutter/material.dart';

class CarpoolRequestScreen extends StatefulWidget {
  const CarpoolRequestScreen({super.key});

  @override
  _CarpoolRequestScreenState createState() => _CarpoolRequestScreenState();
}

class _CarpoolRequestScreenState extends State<CarpoolRequestScreen> {
  final _destinationController = TextEditingController();


  String? _selectedTime;
  String? _selectedGender;
  String? _selectedDirection;


  final List<String> _timeIntervals = List.generate(
    24 * 4,
    (index) {
      final hour = index ~/ 4;
      final minute = (index % 4) * 15;
      final isAM = hour < 12;
      final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} ${isAM ? 'AM' : 'PM'}';
    },
  );

  final List<String> _genders = [
    'Male',
    'Female',
    'Any',
  ];

  final List<String> _directions = [
    'Going',
    'Leaving',
  ];

  void _submitRequest() {
    final destination = _destinationController.text;

    if (destination.isEmpty ||
        _selectedTime == null ||
        _selectedGender == null ||
        _selectedDirection == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Request submitted! Destination: $destination, Time: $_selectedTime, Gender: $_selectedGender, Direction: $_selectedDirection'),
      ),
    );


    _destinationController.clear();
    setState(() {
      _selectedTime = null;
      _selectedGender = null;
      _selectedDirection = null;
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Form'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destination Input
            const Text(
              'Destination (City and County)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your destination (e.g., Atlanta, Fulton County)',
              ),
            ),
            const SizedBox(height: 16),

            // Time Leaving Dropdown
            const Text(
              'Time Leaving',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select time leaving'),
              items: _timeIntervals
                  .map((time) => DropdownMenuItem(value: time, child: Text(time)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Gender Preference Dropdown
            const Text(
              'Gender Preference',
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
                  .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Going or Leaving Dropdown
            const Text(
              'Going to or Leaving GSU',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedDirection,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              hint: const Text('Select direction'),
              items: _directions
                  .map((direction) =>
                      DropdownMenuItem(value: direction, child: Text(direction)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDirection = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 160, 255, 162),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _submitRequest,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}