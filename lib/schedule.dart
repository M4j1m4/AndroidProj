import 'package:flutter/material.dart';
import 'api_service.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late Future<List<Schedule>> futureSchedule;

  @override
  void initState() {
    super.initState();
    futureSchedule = ApiService().fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UDM Schedule'),
        backgroundColor: Colors.green, // Set the app bar background color
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Schedule>>(
            future: futureSchedule,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final schedules = snapshot.data!;
                return _buildScheduleTable(schedules);
              } else {
                return const Center(child: Text('No schedule available'));
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleTable(List<Schedule> schedules) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Subject Code')),
          DataColumn(label: Text('Section')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('From')),
          DataColumn(label: Text('To')),
          DataColumn(label: Text('Room')),
          DataColumn(label: Text('Faculty')),
          DataColumn(label: Text('Block No')),
          DataColumn(label: Text('Class Type')),
        ],
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade200), // Set header row color
        dataRowColor: MaterialStateColor.resolveWith((states) => Colors.greenAccent.shade100), // Set data row color
        rows: schedules
            .map(
              (schedule) => DataRow(cells: [
                DataCell(Text(schedule.subjectCode)),
                DataCell(Text(schedule.section)),
                DataCell(Text(schedule.description)),
                DataCell(Text(schedule.day)),
                DataCell(Text(schedule.from)),
                DataCell(Text(schedule.to)),
                DataCell(Text(schedule.room)),
                DataCell(Text(schedule.faculty)),
                DataCell(Text(schedule.blockNo)),
                DataCell(Text(schedule.classType)),
              ]),
            )
            .toList(),
      ),
    );
  }
}
