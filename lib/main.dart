import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mus3if/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/local_storage/contact_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    final loadedContacts = await ContactStorage.loadContacts();

    if (loadedContacts.isEmpty) {
      contacts = List.from(defaultContacts);
      await ContactStorage.saveContacts(contacts);
    } else {
      contacts = loadedContacts;
    }
  } catch (e) {
    print('Error loading contacts: $e');
    contacts = List.from(defaultContacts);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mus3if',
      theme: ThemeData(
        primaryColor: const Color(0xFFDC2626),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home:  SplashScreen(),
    );
  }
}
