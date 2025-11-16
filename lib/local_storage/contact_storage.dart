import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mus3if/models/emergancy_contact.dart';

class ContactStorage {
  static const String _contactsKey = 'emergency_contacts';

  static Future<void> saveContacts(List<EmergencyContact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> contactsJson = contacts.map((contact) {
      return {
        'name': contact.name,
        'phoneNumber': contact.phoneNumber,
        'alternatePhone': contact.alternatePhone,
        'relationship': contact.relationship,
        'specialty': contact.specialty,
        'location': contact.location,
        'schedule': contact.schedule,
        'type': contact.type,
        'scheduleUrl': contact.scheduleUrl,
        'studentScheduleUrl': contact.studentScheduleUrl,
      };
    }).toList();

    await prefs.setString(_contactsKey, jsonEncode(contactsJson));
  }

  static Future<List<EmergencyContact>> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? contactsString = prefs.getString(_contactsKey);

    if (contactsString == null || contactsString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> contactsJson = jsonDecode(contactsString);

      return contactsJson.map((json) {
        return EmergencyContact(
          name: json['name'] as String,
          phoneNumber: json['phoneNumber'] as String,
          alternatePhone: json['alternatePhone'] as String?,
          relationship: json['relationship'] as String?,
          specialty: json['specialty'] as String?,
          location: json['location'] as String?,
          schedule: json['schedule'] as String?,
          type: json['type'] as String,
          scheduleUrl: json['scheduleUrl'] as String?,
          studentScheduleUrl: json['studentScheduleUrl'] as String?,
        );
      }).toList();
    } catch (e) {
      debugPrint('Error loading contacts: $e');
      return [];
    }
  }

  static Future<void> deleteContact(
    List<EmergencyContact> contacts,
    EmergencyContact contactToDelete,
  ) async {
    contacts.removeWhere(
      (c) =>
          c.name == contactToDelete.name &&
          c.phoneNumber == contactToDelete.phoneNumber,
    );
    await saveContacts(contacts);
  }

  static Future<void> clearAllContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_contactsKey);
  }
}
