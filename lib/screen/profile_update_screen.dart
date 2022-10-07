import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/model/user_data_modal.dart';

class ProfileUpdate extends StatefulWidget {
  final Address? tempAddress;
  const ProfileUpdate({
    Key? key,
    this.tempAddress,
  }) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  Name tempName = Name();
  Userdata updatedProfileData = Userdata();
  get tempAddress => widget.tempAddress;
  Userdata userDataModal = Userdata();

  final _formUpdateKey = GlobalKey<FormState>();
  TextEditingController emailUpdate = TextEditingController();
  TextEditingController firstNameUpdate = TextEditingController();
  TextEditingController lastNameUpdate = TextEditingController();
  TextEditingController phoneNoUpdate = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailUpdate.dispose();
    phoneNoUpdate.dispose();
    firstNameUpdate.dispose();
    lastNameUpdate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Update'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formUpdateKey,
          autovalidateMode: _autovalidateMode,
          child: Padding(
            padding: EdgeInsets.only(
                top: normalizedHeight(context, 10)!,
                left: normalizedWidth(context, 20)!,
                right: normalizedWidth(context, 20)!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: normalizedHeight(context, 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                  ),
                  child: TextFormField(
                    controller: firstNameUpdate,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('First Name'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 15)!,
                        vertical: normalizedHeight(context, 15)!,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: normalizedHeight(context, 1)!,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            normalizedWidth(context, 10)!,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: normalizedWidth(context, 2)!,
                        ),
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
                  padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                  ),
                  child: TextFormField(
                    controller: lastNameUpdate,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      label: const Text('Last Name'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 15)!,
                        vertical: normalizedHeight(context, 15)!,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: normalizedHeight(context, 1)!,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            normalizedWidth(context, 10)!,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: normalizedWidth(context, 2)!,
                        ),
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
                  padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                  ),
                  child: TextFormField(
                    controller: emailUpdate,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 15)!,
                        vertical: normalizedHeight(context, 15)!,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: normalizedHeight(context, 1)!,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            normalizedWidth(context, 10)!,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: normalizedWidth(context, 2)!,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
                  padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                  ),
                  child: TextFormField(
                    maxLength: 10,
                    controller: phoneNoUpdate,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Mobile No'),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 15)!,
                        vertical: normalizedHeight(context, 15)!,
                      ),
                      border: OutlineInputBorder(
                        gapPadding: normalizedHeight(context, 1)!,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            normalizedWidth(context, 10)!,
                          ),
                        ),
                        borderSide: BorderSide(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: normalizedWidth(context, 2)!),
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
                  padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 16)!,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formUpdateKey.currentState!.validate()) {
                            updatedProfileData = Userdata(
                              phone: phoneNoUpdate.text,
                              name: Name(
                                firstname: firstNameUpdate.text,
                                lastname: lastNameUpdate.text,
                              ),
                              address: tempAddress,
                              email: emailUpdate.text,
                              password: '',
                              id: 23,
                              username: firstNameUpdate.text,
                              v: 0,
                            );
                            emailUpdate.clear();
                            phoneNoUpdate.clear();
                            firstNameUpdate.clear();
                            lastNameUpdate.clear();
                            context
                                .read<UserCubit>()
                                .updateUser(u: updatedProfileData);
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              _autovalidateMode = AutovalidateMode.always;
                            });
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
