import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mus3if/widgets/coustom_text_field_widget.dart';
import 'package:mus3if/widgets/image_picker_widget.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _bloodTypeController;
  bool _isLoading = true;
  bool _isSaving = false;
  XFile? _imageFile;
  String? _currentPhotoUrl;

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (doc.exists) {
        setState(() {
          _nameController.text = doc['fullName'] ?? '';
          _bloodTypeController = doc['bloodType'] ?? '';
          _currentPhotoUrl = doc['photoUrl'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onImageSelected(XFile? image) {
    setState(() {
      _imageFile = image;
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      try {
        final updateData = {
          'fullName': _nameController.text.trim(),
          'bloodType': _bloodTypeController ?? '',
          'updatedAt': FieldValue.serverTimestamp(),
        };

        String? photoUrlToSave;

        if (_imageFile != null) {
          photoUrlToSave = _imageFile!.path;
        } else if (_currentPhotoUrl != null &&
            _currentPhotoUrl!.startsWith('http')) {
          photoUrlToSave = _currentPhotoUrl;
        }

        if (photoUrlToSave != null) {
          updateData['photoUrl'] = photoUrlToSave;
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .update(updateData);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Color(0xFF16A34A),
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating profile: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSaving = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFDC2626)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        actions: [
          if (_isSaving)
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
            )
          else
            IconButton(icon: Icon(Icons.save), onPressed: _saveProfile),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              ImagePickerWidget(
                onImageSelected: _onImageSelected,
                initialImagePath: _currentPhotoUrl,
                radius: 60.0,
                cameraIconSize: 15.0,
                backgroundColor: Color(0xFFFEE2E2),
                iconColor: Color(0xFFDC2626),
              ),
              SizedBox(height: 30),
              CoustomTextFieldWidget(
                textController: _nameController,
                text: 'Full Name',
                icon: Icon(Icons.person, color: Color(0xFFDC2626)),
                valuValidation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _bloodTypeController?.isNotEmpty == true
                    ? _bloodTypeController
                    : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.bloodtype, color: Color(0xFFDC2626)),
                  hintText: "Blood Type",
                  filled: true,
                  fillColor: Color.fromARGB(255, 254, 237, 237),
                ),
                items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map((
                  bloodType,
                ) {
                  return DropdownMenuItem(
                    value: bloodType,
                    child: Text(bloodType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _bloodTypeController = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your blood type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: _isSaving
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
