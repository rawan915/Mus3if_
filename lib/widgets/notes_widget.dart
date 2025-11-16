import 'package:flutter/material.dart';

import '../models/tools_model.dart';

class NotesWidget extends StatelessWidget {
  const NotesWidget({
    super.key,
    required this.tool,
  });

  final ToolModel tool;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade700, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.red, size: 28),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  "Important Notes:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  tool.notes,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
                  ],
                ),),
        ],
      ),
    );
  }
}