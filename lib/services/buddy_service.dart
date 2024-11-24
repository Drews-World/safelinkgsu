import 'package:cloud_firestore/cloud_firestore.dart';

class BuddyService {
  final CollectionReference buddyRequests =
      FirebaseFirestore.instance.collection('buddy_requests');

  // Add a buddy request
  Future<void> addBuddyRequest({
    required String requesterId,
    required String requesterName,
    required String location,
    required String destination,
    required String genderPreference,
  }) async {
    try {
      await buddyRequests.add({
        'requesterId': requesterId,
        'requesterName': requesterName,
        'location': location,
        'destination': destination,
        'genderPreference': genderPreference,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
      print('Buddy request added successfully!');
    } catch (e) {
      print('Failed to add buddy request: $e');
    }
  }

  // Retrieve pending buddy requests
  Stream<List<Map<String, dynamic>>> getPendingBuddyRequests() {
    return buddyRequests
        .where('status', isEqualTo: 'pending')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  // Accept a buddy request
  Future<void> acceptBuddyRequest(String requestId) async {
    try {
      await buddyRequests.doc(requestId).update({'status': 'accepted'});
      print('Buddy request accepted successfully!');
    } catch (e) {
      print('Failed to accept buddy request: $e');
    }
  }
}