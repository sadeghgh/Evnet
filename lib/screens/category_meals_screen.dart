import 'package:flutter/material.dart';

// import '../widgets/meal_item.dart';
// import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final appBarColor = routeArgs['color'];
    // final categoryMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("CategoryMealsScreen"),
          backgroundColor: appBarColor,
        ),
        body: Text("CategoryMealsScreen"));
  }
}
