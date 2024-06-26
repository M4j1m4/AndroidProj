import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];

  // Hardcoded responses
  final Map<String, String> _responses = {
    'How do i view my schedule?': 'You can click the schedule button at the left of the screen inside the navigation panel',
    'Where do i see the recent announcements': 'You can click the home button at the left of the screen inside the navigation panel',
    'What is my grade in software engineering': 'Your grade is 95',
    'What is my grade in technopreneurship?': 'Your grade is 90',
    'What is my grade in CPE LAWS, CONTRACTS, ETHICS & PROF PRACTICE?': 'Your grade is 93',
    'What is my grade in SOFTWARE ENGINEERING?': 'Your grade is 95',
    'What is my grade in software design?': 'Your grade is 94',
    'What is my grade in Microprocessor & Microcontroller Systems?': 'Your grade is 96',
    'What is my grade in COMPUTER NETWORKS & SECURITY?': 'Your grade is 94',

  };

  @override
  void initState() {
    super.initState();
    // Initialize _messages as an empty list
    _messages.clear();
  }

  void _handleMessageTap(String message) {
    String botResponse = _responses[message] ?? 'I don\'t understand that.';
    setState(() {
      _messages.add({'text': message, 'sender': 'user'});
      _messages.add({'text': botResponse, 'sender': 'bot'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFORMATION HUB'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.greenAccent, Color.fromARGB(255, 178, 219, 179)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true, // Reverse the list to show latest messages at the bottom
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      bool isUser = _messages[index]['sender'] == 'user';
                      return GestureDetector(
                        onTap: () {
                          if (isUser) {
                            _handleMessageTap(_messages[index]['text']!);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: isUser ? Colors.green[200] : Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _messages[index]['text']!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _messages[index]['sender']!,
                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 150, // Adjust height as needed
                  child: ListView.builder(
                    itemCount: _responses.length,
                    itemBuilder: (context, index) {
                      var key = _responses.keys.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          _handleMessageTap(key);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            key,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
