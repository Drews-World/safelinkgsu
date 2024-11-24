import 'package:flutter/material.dart';

class CarpoolChatScreen extends StatefulWidget {
  final String chatRoomId;

  const CarpoolChatScreen({super.key, required this.chatRoomId});

  @override
  _CarpoolChatScreenState createState() => _CarpoolChatScreenState();
}

class _CarpoolChatScreenState extends State<CarpoolChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = []; // Dummy list for chat messages

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room: ${widget.chatRoomId}'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _messages[index],
                    textAlign: TextAlign.right, 
                  ),
                );
              },
            ),
          ),
          // Input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}