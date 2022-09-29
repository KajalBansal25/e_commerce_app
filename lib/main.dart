import 'package:e_commerce_app/cubit/category_cubit.dart';
import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/router.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/product_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: Tabs(
        tabIndex: 0,
      ),
    );
  }
}
