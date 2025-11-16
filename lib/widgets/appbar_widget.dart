import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
const AppBarWidget({
    super.key,
    required this.title, 
  });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize, // AppBar height
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        alignment: Alignment.center,
        child: SafeArea(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80);
}
