import 'package:Meal_app/dummy_data.dart';
import 'package:Meal_app/models/meal.dart';
import 'package:Meal_app/screens/category_meals_Screen.dart';
import 'package:Meal_app/screens/filter_screens.dart';
import 'package:Meal_app/screens/meal_detail_screen.dart';
import 'package:Meal_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'screens/categories_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeal = [];

  void _setFilter(Map<String, bool> filterdata) {
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false; //if not wanted the item
          //the _filters used here is the filter switch in the categories screen
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false; //if not wanted the item
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false; //if not wanted the item
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false; //if not wanted the item
        }
        return true; //keep the meal
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex =
        _favouriteMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      //if not part index = -1
      setState(() {
        _favouriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeal.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favouriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      //home: CategoriesScreen(),
      //starting page
      //initialRoute: '/', //if you dont want defalt load as '/' you can set here
      routes: {
        '/': (ctx) =>
            TabScreen(_favouriteMeal), //error shown since home is defined
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilter),
      },
      onGenerateRoute: (settings) {
        // for not registered routes you go below mentioned
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      }, //last line measure flutter uses unknown route like 404 page in websites
    );
  }
}
