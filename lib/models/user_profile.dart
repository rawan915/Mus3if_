import 'package:mus3if/models/emergancy_contact.dart';

class UserProfile {
  final String name;
  final String bloodType;
  final String allergies;
  final List<EmergencyContact> contacts;

  UserProfile({
    required this.name,
    required this.bloodType,
    required this.allergies,
    required this.contacts,
  });
}
