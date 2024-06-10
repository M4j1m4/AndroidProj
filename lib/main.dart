import 'package:flutter/material.dart';
import 'api_service.dart'; // Ensure you import your service file

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDM Grade Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const GradeViewerScreen(),
    );
  }
}

class GradeViewerScreen extends StatefulWidget {
  const GradeViewerScreen({Key? key}) : super(key: key);

  @override
  _GradeViewerScreenState createState() => _GradeViewerScreenState();
}

class _GradeViewerScreenState extends State<GradeViewerScreen> {
  late Future<StudyPlan> futureStudyPlan;

  @override
  void initState() {
    super.initState();
    futureStudyPlan = ApiService().fetchStudyPlan();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UDM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(child: _buildMainContent(context, screenSize)),
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
                _buildMenuItem(Icons.home, 'HOME'),
                _buildMenuItem(Icons.school, 'STUDY'),
                _buildMenuItem(Icons.schedule, 'SCHEDULE'),
                _buildMenuItem(Icons.grade, 'GRADES'),
                const Spacer(),
                _buildMenuItem(Icons.logout, 'LOGOUT'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white, size: 24),
          onPressed: () {},
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

  Widget _buildMainContent(BuildContext context, Size screenSize) {
    return Container(
      color: Colors.green[50],
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.green[100],
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'STUDY PLAN\n(Prelim, Midterm, Pre-Final, or Finals)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 10),
                Image.network(
                  'https://example.com/robot-icon.png',
                  width: 30,
                  height: 30,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 30),
                ),
              ],
            ),
          ),
        Expanded(
          child: Center(
            child: FutureBuilder<StudyPlan>(
              future: futureStudyPlan,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final studyPlan = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                            itemCount: studyPlan.students.length,
                            itemBuilder: (context, index) {
                              final student = studyPlan.students[index];
                              return Card(
                                child: ListTile(
                                  title: Text(student.name),
                                  subtitle: Text('Age: ${student.age}, Year Level: ${student.yearLevel}'),
                                ),
                              );
                            },
                          )
                  );
                } else {
                  return const Text('No study plan available');
                }
              },
            ),
          ),
        ),
      ],
    ),
  );
}
}
