import 'package:flutter/material.dart';

class CarpoolRequestsScreen extends StatefulWidget {
  const CarpoolRequestsScreen({super.key});

  @override
  _CarpoolRequestsScreenState createState() => _CarpoolRequestsScreenState();
}

class _CarpoolRequestsScreenState extends State<CarpoolRequestsScreen> {
  // Dummy requests list
  final List<Map<String, dynamic>> requests = [
    {'name': 'Alex Johnson', 'location': 'Atlanta, GA', 'isAccepted': false},
    {'name': 'Chris Brown', 'location': 'Decatur, GA', 'isAccepted': false},
    {'name': 'Emily Davis', 'location': 'Marietta, GA', 'isAccepted': false},
  ];

  void _acceptRequest(int index) {
    setState(() {
      requests[index]['isAccepted'] = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${requests[index]['name']} has been accepted!'),
      ),
    );
  }

  void _goToChat(String buddyName) {
    Navigator.pushNamed(
      context,
      '/carpoolChat',
      arguments: {'buddyName': buddyName},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool Requests'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(request['name']![0]), 
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                title: Text(request['name']),
                subtitle: Text('Location: ${request['location']}'),
                trailing: request['isAccepted']
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _goToChat(request['name']),
                        child: const Text('Chat'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _acceptRequest(index),
                        child: const Text('Accept'),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}