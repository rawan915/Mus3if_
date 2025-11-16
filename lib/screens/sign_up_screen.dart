import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mus3if/data/firebaseFanction/firebase_auth_function.dart';
import 'package:mus3if/data/validation/form_validation.dart';
import 'package:mus3if/widgets/coustom_text_field_widget.dart';
import 'package:mus3if/widgets/image_picker_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  String? selectedBloodType;
  bool isChecked = false;
  XFile? _imageFile;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _onImageSelected(XFile? image) {
    setState(() {
      _imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: [
                ImagePickerWidget(
                  onImageSelected: _onImageSelected,
                  radius: 80.0,
                  cameraIconSize: 24.0,
                  backgroundColor: Color(0xFFFEE2E2),
                  iconColor: Color(0xFFDC2626),
                  initialImagePath: _imageFile?.path,
                ),
                SizedBox(height: 20),
                CoustomTextFieldWidget(
                  textController: nameController,
                  text: 'Full Name',
                  icon: Icon(Icons.person, color: Colors.red),
                  valuValidation: FormValidation.nameBloodValidation,
                ),
                SizedBox(height: 20),
                CoustomTextFieldWidget(
                  textController: emailController,
                  text: 'Email',
                  icon: Icon(Icons.email, color: Colors.red),
                  valuValidation: FormValidation.emailValidation,
                ),
                SizedBox(height: 20),
                CoustomTextFieldWidget(
                  textController: passwordController,
                  text: 'password',
                  icon: Icon(Icons.lock, color: Colors.red),
                  valuValidation: FormValidation.passwordValidation,
                  isObs: true,
                ),
                SizedBox(height: 20),
                CoustomTextFieldWidget(
                  isObs: true,
                  textController: confirmPasswordController,
                  text: 'Confirm Password',
                  icon: Icon(Icons.lock_outline, color: Colors.red),
                  valuValidation: (value) =>
                      FormValidation.confirmPasswordValidation(
                        value,
                        passwordController.text,
                      ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.bloodtype, color: Colors.red),
                    hintText: "Blood Type",
                    filled: true,
                    fillColor: Color.fromARGB(255, 254, 237, 237),
                  ),
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map(
                    (bloodType) {
                      return DropdownMenuItem(
                        value: bloodType,
                        child: Text(bloodType),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBloodType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your blood type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      icon: Icon(
                        isChecked
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isChecked ? Color(0xffF20D0D) : null,
                      ),
                    ),
                    Text('I agree to the ', style: TextStyle(fontSize: 15)),
                    const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: Color(0xffF20D0D),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (!isChecked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You must agree to Terms and Conditions',
                            ),
                          ),
                        );
                        return;
                      }

                      await FirebaseAuthFunction.SignUpWithPasswordAndEmail(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        fullName: nameController.text.trim(),
                        bloodType: selectedBloodType ?? "",
                        photoUrl: _imageFile?.path ?? "",
                        context: context,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF20D0D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 140),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        ' Log in',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF20D0D),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
