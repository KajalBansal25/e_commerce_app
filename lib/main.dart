import 'package:e_commerce_app/screen/favourite_screen.dart';
import 'package:e_commerce_app/screen/product_page.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/screen/cart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: const TabBarView(children: [
              ProductPage(),
              FavouritePage(),
              // Icon(Icons.favorite),
              CartScreen(),
              Icon(Icons.person)
            ]),
            bottomNavigationBar: Container(
              height: 60,
              foregroundDecoration: const BoxDecoration(
                  backgroundBlendMode: BlendMode.plus,
                  color: Colors.transparent),

              // color: Colors.white,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25))),
              child: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                  ),
                  Tab(
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.person_outlined),
                  ),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                // indicator: Decoration(),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
            ),
          )),
    );
  }
}
