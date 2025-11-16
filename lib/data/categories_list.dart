import 'package:mus3if/models/categories_model.dart';



final List<CategoryModel> categories = [
  CategoryModel(
    imagePath: 'assets/images/cpr.jpg',
    categoryTitle: 'CPR Guide',
    categorySubTitle: 'Cardiopulmonary Resuscitation',
    jsonPath: 'assets/guides/cpr.json',
  ),
  CategoryModel(
    imagePath: 'assets/images/burn.jpg',
    categoryTitle: 'Burns Guide',
    categorySubTitle: 'First Aid for Burns',
    jsonPath: 'assets/guides/burns.json',
  ),
  CategoryModel(
    imagePath: 'assets/images/fractures.jpg',
    categoryTitle: 'Fractures Guide',
    categorySubTitle: 'Managing Fractures',
    jsonPath: 'assets/guides/fractures.json',
  ),
  CategoryModel(
    imagePath: 'assets/images/bleeding.jpg',
    categoryTitle: 'Bleeding Guide',
    categorySubTitle: 'Controlling Severe Bleeding',
    jsonPath: 'assets/guides/bleeding.json',
  ),
  CategoryModel(
    imagePath: 'assets/images/choking.jpg',
    categoryTitle: 'Choking Guide',
    categorySubTitle: 'Helping Someone Who is Choking',
    jsonPath: 'assets/guides/choking.json',
  ),
];
