

import 'package:flutter/material.dart';
import 'package:mus3if/data/firebaseFanction/firebase_auth_function.dart';
import 'package:mus3if/data/validation/form_validation.dart';
import 'package:mus3if/widgets/coustom_text_field_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'Forget Password',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Image(
                    image: AssetImage('assets/images/cpr.png'),
                    width: 80,
                    height: 80,
                  ),
                  Text(
                    ' Mus3if',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Enter Your Email To Reset Your Password: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 30),
              CoustomTextFieldWidget(
                textController: emailController,
                text: 'Enter your email',
                icon: Icon(Icons.email, color: Colors.red),
                valuValidation: FormValidation.emailValidation,
                // isfill: false,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseAuthFunction.resetPassword(
                        email: emailController.text.trim(),
                        context: context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF20D0D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
