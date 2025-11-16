import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuideDetailsScreen extends StatefulWidget {
  final String jsonPath;

  const GuideDetailsScreen({super.key, required this.jsonPath});

  @override
  State<GuideDetailsScreen> createState() => _GuideDetailsScreenState();
}

class _GuideDetailsScreenState extends State<GuideDetailsScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  String title = "";
  List steps = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadJson();
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString(widget.jsonPath);
    final data = jsonDecode(response);

    setState(() {
      title = data["title"];
      steps = data["steps"];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Loading...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.red),
      ),
      body: Column(
        children: [
          //  Step progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step ${currentIndex + 1} of ${steps.length}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / steps.length,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.red),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final step = steps[index];
                final isActive = index == currentIndex;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isActive ? Colors.red.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isActive ? Colors.red : Colors.grey.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor:
                          isActive ? Colors.red : Colors.grey.shade400,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          step["title"],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isActive ? Colors.red.shade800 : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          step["description"],
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Next / Done button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (currentIndex == steps.length - 1) {
                  Navigator.pop(context);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                currentIndex == steps.length - 1 ? "Done" : "Next",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
