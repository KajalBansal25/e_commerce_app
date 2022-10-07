import 'dart:async';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/screen/login_screen.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalUsername = "";

  @override
  void initState() {
    super.initState();
    asyncCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/splash.gif"),
      ),
    );
  }

  navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) => ProductCubit(),
            ),
            BlocProvider(
              create: (context) => UserCubit(),
            ),
          ],
          child: Tabs(
            tabIndex: 0,
          ),
        ),
      ),
    );
  }

  Future getLoginData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    finalUsername = sharedPreferences.getString("username");
  }

  getTimer() {
    Timer(
      const Duration(seconds: 3),
      () {
        finalUsername == null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyLoginForm()),
              )
            : navigateToHomePage();
      },
    );
  }

  Future asyncCheck() async {
    getLoginData().whenComplete(
      () async {
        getTimer();
      },
    );
  }
}
