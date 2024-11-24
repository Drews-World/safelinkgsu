import 'package:flutter/material.dart';
import 'package:safelinkgsu/screens/chat_screen.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  final List<Map<String, dynamic>> requests = [
    {'name': 'Panther1', 'location': 'Library North', 'isAccepted': false},
    {'name': 'Panther2', 'location': 'Student Center East', 'isAccepted': false},
  ];

  void _acceptRequest(int index) {
    setState(() {
      requests[index]['isAccepted'] = true;
    });
  }

  void _openChat(BuildContext context, String buddyName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(buddyName: buddyName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy Requests'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(request['name']),
              subtitle: Text('Location: ${request['location']}'),
              trailing: request['isAccepted']
                  ? ElevatedButton(
                      onPressed: () => _openChat(context, request['name']),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Chat'),
                    )
                  : ElevatedButton(
                      onPressed: () => _acceptRequest(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 17, 56),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      )
                    ),
            ),
          );
        },
      ),
    );
  }
}