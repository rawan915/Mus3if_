import 'package:flutter/material.dart';
import 'package:mus3if/data/firebaseFanction/firebase_auth_function.dart';
import 'package:mus3if/data/validation/form_validation.dart';
import 'package:mus3if/screens/forget_password_screen.dart';
import 'package:mus3if/screens/sign_up_screen.dart';
import 'package:mus3if/widgets/coustom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
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
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text('Email', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                CoustomTextFieldWidget(
                  textController: emailController,
                  text: 'Enter your email',
                  icon: Icon(Icons.email, color: Colors.red),
                  valuValidation: FormValidation.emailValidation,
                ),
                SizedBox(height: 20),
                Text('Password', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                CoustomTextFieldWidget(
                  textController: passwordController,
                  text: 'Enter your password',
                  icon: Icon(Icons.lock, color: Colors.red),
                  isObs: true,
                  valuValidation: FormValidation.passwordValidation,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (Context) => ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FirebaseAuthFunction.LoginWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
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
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuthFunction.signInWithGoogle(
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
                      'Login With Google',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        ' Sign Up',
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
