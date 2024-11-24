import 'package:flutter/material.dart';
import '../services/buddy_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuddyScreen extends StatelessWidget {
  const BuddyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BuddyService buddyService = BuddyService(); 

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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: buddyService.getPendingBuddyRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final pendingRequests = snapshot.data ?? [];

          if (pendingRequests.isEmpty) {
            return const Center(child: Text('No buddies :('));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: pendingRequests.length,
              itemBuilder: (context, index) {
                final buddy = pendingRequests[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(buddy['requesterName'][0]), 
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    title: Text(buddy['requesterName']),
                    subtitle: Text(
                      'Location: ${buddy['location']}\nDestination: ${buddy['destination']}\nPreferred Gender: ${buddy['genderPreference']}',
                    ),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 109, 192, 99),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  
                                  // Perform the join operation
                                  buddyService.joinBuddyRequest(
                                    requestId: buddy['id'], // Firestore document ID
                                    joinerId: FirebaseAuth.instance.currentUser!.uid, // Current user's ID
                                    joinerName: FirebaseAuth.instance.currentUser!.email!.split('@')[0], // username
                                    location: buddy['location'], 
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Request sent to ${buddy['requesterName']}!'),
                                    ),
                                  );
                                },
                                child: const Text('Join'),
                              ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}