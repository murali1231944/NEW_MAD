import 'package:flutter/material.dart';

class ViewTimetable extends StatelessWidget {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  final List<String> times = [
    '9:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 1:00',
    '1:00 - 2:00',
    '2:00 - 3:00',
  ];
final List<List<String>> timetable = [
  ['DSA', 'OOP', 'Computer Networks', 'Break', 'OS', 'Web Dev'],
  ['DBMS', 'DSA', 'OOP', 'Break', 'Software Engg', 'UI/UX'],
  ['Computer Networks', 'OS', 'DSA', 'Break', 'OOP', 'Cyber Security'],
  ['Software Engg', 'DBMS', 'Web Dev', 'Break', 'DSA', 'OOP'],
  ['UI/UX', 'Cyber Security', 'Computer Networks', 'Break', 'OS', 'DSA'],
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Timetable'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Day')),
            ...times.map((t) => DataColumn(label: Text(t))),
          ],
          rows: List.generate(days.length, (i) {
            return DataRow(
              cells: [
                DataCell(Text(days[i])),
                ...timetable[i].map((subject) => DataCell(Text(subject))),
              ],
            );
          }),
        ),
      ),
    );
  }
}