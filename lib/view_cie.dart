import 'package:flutter/material.dart';

class ViewCiePage extends StatelessWidget {
  final int cie1Marks;
  final int cie1Total;
  final int cie2Marks;
  final int cie2Total;
  final int cie3Marks;
  final int cie3Total;
  final String courseName;

  const ViewCiePage({
    Key? key,
    required this.cie1Marks,
    required this.cie1Total,
    required this.cie2Marks,
    required this.cie2Total,
    required this.cie3Marks,
    required this.cie3Total,
    required this.courseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CIE Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              _buildCieRow('CIE 1', cie1Marks, cie1Total),
              _buildCieRow('CIE 2', cie2Marks, cie2Total),
              _buildCieRow('CIE 3', cie3Marks, cie3Total),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCieRow(String label, int marks, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            '$marks / $total',
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

