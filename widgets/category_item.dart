import 'package:Meal_app/screens/category_meals_Screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String categoryId;
  final String title;
  final Color color;

  CategoryItem(this.categoryId, this.title, this.color);
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': categoryId, 'title': title}
        //if the arguments  are wrong flutter does not produce an error
        /* MaterialPageRoute(builder: (_) {
            return CategoryMealsScreen(categoryId, title);
          }),*/
        );
    //classbuilt in to dart
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
              15), //cannpt use const check the defined calss
        ),
      ),
    ); //optimise using const no rebuild
  }
}

class DisplayedMealsScreen {}
