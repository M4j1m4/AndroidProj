import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_connection.dart';

class StudyPlan {
  final String title;
  final String description;
  final List<Student> students;

  StudyPlan({
    required this.title,
    required this.description,
    required this.students,
  });

  factory StudyPlan.fromJson(Map<String, dynamic> json) {
    final List<dynamic> studentsData = json['students'];
    final students = studentsData.map((studentData) => Student.fromJson(studentData)).toList();

    return StudyPlan(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      students: students,
    );
  }
}

class Student {
  final int age;
  final String name;
  final String yearLevel;

  Student({
    required this.age,
    required this.name,
    required this.yearLevel,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    int? age;
    try {
      age = int.parse(json['age'].toString());
    } catch (e) {
      age = 0;
    }

    return Student(
      age: age,
      name: json['name'] ?? '',
      yearLevel: json['year_level'] ?? '',
    );
  }
}

class ApiService {
  Future<StudyPlan> fetchStudyPlan() async {
    final response = await http.get(Uri.parse(API.studentData));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final studentsData = data.cast<Map<String, dynamic>>();
      final students = studentsData.map((studentData) => Student.fromJson(studentData)).toList();

      return StudyPlan(
        title: 'Study Plan',
        description: 'Student Data',
        students: students,
      );
    } else {
      throw Exception('Failed to load study plan');
    }
  }

  Future<StudyPlan> fetchKhenStudyPlan() async {
    final response = await http.get(Uri.parse(API.khenStudyPlan));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Student> students = data.map((item) => Student.fromJson(item)).toList();

      return StudyPlan(
        title: 'Khen Study Plan', // Adjusted title for clarity
        description: 'Khen Study Plan Data', // Adjusted description for clarity
        students: students,
      );
    } else {
      throw Exception('Failed to load khen study plan');
    }
  }
}
