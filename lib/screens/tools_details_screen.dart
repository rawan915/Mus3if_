import 'package:flutter/material.dart';
import '../models/tools_model.dart';
import '../widgets/notes_widget.dart';

class ToolsDetailsScreen extends StatelessWidget {
  final ToolModel tool;
  const ToolsDetailsScreen({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(tool.name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  tool.imagePath,
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              tool.subtitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Description:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              tool.description,
              style: TextStyle(fontSize: 20, height: 1.4,color: Colors.grey[600]),
            ),
            SizedBox(height: 40),
            NotesWidget(tool: tool),
          ],
        ),
      ),
    );
  }
}

