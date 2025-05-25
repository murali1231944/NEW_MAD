import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'view_timetable.dart';
import 'view_courses.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String userBranch = '';
  int userSemester = 1;
  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection(
                'students',
              ) // Use 'students' if that's your collection
              .doc(user.uid)
              .get();
      setState(() {
        userName = doc.data()?['name'] ?? user.email ?? 'User';
        userBranch = doc.data()?['branch'] ?? '';
        userSemester = doc.data()?['semester'] ?? 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900], // Navy background
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0,
        toolbarHeight: 0, // Hide default AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Header section with sky blue background and greeting
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              color: Colors.lightBlue[300], // Sky blue
              child: Center(
                child: Text(
                  'Hi, $userName',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Buttons below the header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _HomeOption(
                  icon: Icons.book,
                  label: 'Courses',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ViewCoursesPage(
                              branch:
                                  userBranch, // Replace with actual branch variable
                              semester:
                                  userSemester, // Replace with actual semester variable
                            ),
                      ),
                    );
                  },
                ),
                _HomeOption(
                  icon: Icons.schedule,
                  label: 'Timetable',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewTimetable()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.blueAccent,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            iconSize: 40,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
