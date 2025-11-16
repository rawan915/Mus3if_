import 'package:flutter/material.dart';
import 'package:mus3if/models/emergancy_contact.dart';

class ContactCard extends StatelessWidget {
  final EmergencyContact contact;
  final VoidCallback onTap;
  final VoidCallback onCall;
  final VoidCallback? onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onTap,
    required this.onCall,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (onDelete != null) {
      return Dismissible(
        key: Key('${contact.name}_${contact.phoneNumber}'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Color(0xFFDC2626),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(Icons.delete, color: Colors.white, size: 32),
        ),
        confirmDismiss: (direction) async {
          return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Delete Contact"),
                content: Text(
                  "Are you sure you want to delete ${contact.name}?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDC2626),
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Delete"),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          onDelete!();
        },
        child: _buildCard(),
      );
    }

    return _buildCard();
  }

  Widget _buildCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFDC2626).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIconForType(contact.type),
                  color: Color(0xFFDC2626),
                  size: 24,
                ),
              ),
              SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    if (contact.specialty != null)
                      Text(
                        contact.specialty!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFDC2626),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    SizedBox(height: 4),
                    Text(
                      contact.phoneNumber,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ),

              if (contact.phoneNumber != "N/A")
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFDC2626),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.call, color: Colors.white, size: 20),
                    onPressed: onCall,
                    padding: EdgeInsets.zero,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'doctor':
        return Icons.medical_services;
      case 'hospital':
        return Icons.local_hospital;
      default:
        return Icons.person;
    }
  }
}
