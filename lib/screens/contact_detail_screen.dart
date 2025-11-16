import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/models/emergancy_contact.dart';
import 'package:mus3if/local_storage/contact_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailScreen extends StatelessWidget {
  final EmergencyContact contact;

  const ContactDetailScreen({super.key, required this.contact});

  Future<void> _callNumber(String phone) async {
    if (phone == "N/A" || phone.isEmpty) return;

    String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri url = Uri(scheme: "tel", path: cleanedPhone);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {}
  }

  Future<void> _openUrl(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {}
  }

  Future<void> _deleteContact(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Contact"),
          content: Text("Are you sure you want to delete ${contact.name}?"),
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

    if (confirmed == true && context.mounted) {
      try {
        contacts.removeWhere(
          (c) => c.name == contact.name && c.phoneNumber == contact.phoneNumber,
        );

        await ContactStorage.saveContacts(contacts);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${contact.name} deleted successfully!"),
              backgroundColor: const Color(0xFF16A34A),
              duration: Duration(seconds: 2),
            ),
          );

          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error deleting contact: $e"),
              backgroundColor: Color(0xFFDC2626),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Contact Details"),
      backgroundColor: Color(0xFFDC2626),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteContact(context),
          tooltip: "Delete Contact",
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          SizedBox(height: 24),
          if (contact.phoneNumber != "N/A") ...[
            _buildPhoneSection("Primary Phone", contact.phoneNumber),
            SizedBox(height: 16),
          ],
          if (contact.alternatePhone != null) ...[
            _buildPhoneSection("Alternate Phone", contact.alternatePhone!),
            SizedBox(height: 16),
          ],
          if (contact.location != null) ...[
            _buildInfoSection(Icons.location_on, "Location", contact.location!),
            SizedBox(height: 16),
          ],
          if (contact.schedule != null) ...[
            _buildInfoSection(Icons.schedule, "Schedule", contact.schedule!),
            SizedBox(height: 16),
          ],
          if (contact.scheduleUrl != null) ...[
            _buildUrlSection("General Schedule", contact.scheduleUrl!),
            SizedBox(height: 16),
          ],
          if (contact.studentScheduleUrl != null) ...[
            _buildUrlSection("Student Schedule", contact.studentScheduleUrl!),
            SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFFDC2626).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForType(contact.type),
                color: Color(0xFFDC2626),
                size: 30,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (contact.specialty != null)
                    Text(
                      contact.specialty!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  if (contact.relationship != null)
                    Text(
                      contact.relationship!,
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSection(String title, String phoneNumber) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              phoneNumber,
              style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _callNumber(phoneNumber),
                icon: Icon(Icons.call, size: 20),
                label: Text("Call"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDC2626),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String content) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: Color(0xFFDC2626)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlSection(String title, String url) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openUrl(url),
                icon: Icon(Icons.open_in_new),
                label: Text("View Schedule"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color(0xFFDC2626),
                  side: BorderSide(color: Color(0xFFDC2626)),
                ),
              ),
            ),
          ],
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
