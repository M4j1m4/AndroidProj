import 'package:androidproj/studyplan.dart';
import 'package:flutter/material.dart';
import 'bot.dart';
import 'viewgrades.dart';
import 'schedule.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDM Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UDM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(child: _buildMainContent(context)),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.green[700],
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 30, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(context, Icons.home, 'HOME'),
                _buildMenuItem(context, Icons.school, 'STUDY'),
                _buildMenuItem(context, Icons.schedule, 'SCHEDULE'),
                _buildMenuItem(context, Icons.grade, 'GRADES'),
                const SizedBox(height: 20),
                _buildMenuItem(context, Icons.logout, 'LOGOUT'),
                const SizedBox(height: 20),
                _buildMenuItem(context, Icons.chat, 'CHATBOT'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 24),
          onPressed: () {
            if (title == 'GRADES') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewGradesScreen()),
              );
            } else if (title == 'CHATBOT') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            } else if (title == 'STUDY') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GradeViewerScreen()),
              );
            } else if (title == 'SCHEDULE') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScheduleScreen()),
              );
            }
          },
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 10),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      color: Colors.green[50],
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Important Announcement',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Attention Students!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Upcoming Events:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  '1. School Fair: May 15-17, 2024',
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  '2. Final Exams: June 3-7, 2024',
                  style: TextStyle(fontSize: 14),
                ),
                const Text(
                  '3. Project Defense: June 10-14, 2024',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please prepare accordingly and don\'t hesitate to reach out to your advisors if you need any assistance.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality for "Learn More" button if needed
                  },
                  child: const Text(''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}