import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mus3if/widgets/image_picker_widget.dart';
import 'package:mus3if/screens/login_screen.dart';
import 'package:mus3if/screens/edit_profile_screen.dart';

class ProfileWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onProfileUpdated;

  ProfileWidget({
    super.key,
    required this.userData,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeaderWidget(userData: userData),
        SizedBox(height: 24),
        ProfileActionsWidget(onProfileUpdated: onProfileUpdated),
      ],
    );
  }
}

class ProfileHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileHeaderWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final fullName = userData['fullName'] ?? 'Unknown User';
    final bloodType = userData['bloodType']?.isNotEmpty == true
        ? userData['bloodType']
        : 'Not set';
    final photoUrl = userData['photoUrl'];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ImagePickerWidget(
            onImageSelected: (image) {},
            initialImagePath: photoUrl,
            radius: 50.0,
            cameraIconSize: 0,
            backgroundColor: Color(0xFFFEE2E2),
            iconColor: Color(0xFFDC2626),
            readOnly: true,
          ),
          SizedBox(height: 16),
          Text(
            fullName,
            maxLines: 1,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Blood Type: $bloodType",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFDC2626),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileActionsWidget extends StatelessWidget {
  final VoidCallback onProfileUpdated;

  ProfileActionsWidget({super.key, required this.onProfileUpdated});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );

              if (result == true) {
                onProfileUpdated();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Text("Edit Profile"),
          ),
        ),
        SizedBox(height: 16),
        LogoutButton(
          onLogout: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  LogoutButton({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          final shouldLogout = await showLogoutDialog(context);
          if (shouldLogout == true) {
            onLogout();
          }
        },
        icon: Icon(Icons.logout),
        label: Text(
          "Log Out",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red.shade800,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),
    );
  }
}

Future<bool?> showLogoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Log Out'),
      content: Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Log Out', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
