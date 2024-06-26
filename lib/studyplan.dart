import 'package:androidproj/home.dart';
import 'package:androidproj/main.dart';
import 'package:androidproj/schedule.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'bot.dart';
import 'viewgrades.dart'; // Import the viewgrades.dart file

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
  late Future<List<Student>> futureStudentData;
  late Future<List<KhenStudyPlan>> futureKhenStudyPlan;

  @override
  void initState() {
    super.initState();
    futureStudentData = ApiService().fetchStudentData();
    futureKhenStudyPlan = ApiService().fetchKhenStudyPlan();
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
                const SizedBox(height: 20),
                _buildMenuItem(Icons.logout, 'LOGOUT'),
                const SizedBox(height: 20),
                _buildMenuItem(Icons.chat, 'CHATBOT'),
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
            } else if (title == 'HOME') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (title == 'SCHEDULE') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScheduleScreen()),
              );
            } else if (title == 'LOGOUT') {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
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
            child: ListView(
              children: [
                _buildFutureBuilder(futureStudentData, 'Student Information', true),
                _buildFutureBuilder(futureKhenStudyPlan, "SCHOOL YEAR:2023-2024 SEMESTER: 2ND", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFutureBuilder(Future future, String title, bool isStudentData) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (isStudentData) {
            final students = data as List<Student>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        child: ListTile(
                          title: Text(student.name),
                          subtitle: Text('Age: ${student.age}, Year Level: ${student.yearLevel}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            final studyPlans = data as List<KhenStudyPlan>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: studyPlans.length,
                    itemBuilder: (context, index) {
                      final plan = studyPlans[index];
                      return Card(
                        child: ListTile(
                          title: Text(plan.courseTitle),
                          subtitle: Text(
                            'Course Code: ${plan.courseCode}, Units: ${plan.units}, LEC: ${plan.lec}, LAB: ${plan.lab}, Prerequisite/Corequisite: ${plan.prerequisiteCorequisite}, Grade: ${plan.grade}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: Text('No study plan available'));
        }
      },
    );
  }
}
