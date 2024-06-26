import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_connection.dart';
import 'grade.dart';

class ApiService {
  static const String apiUrl = "http://192.168.68.106/API-ANDROIDAPP";
  
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(API.loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['success'];
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<List<Schedule>> fetchSchedule() async {
    final response = await http.get(Uri.parse(API.scheduleUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Schedule.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  Future<List<Grade>> fetchGrades() async {
    final response = await http.get(Uri.parse(API.gradesUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Grade.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load grades');
    }
  }

  Future<List<Student>> fetchStudentData() async {
    final response = await http.get(Uri.parse(API.studentData));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Student.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }

  Future<List<KhenStudyPlan>> fetchKhenStudyPlan() async {
    final response = await http.get(Uri.parse(API.khenStudyPlan));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => KhenStudyPlan.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load khen study plan');
    }
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
    return Student(
      age: int.parse(json['age'].toString()),
      name: json['name'] ?? '',
      yearLevel: json['year_level'] ?? '',
    );
  }
}

class KhenStudyPlan {
  final String courseCode;
  final String courseTitle;
  final int units;
  final int lec;
  final int lab;
  final String prerequisiteCorequisite;
  final String grade;

  KhenStudyPlan({
    required this.courseCode,
    required this.courseTitle,
    required this.units,
    required this.lec,
    required this.lab,
    required this.prerequisiteCorequisite,
    required this.grade,
  });

  factory KhenStudyPlan.fromJson(Map<String, dynamic> json) {
    return KhenStudyPlan(
      courseCode: json['courseCode'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      units: int.parse(json['units'].toString()),
      lec: int.parse(json['LEC'].toString()),
      lab: int.parse(json['LAB'].toString()),
      prerequisiteCorequisite: json['prerequisiteCorequisite'] ?? '',
      grade: json['grade'] ?? '',
    );
  }
}

class Schedule {
  final String subjectCode;
  final String section;
  final String description;
  final String day;
  final String from;
  final String to;
  final String room;
  final String faculty;
  final String blockNo;
  final String classType;

  Schedule({
    required this.subjectCode,
    required this.section,
    required this.description,
    required this.day,
    required this.from,
    required this.to,
    required this.room,
    required this.faculty,
    required this.blockNo,
    required this.classType,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      subjectCode: json['subjectCode'] ?? '',
      section: json['section'] ?? '',
      description: json['description'] ?? '',
      day: json['day'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      room: json['room'] ?? '',
      faculty: json['faculty'] ?? '',
      blockNo: json['blockNo'] ?? '',
      classType: json['classType'] ?? '',
    );
  }
}
