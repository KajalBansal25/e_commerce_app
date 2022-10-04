import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cubit/category_cubit.dart';
import '../cubit/product_cubit.dart';
import '../cubit/user_cubit.dart';

// ignore: must_be_immutable
class MyLoginForm extends StatefulWidget {
  const MyLoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<MyLoginForm> createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: oFocusFunction,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'LOG IN',
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Username'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: normalizedHeight(context, 8.0)!),
                  child: TextFormField(
                    controller: username,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: 'Enter your username',
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        gapPadding: 1.0,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Password',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: password,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        gapPadding: 1.0,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return 'Please enter some text';
                      } else if (value.length < 6) {
                        return 'Password should contain at least 6 character';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pinkAccent),
                        ),
                        onPressed: () async {
                          oFocusFunction();
                          if (_formKey.currentState!.validate()) {
                            var user = username.text;
                            var pass = password.text;
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setString("username", username.text);
                            bool status = await ApiService()
                                .postUserVerification(password: pass , username: user);
                            status == true
                                ? navigateToHomePage()
                                : alertMessage();
                            username.clear();
                            password.clear();
                          }
                        },
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToHomePage() {
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
                create: (context) => CategoryCubit(),
              ),
              BlocProvider(
                create: (context) => UserCubit(),
              ),
            ],
            child: Tabs(
              tabIndex: 0,
            ),
          ),
        ));
  }

  void alertMessage() {
    const snackBar = SnackBar(
      content: Text('Username or Password is Incorrect'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void oFocusFunction() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
