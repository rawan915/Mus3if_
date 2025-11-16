import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mus3if/screens/home_screen.dart';
import 'package:mus3if/screens/varification_email.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFunction {
  static Future<void> SignUpWithPasswordAndEmail({
    required String email,
    required String password,
    required BuildContext context,
    required String fullName,
    required String bloodType,
    String photoUrl = "",
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFDC2626)),
      ),
    );

    try {
      print('Starting signup...');

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print('User created: ${credential.user!.uid}');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'uid': credential.user!.uid,
            'email': email,
            'fullName': fullName,
            'bloodType': bloodType,
            'photoUrl': photoUrl,
            'createdAt': FieldValue.serverTimestamp(),
          });

      print(' Data saved to Firestore');

      await credential.user?.sendEmailVerification();

      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      showSnackBar(context, 'Sign Up Success! Please verify your email.');

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VarificationEmail()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = e.message ?? 'An error occurred.';
      }

      showSnackBar(context, errorMessage);
    } catch (e) {
      print(' Error: $e');
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      showSnackBar(context, 'Sign up failed: $e');
    }
  }

  static Future<void> LoginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null && credential.user!.emailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        showSnackBar(context, 'Login Success!');
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VarificationEmail()),
        );
        await credential.user?.sendEmailVerification();
        showSnackBar(context, 'Please verify your email first.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid email or password.');
      } else {
        showSnackBar(context, e.message ?? 'Authentication failed: ${e.code}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      FirebaseAuthFunction.showSnackBar(
        context,
        'Password reset link sent! Check your Email',
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid email or password.');
      } else {
        showSnackBar(context, e.message ?? 'Authentication failed: ${e.code}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<UserCredential?> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        showSnackBar(context, 'SignIn Canceled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      showSnackBar(context, 'Error: $e');
      return null;
    }
  }

  static void showSnackBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Message),
        backgroundColor: Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
