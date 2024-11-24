import 'package:flutter/material.dart';

class BuddyScreen extends StatelessWidget {
  const BuddyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of available buddies
    final List<Map<String, String>> availableBuddies = [
      {'name': 'John Doe', 'location': 'Library North', 'gender': 'Male'},
      {'name': 'Jane Smith', 'location': 'Student Center East', 'gender': 'Female'},
      {'name': 'Alex Johnson', 'location': 'Piedmont Central', 'gender': 'Any'},
      {'name': 'Emily Davis', 'location': 'Library South', 'gender': 'Female'},
      {'name': 'Chris Brown', 'location': 'Adderhold', 'gender': 'Male'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Walking'),
        backgroundColor: Colors.blue,
        actions: [
          
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Request a Buddy',
            onPressed: () {
              Navigator.pushNamed(context, '/buddyRequest');
            },
          ),
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'View Requests',
            onPressed: () {
              Navigator.pushNamed(context, '/requests');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: availableBuddies.length,
          itemBuilder: (context, index) {
            final buddy = availableBuddies[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(buddy['name']![0]), 
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                title: Text(buddy['name']!),
                subtitle: Text(
                    'Location: ${buddy['location']}\nPreferred Gender: ${buddy['gender']}'),
                isThreeLine: true,
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 109, 192, 99),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Request sent to ${buddy['name']}!'),
                      ),
                    );
                  },
                  child: const Text('Join'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}