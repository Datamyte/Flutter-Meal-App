import 'package:Meal_app/models/meal.dart';
import 'package:Meal_app/screens/categories_Screen.dart';
import 'package:Meal_app/screens/favourites_screen.dart';
import 'package:Meal_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import './categories_Screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabScreen(this.favoriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>>
      _pages; //cannot use the widget. while inetialising so its done in init.

  int _selectedPageIndex = 0; //invalid argument error upon not inititaing
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'categories'},
      {'page': FavouriteScreen(widget.favoriteMeals), 'title': 'favourites'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        //type: BottomNavigationBarType.shifting,
        //additional info saying which is active and giving it some color
        items: [
          BottomNavigationBarItem(
            //  backgroundColor: Theme.of(context).primaryColor,
            //need to add this when using shifting
            icon: Icon(Icons.category),
            label: 'categories',
          ),
          BottomNavigationBarItem(
            //backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'favourites',
          ),
        ],
      ),

      /* bottom: TabBar(
          //there are alot of things that can be configured
          tabs: [
            Tab(
              icon: Icon(Icons.category),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(
                Icons.star,
              ),
              text: 'favourites',
            )
          ],
        ),
      ),
      body: TabBarView(
        children: [
          CategoriesScreen(),
          FavouriteScreen(),
        ],*/
    );
    //2ways to add tabs
  }
}
