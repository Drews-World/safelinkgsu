import 'package:cloud_firestore/cloud_firestore.dart';

class BuddyService {
  final CollectionReference buddyRequests =
      FirebaseFirestore.instance.collection('buddy_requests');

  // Make a buddy request
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

  // Get pending buddy requests
  Stream<List<Map<String, dynamic>>> getPendingBuddyRequests() {
    return buddyRequests
        .where('status', isEqualTo: 'pending')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              };
            }).toList());
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
   // Join a buddy request
  Future<void> joinBuddyRequest({
    required String requestId,
    required String joinerId,
    required String joinerName,
    required String location,
  }) async {
    try {
      await buddyRequests
          .doc(requestId)
          .collection('join_requests')
          .add({
            'joinerId': joinerId,
            'joinerName': joinerName,
            'location': location,
            'timestamp': FieldValue.serverTimestamp(),
          });
      print('Successfully joined the buddy request!');
    } catch (e) {
      print('Failed to join the buddy request: $e');
    }
  }

  // Get join requests for a specific user
  Stream<List<Map<String, dynamic>>> getJoinRequests(String requesterId) {
    return buddyRequests
        .where('requesterId', isEqualTo: requesterId)
        .snapshots()
        .asyncMap((querySnapshot) async {
      List<Map<String, dynamic>> allJoinRequests = [];
      for (var doc in querySnapshot.docs) {
        final joinRequests = await doc.reference.collection('join_requests').get();
        for (var joinRequest in joinRequests.docs) {
          allJoinRequests.add(joinRequest.data());
        }
      }
      return allJoinRequests;
    });
  }
}