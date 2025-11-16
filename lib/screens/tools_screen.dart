import 'package:flutter/material.dart';
import 'package:mus3if/screens/tools_details_screen.dart';

import '../models/tools_model.dart';
import '../widgets/appbar_widget.dart';

class ToolsScreen extends StatelessWidget {
  final List<ToolModel> tools;
  const ToolsScreen({super.key, required this.tools});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'First Aid Kit'),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: tools.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 16, 
            mainAxisSpacing: 16, 
            childAspectRatio: 0.8, 
          ), 
          itemBuilder: (context,index){
            final tool = tools[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=> ToolsDetailsScreen(tool: tool,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          tool.imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tool.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          ),
        ),
    );
  }
}