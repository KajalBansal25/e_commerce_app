import 'dart:convert';
import 'package:e_commerce_app/utils/Scaling.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:e_commerce_app/screen/order_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/screen/profile_update_screen.dart';
import 'package:flutter/material.dart';

import '../model/user_data_modal.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Userdata? _userDataModal = Userdata();
  final houseTextField = TextEditingController();
  final floorTextField = TextEditingController();
  final cityTextField = TextEditingController();
  final countryTextField = TextEditingController();
  String house = '';
  String floor = '';
  String city = '';
  String country = '';
  String currentAddress = '';
  late Position currentPosition;

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Please keep your location on");
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permission is denied Forever');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentPosition = position;
        currentAddress =
            '${place.locality},${place.postalCode},${place.country}';
        house = place.name!;
        city = place.locality!;
        country = place.country!;
        floor = place.postalCode!;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  String apiLink = 'https://fakestoreapi.com/users/1';
  bool circular = true;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    var url = Uri.parse(apiLink);
    var response = await http.get(url);
    var temp = json.decode(response.body);
    setState(() {
      _userDataModal = Userdata.fromJson(temp);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: circular
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Stack(
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
                              SizedBox(
                                height: normalizedHeight(context, 50),
                              ),
                              Icon(
                                Icons.account_circle,
                                size: normalizedWidth(context, 80),
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: normalizedHeight(context, 10),
                              ),
                              Center(
                                child: Text(
                                  '${_userDataModal?.name?.firstname?.toUpperCase()} ${_userDataModal?.name?.lastname?.toUpperCase()}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: normalizedWidth(context, 20),
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
                            children: [
                              SizedBox(
                                height: normalizedHeight(context, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: normalizedHeight(context, 470),
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: normalizedWidth(context, 12)!,
                          vertical: normalizedHeight(context, 12)!),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedWidth(context, 18)!,
                                  vertical: normalizedHeight(context, 18)!),
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: normalizedWidth(context, 21),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone,
                                color: Colors.deepPurple,
                              ),
                              title: Text(
                                '${_userDataModal?.phone}',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedHeight(context, 20)!),
                              child: Divider(
                                height: normalizedHeight(context, 1),
                                thickness: normalizedWidth(context, 1),
                                color: Colors.grey,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.email_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: Text('${_userDataModal?.email}'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedHeight(context, 20)!),
                              child: Divider(
                                height: normalizedHeight(context, 5),
                                thickness: normalizedWidth(context, 1),
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
                              title: Text(
                                'Address',
                                style: TextStyle(
                                  fontSize: normalizedWidth(context, 15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: [
                                ListTile(
                                  title: Wrap(children: [
                                    Text(
                                      '${_userDataModal?.address?.number} '
                                      '${_userDataModal?.address?.street?.toUpperCase()} '
                                      '${_userDataModal?.address?.city?.toUpperCase()} '
                                      '${_userDataModal?.address?.zipcode?.toUpperCase()} ',
                                    ),
                                  ]),
                                  trailing: TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero)),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SingleChildScrollView(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          normalizedWidth(
                                                              context, 10)!,
                                                      vertical:
                                                          normalizedHeight(
                                                              context, 10)!),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      TextFormField(
                                                        controller:
                                                            houseTextField,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'House No.'),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            floorTextField,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'Floor (Optional)'),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            cityTextField,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'City'),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            countryTextField,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        decoration:
                                                            const InputDecoration(
                                                                labelText:
                                                                    'Country'),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(
                                                                      EdgeInsets
                                                                          .zero)),
                                                              onPressed: () {
                                                                _determinePosition();
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Use Current Location')),
                                                          SizedBox(
                                                            width:
                                                                normalizedWidth(
                                                                    context,
                                                                    20),
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  house =
                                                                      houseTextField
                                                                          .text;
                                                                  floor =
                                                                      floorTextField
                                                                          .text;
                                                                  city =
                                                                      cityTextField
                                                                          .text;
                                                                  country =
                                                                      countryTextField
                                                                          .text;
                                                                  countryTextField
                                                                      .clear();
                                                                  houseTextField
                                                                      .clear();
                                                                  floorTextField
                                                                      .clear();
                                                                  cityTextField
                                                                      .clear();
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .black)),
                                                              child: const Text(
                                                                  'Save Address')),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: const Text('Change Address')),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedHeight(context, 20)!),
                              child: Divider(
                                height: normalizedHeight(context, 7),
                                thickness: normalizedWidth(context, 1),
                                color: Colors.grey,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderDetailScreen(),
                                  ),
                                );
                              },
                              leading: const Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.deepPurple,
                              ),
                              title: const Text('My Orders'),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.deepPurple,
                                size: normalizedWidth(context, 15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedHeight(context, 20)!),
                              child: Divider(
                                height: normalizedHeight(context, 1),
                                thickness: normalizedWidth(context, 1),
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedWidth(context, 10)!,
                                  vertical: normalizedHeight(context, 15)!),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedWidth(context, 10)!,
                                  vertical: normalizedHeight(context, 10)!),
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
                                  // Navigator.pop(context);
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
