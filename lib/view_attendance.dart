import 'package:flutter/material.dart';

class ViewAttendancePage extends StatelessWidget {
  final String courseName;
  final int attended;
  final int missed;

  const ViewAttendancePage({
    Key? key,
    required this.courseName,
    required this.attended,
    required this.missed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = attended + missed;
    double percentage = total > 0 ? (attended / total) * 100 : 0.0;

    return Scaffold(
      backgroundColor: Colors.indigo[900], // Navy blue background
      appBar: AppBar(
        title: Text('Attendance - $courseName'),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                courseName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('Attended', attended.toString(), Colors.green),
                  _buildStat('Missed', missed.toString(), Colors.red),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('Total', total.toString(), Colors.white),
                  _buildStat(
                    'Percentage',
                    '${percentage.toStringAsFixed(1)}%',
                    Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: valueColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
