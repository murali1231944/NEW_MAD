import 'package:flutter/material.dart';
import 'courses_data.dart';
import 'view_attendance.dart';
import 'view_cie.dart'; // <-- Import the CIE page

class ViewCoursesPage extends StatelessWidget {
  final String branch;
  final int semester;

  const ViewCoursesPage({
    Key? key,
    required this.branch,
    required this.semester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch courses based on branch and semester
    final courses = coursesData[branch]?[semester] ?? [];

    // Dummy attendance and CIE data for demonstration
    Map<String, Map<String, int>> attendanceData = {
      for (var course in courses) course: {'attended': 20, 'missed': 5},
    };
    Map<String, Map<String, int>> cieData = {
      for (var course in courses)
        course: {'cie1': 15, 'cie2': 18, 'cie3': 17}, // Replace with real data
    };

    return Scaffold(
      backgroundColor: Colors.indigo[900], // Navy blue background
      appBar: AppBar(
        title: Text('My Courses'),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body:
          courses.isEmpty
              ? Center(
                child: Text(
                  'No courses found for this semester and branch.',
                  style: TextStyle(color: Colors.white),
                ),
              )
              : ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  final courseName = course;

                  return StatefulBuilder(
                    builder: (context, setState) {
                      bool isAttendanceOpen = false;
                      bool isCieOpen = false;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            cardColor: Colors.blue[800],
                          ),
                          child: ExpansionTile(
                            collapsedBackgroundColor: Colors.blue[800],
                            backgroundColor: Colors.blue[800],
                            title: Text(
                              courseName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              // Attendance button that expands to show attendance data
                              ListTile(
                                title: const Text(
                                  'Attendance',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Icon(
                                  isAttendanceOpen
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    isAttendanceOpen = !isAttendanceOpen;
                                    if (isAttendanceOpen) isCieOpen = false;
                                  });
                                },
                              ),
                              if (isAttendanceOpen)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: ViewAttendancePage(
                                    courseName: courseName,
                                    attended:
                                        attendanceData[courseName]?['attended'] ??
                                        0,
                                    missed:
                                        attendanceData[courseName]?['missed'] ??
                                        0,
                                  ),
                                ),
                              // CIE button that expands to show CIE data
                              ListTile(
                                title: const Text(
                                  'CIE',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Icon(
                                  isCieOpen
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  setState(() {
                                    isCieOpen = !isCieOpen;
                                    if (isCieOpen) isAttendanceOpen = false;
                                  });
                                },
                              ),
                              if (isCieOpen)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: ViewCiePage(
                                    cie1Marks:
                                        cieData[courseName]?['cie1'] ?? 0,
                                    cie1Total: 20,
                                    cie2Marks:
                                        cieData[courseName]?['cie2'] ?? 0,
                                    cie2Total: 20,
                                    cie3Marks:
                                        cieData[courseName]?['cie3'] ?? 0,
                                    cie3Total: 20,
                                    courseName: courseName,
                                  ),
                                ),
                              ListTile(
                                title: const Text(
                                  'AAT',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  // Handle AAT tap
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
