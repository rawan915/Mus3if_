import 'package:flutter/material.dart';
import 'package:mus3if/models/categories_model.dart';
import '../screens/details_screen.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel model;

  const CategoryWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Image.asset(
            model.imagePath,
            height: 60,
            width: 60,
            fit: BoxFit.fill,
          ),
          title: Text(
            model.categoryTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(model.categorySubTitle),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GuideDetailsScreen(jsonPath: model.jsonPath),
              ),
            );
          },
        ),
      ),
    );
  }
}
