import 'package:flutter/material.dart';
import 'package:mus3if/screens/emergency_contacts_screen.dart';

class EmergencyContactsCard extends StatelessWidget {
  const EmergencyContactsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmergencyContactsScreen()),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.contacts, color: Color(0xFFDC2626), size: 24),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Manage your emergency contacts",
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Color(0xFF64748B), size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
