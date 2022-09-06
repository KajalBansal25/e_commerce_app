import 'package:e_commerce_app/screen/profile_update_screen.dart';
import 'package:flutter/material.dart';

import '../constants/api_service.dart';
import '../model/user_data_modal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Userdata? userModel = Userdata();
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    userModel = (await ApiService().getUserData())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return userModel == null || userModel?.address == null
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ColoredBox(
                          color: Colors.deepPurple,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.account_circle,
                                  size: 80,
                                ),
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text(
                                  '${userModel?.name?.firstname?.toUpperCase()} ${userModel?.name?.lastname?.toUpperCase()}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: ColoredBox(
                          color: Colors.black87,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 490,
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                '${userModel?.phone}',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.email_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: Text('${userModel?.email}'),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                height: 5,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            ExpansionTile(
                              iconColor: Colors.deepPurple,
                              collapsedIconColor: Colors.deepPurple,
                              leading: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: const Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                ListTile(
                                  title: Text(
                                    '${userModel?.address?.number} '
                                    '${userModel?.address?.street?.toUpperCase()} '
                                    '${userModel?.address?.city?.toUpperCase()} \n'
                                    '${userModel?.address?.zipcode?.toUpperCase()} ',
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                height: 7,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            const ListTile(
                              leading: Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: Text('My Orders'),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.deepPurple,
                                size: 20,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurple),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileUpdate(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'UPDATE PROFILE',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepPurple),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'LOG OUT',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
