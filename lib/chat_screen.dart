import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Initialize the socket
  IO.Socket socket = IO.io('http://localhost:3000');

  // Text controller for the message input field
  final messageController = TextEditingController();

  // List to store messages
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    // Listen for new messages
    socket.on('new message', (data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          // ListView to display messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          // Input field and send button
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  child: const Text('Send'),
                  onPressed: () {
                    // Send message to the server
                    socket.emit('new message', messageController.text);
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
