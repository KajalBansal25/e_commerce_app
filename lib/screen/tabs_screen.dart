import 'dart:async';
import 'package:badges/badges.dart';
import 'package:e_commerce_app/cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:e_commerce_app/screen/favourite_screen.dart';
import 'package:e_commerce_app/screen/home_screen.dart';
import 'package:e_commerce_app/screen/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/themes/app_theme.dart';

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  Tabs({Key? key, this.tabIndex}) : super(key: key);
  int? tabIndex = 0;
  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  get tabIndex => widget.tabIndex;
  bool canBack = false;

  @override
  Widget build(BuildContext pcontext) {
    return MaterialApp(
      title: 'E-commerce',
      darkTheme: CustomTheme.darkTheme,
      theme: CustomTheme.lightTheme,
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: tabIndex,
            children: <Widget>[
              BlocProvider<ProductCubit>.value(
                value: BlocProvider.of<ProductCubit>(context),
                child: const HomeScreen(),
              ),
              BlocProvider<ProductCubit>.value(
                value: BlocProvider.of<ProductCubit>(context),
                child: const FavouritePage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider<ProductCubit>.value(
                    value: BlocProvider.of<ProductCubit>(context),
                  ),
                  BlocProvider(
                    create: (context) => CartCubit(),
                  ),
                ],
                child: const CartScreen(),
              ),
              BlocProvider<UserCubit>.value(
                value: BlocProvider.of<UserCubit>(context),
                child: const ProfilePage(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            unselectedItemColor: CustomTheme.darkTheme.primaryColor,
            iconSize: 30,
            selectedItemColor: Colors.redAccent,
            elevation: 100,
            currentIndex: tabIndex,
            onTap: _onItemTapped,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  badgeContent: Text(
                    "${context.read<ProductCubit>().favouriteList!.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.favorite),
                ),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  badgeContent: Text(
                    "${context.read<ProductCubit>().addToCaList!.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
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

  Future<bool> _onWillPop() async {
    if (canBack == true) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      setState(() {
        widget.tabIndex = 0;
      });
    }

    Timer(const Duration(seconds: 2), () {
      setState(() {
        canBack = false;
      });
    });
    return canBack = true;
  }
}
