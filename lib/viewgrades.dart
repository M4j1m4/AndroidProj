import 'package:flutter/material.dart';
import 'api_service.dart';
import 'grade.dart';

class ViewGradesScreen extends StatefulWidget {
  @override
  _ViewGradesScreenState createState() => _ViewGradesScreenState();
}

class _ViewGradesScreenState extends State<ViewGradesScreen> {
  late Future<List<Grade>> futureGrades;

  @override
  void initState() {
    super.initState();
    futureGrades = ApiService().fetchGrades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Grade>>(
        future: futureGrades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No grades available'));
          } else {
            final grades = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                Grade grade = grades[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          grade.subjectCode,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          grade.description,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Units: ${grade.units}'),
                            Text('Prelim: ${grade.prelim}'),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Midterm: ${grade.midterm}'),
                            Text('Prefinals: ${grade.prefinals}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}