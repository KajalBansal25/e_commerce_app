import 'package:e_commerce_app/screen/login_screen.dart';
import 'package:flutter/material.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Image.asset("assets/images/Logo.png"),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyLoginForm(),
                  ),
                );
              },
              child: const Text(
                'LOG IN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
 }
