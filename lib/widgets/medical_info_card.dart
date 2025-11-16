import 'package:flutter/material.dart';

class MedicalInfoCard extends StatelessWidget {
  final String fullName;
  final String bloodType;
  //final String Email;

  const MedicalInfoCard({
    super.key,
    //required this.Email,
    required this.bloodType,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified_user, color: Color(0xFFDC2626)),
                SizedBox(width: 12),
                Text(
                  "User Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.person, "User Name", fullName),
            SizedBox(height: 12),
            // _buildInfoRow(Icons.email, "Email", Email),
            // SizedBox(height: 12),
            _buildInfoRow(Icons.bloodtype, "Blood Type", bloodType),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Color(0xFF64748B)),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
