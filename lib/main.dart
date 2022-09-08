import 'package:e_commerce_app/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/favourite_screen.dart';
import 'package:e_commerce_app/screen/homeScreen.dart';

void main() {
  runApp(MyApp(tabIndex: 0,));
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
  int? tabIndex = 0;
  MyApp({
    Key? key,
    this.tabIndex,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get tabIndex => widget.tabIndex;
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    FavouritePage(),
    CartScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: IndexedStack(
          index: tabIndex,
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
            currentIndex: tabIndex,
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
      widget.tabIndex = index;
    });
  }
}
