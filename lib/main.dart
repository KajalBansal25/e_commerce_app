import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/screen/splash_screen.dart';
import 'package:e_commerce_app/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    tabIndex: 0,
    router: AppRouter(),
  ));
}

//ignore: must_be_immutable
class MyApp extends StatefulWidget {
  int? tabIndex = 0;

  final AppRouter router;
  MyApp({
    Key? key,
    this.tabIndex,
    required this.router,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  get tabIndex => widget.tabIndex;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      darkTheme: CustomTheme.darkTheme,
      theme: CustomTheme.lightTheme,
      home: const MediaQuery(
        data: MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SplashScreen(),
        ),
      ),
    );
  }
}
