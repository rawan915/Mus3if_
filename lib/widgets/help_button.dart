import 'package:flutter/material.dart';
import 'options_dialog.dart';

class HelpButton extends StatelessWidget {
  final Future<void> Function(String) makePhoneCall;

  const HelpButton({super.key, required this.makePhoneCall});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () {
        showOptionsDialog(context, makePhoneCall);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.phone, color: Colors.white),
            SizedBox(width: 20),
            Text("Call For Help", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
