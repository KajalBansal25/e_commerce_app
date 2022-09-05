// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/screen/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/favourite_screen.dart';
import 'package:e_commerce_app/screen/homeScreen.dart';
import 'package:e_commerce_app/screen/product_page.dart';

void main() {
  runApp(const MyApp(
    tabindex: 0,
  ));
}

class MyApp extends StatefulWidget {
  final int tabindex;

  const MyApp({
    Key? key,
    required this.tabindex,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(tabindex);
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  var _selectedIndex;
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavouritePage(),
    CartScreen(),
    ProfilePage(),
  ];

  _MyAppState(this._selectedIndex);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          color: Colors.amber,
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            // fixedColor: Colors.red,
            unselectedItemColor: Colors.grey,
            iconSize: 30,
            backgroundColor: Colors.red,
            selectedItemColor: Colors.black,
            elevation: 100,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
