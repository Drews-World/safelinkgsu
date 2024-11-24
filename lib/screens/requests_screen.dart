import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/buddy_service.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BuddyService buddyService = BuddyService();
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Requests'),
        backgroundColor: Colors.blue,
      ),
      body: currentUser == null
          ? const Center(child: Text('Please log in to view requests.'))
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: buddyService.getJoinRequests(currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final requests = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(request['joinerName']),
                        subtitle: Text('Location: ${request['location']}'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Accepted ${request['joinerName']}!'),
                              ),
                            );
                          },
                          child: const Text('Accept'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}