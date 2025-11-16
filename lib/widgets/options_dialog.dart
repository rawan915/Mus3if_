import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'confirmation_dialog.dart';

Future<void> showOptionsDialog(BuildContext context, Future<void> Function(String) makePhoneCall) {
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return SimpleDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: Colors.red, width: 2),
        ),
        title: const Text(
          "Choose a service ",
          style: TextStyle(fontSize: 25, color: Colors.black),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConfirmationDialog(context, "Ambulance", "123", makePhoneCall);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Ambulance", style: TextStyle(fontSize: 20, color: Colors.black)),
                Icon(FontAwesomeIcons.truckMedical, color: Colors.red, size: 20),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConfirmationDialog(context, "Firefighters", "180", makePhoneCall);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Firefighters", style: TextStyle(fontSize: 20, color: Colors.black)),
                Icon(FontAwesomeIcons.fireExtinguisher, color: Colors.orange, size: 20),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.of(ctx).pop();
              showConfirmationDialog(context, "Police", "122", makePhoneCall);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Police", style: TextStyle(fontSize: 20, color: Colors.black)),
                Icon(Icons.local_police, color: Colors.blue, size: 20),
              ],
            ),
          ),
        ],
      );
    },
  );
}
