import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import '../model/user_data_modal.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final _formUpdateKey = GlobalKey<FormState>();
  TextEditingController emailUpdate = TextEditingController();
  TextEditingController firstNameUpdate = TextEditingController();
  TextEditingController lastNameUpdate = TextEditingController();
  TextEditingController phoneNoUpdate = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Update'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formUpdateKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    controller: firstNameUpdate,
                    textInputAction: TextInputAction.next,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('First Name'),
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                          gapPadding: 1.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2.0)),
                    ),
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return 'Please enter some text';
                      } else if (!RegExp("^[A-Za-z]").hasMatch(value)) {
                        return 'Please Enter a valid Name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    controller: lastNameUpdate,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      label: Text('Last Name'),
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        gapPadding: 1.0,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return 'Please enter some text';
                      } else if (!RegExp("^[A-Za-z]").hasMatch(value)) {
                        return 'Please Enter a valid Name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    controller: emailUpdate,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                          gapPadding: 1.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2.0)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        // print(value);
                        return 'Please enter some text';
                      } else if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return 'Please enter a valid email Address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextFormField(
                    controller: phoneNoUpdate,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Mobile No'),
                      contentPadding: EdgeInsets.all(15.0),
                      border: OutlineInputBorder(
                        gapPadding: 1.0,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if ((value == null || value.isEmpty)) {
                        return 'Please enter some text';
                      } else if (value.length < 10 || value.length > 10) {
                        return 'Mobile No. should contain  10 Number';
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
                                MaterialStateProperty.all(Colors.deepPurple)),
                        onPressed: () {
                          if (_formUpdateKey.currentState!.validate()) {
                            if (kDebugMode) {
                              print('Hello On Pressed Executed');
                            }
                            // Navigator.pop(context);
                            emailUpdate.clear();
                            phoneNoUpdate.clear();
                            firstNameUpdate.clear();
                            lastNameUpdate.clear();
                          }
                        },
                        child: const Text(
                          'UPDATE PROFILE',
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
}
