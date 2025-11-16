import 'package:flutter/material.dart';
import 'package:mus3if/data/categories_list.dart';
import 'package:mus3if/widgets/appbar_widget.dart';
import 'package:mus3if/widgets/category_widget.dart';
import 'package:mus3if/widgets/help_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      throw Exception("Could not launch $phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: 'Your Safety, Our Priority'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryWidget(model: categories[index]);
                },
              ),
            ),
            HelpButton(makePhoneCall: _makePhoneCall),
          ],
        ),
      ),
    );
  }
}
