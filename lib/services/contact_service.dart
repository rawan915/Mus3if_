import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactService {
  static const String typePersonal = 'personal';
  static const String typeDoctor = 'doctor';
  static const String typeHospital = 'hospital';

  static const Color colorPrimary = Color(0xFFDC2626);
  static const Color colorSuccess = Color(0xFF16A34A);
  static const Color colorError = Color(0xFFDC2626);

  static final List<Map<String, dynamic>> contactTypes = [
    {'value': typePersonal, 'label': 'Personal Contact'},
    {'value': typeDoctor, 'label': 'Doctor'},
    {'value': typeHospital, 'label': 'Hospital'},
  ];

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? getOptionalValue(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  static String getContactTypeLabel(String type) {
    switch (type) {
      case typePersonal:
        return 'Personal Contact';
      case typeDoctor:
        return 'Doctor';
      case typeHospital:
        return 'Hospital';
      default:
        return 'Unknown';
    }
  }

  static IconData getContactTypeIcon(String type) {
    switch (type) {
      case typePersonal:
        return Icons.person;
      case typeDoctor:
        return Icons.medical_services;
      case typeHospital:
        return Icons.local_hospital;
      default:
        return Icons.contact_phone;
    }
  }

  static Future<void> makePhoneCall(String phone) async {
    if (phone == "N/A" || phone.isEmpty) return;

    String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri url = Uri(scheme: "tel", path: cleanedPhone);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {}
  }

  static Future<void> openUrl(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {}
  }
}
