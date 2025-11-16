
import 'package:flutter/material.dart';

class CoustomTextFieldWidget extends StatelessWidget {
  CoustomTextFieldWidget({
    super.key,
    required this.text,
    required this.icon,
    this.isObs = false,
    this.valuValidation,
    this.textController,
    this.isfill = true,
  });
  String? Function(String?)? valuValidation;
  final String text;
  final Widget icon;
  final bool isObs;
  final bool isfill;
  final TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: valuValidation,
      obscureText: isObs,
      decoration: InputDecoration(
        filled: isfill,
        fillColor: isfill ? Color.fromARGB(255, 254, 237, 237) : null,
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        hintText: text,
      ),
    );
  }
}
