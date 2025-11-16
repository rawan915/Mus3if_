import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/medical_info_card.dart';
import '../widgets/emergency_contacts_card.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic> _userData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          _userData = {
            'uid': data['uid'] ?? currentUser!.uid,
            'fullName': data['fullName'] ?? 'Unknown User',
            'bloodType': data['bloodType'] ?? 'Not set',
            'photoUrl': data['photoUrl'] ?? '',
          };
          _isLoading = false;
        });
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .set({
              'uid': currentUser!.uid,
              'fullName': currentUser?.displayName ?? 'Unknown User',
              'bloodType': '',
              'photoUrl': '',
              'createdAt': FieldValue.serverTimestamp(),
            });

        setState(() {
          _userData = {
            'uid': currentUser!.uid,
            'fullName': currentUser?.displayName ?? 'Unknown User',
            'bloodType': '',
            'photoUrl': '',
          };
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _isLoading = false;
        _userData = {'fullName': 'Error loading data', 'bloodType': 'Error'};
      });
    }
  }

  void _refreshData() {
    setState(() {
      _isLoading = true;
    });
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        appBar: AppBarWidget(title: 'Profile'),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFDC2626)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBarWidget(title: 'Profile'),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              ProfileHeaderWidget(userData: _userData),
              SizedBox(height: 24),
              MedicalInfoCard(
                bloodType: _userData['bloodType'] ?? 'Not set',
                fullName: _userData['fullName'] ?? 'Unknown User',
              ),
              SizedBox(height: 24),
              EmergencyContactsCard(),
              SizedBox(height: 24),
              ProfileActionsWidget(onProfileUpdated: _refreshData),
            ],
          ),
        ),
      ),
    );
  }
}
