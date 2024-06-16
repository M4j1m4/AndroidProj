import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // Hardcoded responses
  final Map<String, String> _responses = {
    'hi': 'Hello!',
    'how are you?': 'I am fine, thank you!',
    'bye': 'Goodbye!',
    'what is my name?': 'Khen Abesamis',
    'what is my grade in software design?': 'Your grade is 75',
    'gago ka ah': 'Gago kadin!',
  };

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    String userMessage = _controller.text.toLowerCase();
    setState(() {
      _messages.add({'text': _controller.text, 'sender': 'user'});
    });

    String botResponse = _responses[userMessage] ?? 'I don\'t understand that.';

    setState(() {
      _messages.add({'text': botResponse, 'sender': 'bot'});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]['text']!),
                  subtitle: Text(_messages[index]['sender']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
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
