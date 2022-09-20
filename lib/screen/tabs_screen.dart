import 'package:e_commerce_app/cubit/category_cubit.dart';
import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/favourite_screen.dart';
import 'package:e_commerce_app/screen/homeScreen.dart';
import 'package:e_commerce_app/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_cubit.dart';
import '../themes/app_theme.dart';

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  Tabs({Key? key, this.tabIndex}) : super(key: key);
  int? tabIndex = 0;
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  get tabIndex => widget.tabIndex;
  @override
  Widget build(BuildContext pcontext) {
    return MaterialApp(
      title: 'E-commerce',
      darkTheme: CustomTheme.darkTheme,
      theme: CustomTheme.lightTheme,
      home: Scaffold(
        body: IndexedStack(index: tabIndex, children: <Widget>[
          MultiBlocProvider(
            providers: [
              BlocProvider<ProductCubit>.value(
                value: BlocProvider.of<ProductCubit>(context),
              ),
              BlocProvider<CategoryCubit>.value(
                value: BlocProvider.of<CategoryCubit>(context),
              ),
            ],
            child: const HomeScreen(),
          ),
          BlocProvider<ProductCubit>.value(
            value: BlocProvider.of<ProductCubit>(context),
            child: BlocProvider<CategoryCubit>.value(
              value: BlocProvider.of<CategoryCubit>(context),
              child: FavouritePage(),
            ),
          ),
          BlocProvider<ProductCubit>.value(
            value: BlocProvider.of<ProductCubit>(context),
            child: CartScreen(),
          ),
          BlocProvider(
            lazy: true,
            create: (context) => UserCubit(),
            child: const ProfilePage(),
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          // backgroundColor:Colors.lightGreen,
          unselectedItemColor: CustomTheme.darkTheme.primaryColor,
          iconSize: 30,
          selectedItemColor: Colors.redAccent,
          elevation: 100,
          currentIndex: tabIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
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
