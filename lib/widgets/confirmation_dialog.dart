import 'package:flutter/material.dart';

Future<void> showConfirmationDialog(
    BuildContext context, String service, String phoneNumber, Future<void> Function(String) makePhoneCall) {
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        title: const Text(
          "Confirm Call",
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          "Are you sure you want to call $service?",
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              makePhoneCall(phoneNumber);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              "Call",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
