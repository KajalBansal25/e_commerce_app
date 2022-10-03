import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/cubit/user_cubit.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:e_commerce_app/screen/order_detail_screen.dart';
import 'package:e_commerce_app/screen/profile_update_screen.dart';
import 'package:flutter/material.dart';
import '../model/user_data_modal.dart';
import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Userdata? userDataModel = Userdata();
  final houseTextField = TextEditingController();
  final floorTextField = TextEditingController();
  final cityTextField = TextEditingController();
  final streetTextField = TextEditingController();
  String house = '';
  String floor = '';
  String city = '';
  String street = '';
  String currentAddress = '';
  late Position currentPosition;
  Address tempAddress = Address();
  Userdata userDataModal = Userdata();

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
            '${place.locality},${place.postalCode},${place.street}';
        house = place.name!;
        city = place.locality!;
        street = place.street!;
        floor = place.postalCode!;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUser();
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
                          color: Colors.redAccent,
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
                                child: BlocBuilder<UserCubit, UserState>(
                                  builder: (context, state) {
                                    if (state is UserLoaded) {
                                      return Text(
                                        '${(state).userdata.name!.firstname.toString().toUpperCase()} ${(state).userdata.name!.lastname.toString().toUpperCase()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                normalizedWidth(context, 20),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500),
                                      );
                                    } else if (state is! UserUpdate) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Text(
                                        '${(state).userdata.name!.firstname.toString().toUpperCase()} ${(state).userdata.name!.lastname.toString().toUpperCase()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              normalizedWidth(context, 20),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                  },
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
                      // color: Colors.white,
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
                                color: Colors.redAccent,
                              ),
                              title: BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoaded) {
                                    return Text(
                                      '${(state).userdata.phone.toString().toUpperCase()} ',
                                    );
                                  } else if (state is! UserUpdate) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return Text(
                                      '${(state).userdata.phone.toString().toUpperCase()} ',
                                    );
                                  }
                                },
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
                                color: Colors.redAccent,
                              ),
                              title: BlocBuilder<UserCubit, UserState>(
                                builder: (context, state) {
                                  if (state is UserLoaded) {
                                    return Text(
                                      '${(state).userdata.email.toString()} ',
                                    );
                                  } else if (state is! UserUpdate) {
                                    return const CircularProgressIndicator();
                                  } else {
                                    return Text(
                                      '${(state).userdata.email.toString()} ',
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: normalizedHeight(context, 20)!,
                              ),
                              child: Divider(
                                height: normalizedHeight(context, 5),
                                thickness: normalizedWidth(context, 1),
                                color: Colors.grey,
                              ),
                            ),
                            ExpansionTile(
                              iconColor: Colors.redAccent,
                              collapsedIconColor: Colors.redAccent,
                              leading: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.redAccent,
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
                                    BlocBuilder<UserCubit, UserState>(
                                      builder: (context, state) {
                                        if (state is UserLoaded) {
                                          return Text(
                                            '${(state).userdata.address?.number.toString().toUpperCase()} '
                                            '${(state).userdata.address?.street.toString().toUpperCase()} '
                                            '${(state).userdata.address?.city.toString().toUpperCase()} '
                                            '${(state).userdata.address?.zipcode.toString().toUpperCase()} ',
                                          );
                                        } else if (state is! UserUpdate) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          return Text(
                                            '${(state).userdata.address?.number.toString().toUpperCase()} '
                                            '${(state).userdata.address?.street.toString().toUpperCase()} '
                                            '${(state).userdata.address?.city.toString().toUpperCase()} '
                                            '${(state).userdata.address?.zipcode.toString().toUpperCase()} ',
                                          );
                                        }
                                      },
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
                                                    horizontal: normalizedWidth(
                                                        context, 10)!,
                                                    vertical: normalizedHeight(
                                                        context, 10)!),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          houseTextField,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'House No.'),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          floorTextField,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'Floor (Optional)'),
                                                    ),
                                                    TextFormField(
                                                      controller: cityTextField,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'City'),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          streetTextField,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      decoration:
                                                          const InputDecoration(
                                                              labelText:
                                                                  'street'),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                            style: ButtonStyle(
                                                                padding: MaterialStateProperty
                                                                    .all(EdgeInsets
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
                                                                  context, 20),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            // print("${u.id}");
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
                                                              street =
                                                                  streetTextField
                                                                      .text;
                                                              streetTextField
                                                                  .clear();
                                                              houseTextField
                                                                  .clear();
                                                              floorTextField
                                                                  .clear();
                                                              cityTextField
                                                                  .clear();
                                                            });
                                                            Userdata u = context
                                                                .read<
                                                                    UserCubit>()
                                                                .userData;
                                                            userDataModal = Userdata(
                                                                v: 0,
                                                                username:
                                                                    u.username,
                                                                id: u.id,
                                                                password:
                                                                    u.password,
                                                                email: u.email,
                                                                address: Address(
                                                                    city: city,
                                                                    number: floor
                                                                        as int,
                                                                    geolocation:
                                                                        Geolocation(),
                                                                    street:
                                                                        street,
                                                                    zipcode: u
                                                                        .address
                                                                        ?.zipcode),
                                                                name: u.name,
                                                                phone: u.phone);
                                                            await ApiService().putUserData(object: userDataModal);
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'Save Address',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: const Text('Change Address'),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: normalizedHeight(context, 20)!,
                              ),
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
                                color: Colors.redAccent,
                              ),
                              title: const Text('My Orders'),
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: Colors.redAccent,
                                size: normalizedWidth(context, 15),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: normalizedHeight(context, 20)!,
                              ),
                              child: Divider(
                                height: normalizedHeight(context, 1),
                                thickness: normalizedWidth(context, 1),
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: normalizedWidth(context, 10)!,
                                vertical: normalizedHeight(context, 15)!,
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  tempAddress.city = city;
                                  tempAddress.zipcode = house;
                                  tempAddress.street = street;
                                  Userdata u =
                                      context.read<UserCubit>().userData;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlocProvider<UserCubit>.value(
                                        value:
                                            BlocProvider.of<UserCubit>(context),
                                        child: ProfileUpdate(
                                            tempAddress: u.address!),
                                      ),
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
                                vertical: normalizedHeight(context, 10)!,
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => const MyLoginForm()),
                                      ModalRoute.withName('/')
                                  );
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
