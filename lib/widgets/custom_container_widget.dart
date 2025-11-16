import 'package:flutter/material.dart';
import '../data/tools_data.dart'; // Make sure this file exists
import '../screens/tools_screen.dart';

class CustomContainerWidget extends StatefulWidget {
  const CustomContainerWidget({super.key});

  @override
  State<CustomContainerWidget> createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  double _currentHeight = 275;

  void _startAnimationAndNavigate() {
    setState(() {
      _currentHeight = 300;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ToolsScreen(tools: firstAidItems),
        ),
      ).then((_) {
        setState(() {
          _currentHeight = 275;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'The most important tools in first aid',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: _startAnimationAndNavigate,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              height: _currentHeight,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/First-Aid-kit.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
