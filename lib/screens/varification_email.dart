import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mus3if/data/firebaseFanction/firebase_auth_function.dart';
import 'package:mus3if/screens/home_screen.dart';

class VarificationEmail extends StatefulWidget {
  const VarificationEmail({super.key});

  @override
  State<VarificationEmail> createState() => _VarificationState();
}

class _VarificationState extends State<VarificationEmail> {
  User? user;
  bool isEmailVarified = false;
  Timer? time;
  @override
  initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    checkVarification();
    time = Timer.periodic(Duration(seconds: 5), (_) => checkVarification());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    time?.cancel();
  }

  Future<void> checkVarification() async {
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;
    if (!mounted) return;
    setState(() {
      isEmailVarified = user?.emailVerified ?? false;
    });
    if (isEmailVarified) {
      time?.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(
          child: Text(
            'Varification Email',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child:
            isEmailVarified
                ? CircularProgressIndicator()
                : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning, color: Colors.red, size: 50),
                    SizedBox(height: 20),
                    Text(
                      'Your Email is not Verified Yet!',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await user?.sendEmailVerification();
                          FirebaseAuthFunction.showSnackBar(
                            context,
                            'Verification link send to your email.check inbox or spam',
                          );
                        } catch (e) {
                          FirebaseAuthFunction.showSnackBar(
                            context,
                            'Error Sending Email $e',
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
                        'Resend Verification Code',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
      ),
    );
  }
}
