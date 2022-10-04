import 'dart:async';

import 'package:e_commerce_app/screen/home_screen.dart';
import 'package:e_commerce_app/screen/login_screen.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalUsername;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? loginData;
  @override
  void initState() {
    // getLoginData();

    super.initState();
    getLoginData().whenComplete(() async {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => finalUsername == null
                    ? const MyLoginForm()
                    :  const HomeScreen()));
      });
    });
  }

  Future getLoginData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString("username");
    setState(() {
      finalUsername = obtainedUsername!;
    });
    print(finalUsername);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/Logo.png"),
      ),
    );
  }
  // void getLoginData()async{
  //   final SharedPreferences pref=await SharedPreferences.getInstance();
  //  loginData= pref.getString("loginValue");

  // }
}
