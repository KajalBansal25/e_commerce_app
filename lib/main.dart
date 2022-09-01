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
            body: TabBarView(children: [
              ProductPage(),
              Container(
                child: Icon(Icons.favorite),
              ),
              CartScreen(),
              Container(
                child: Icon(Icons.person),
              )
            ]),
            bottomNavigationBar: Container(
              color: Colors.black,
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
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.blue,
              ),
            ),
          )),
    );
  }
}
