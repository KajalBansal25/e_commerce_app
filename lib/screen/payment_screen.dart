import 'package:e_commerce_app/screen/order_detail_screen.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum PaymentMethod { masterCard, googlePay, phonePay, visaCard }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final houseTextField = TextEditingController();
  final floorTextField = TextEditingController();
  final cityTextField = TextEditingController();
  final countryTextField = TextEditingController();
  String house = '727';
  String floor = 'Second Floor';
  String city = 'New York';
  String country = 'USA';
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
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
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

  PaymentMethod? _character = PaymentMethod.masterCard;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: normalizedHeight(context, 0)!,
              horizontal: normalizedWidth(context, 8)!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tabs(tabIndex: 2)));
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: normalizedWidth(context, 20)),
                  Text(
                    'Payment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: normalizedWidth(context, 22)),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                    horizontal: normalizedWidth(context, 8)!),
                child: Text(
                  'Address',
                  style: TextStyle(
                      fontSize: normalizedWidth(context, 20),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(normalizedWidth(context, 15)!),
                ),
                elevation: 5,
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: normalizedHeight(context, 8)!,
                        horizontal: normalizedWidth(context, 8)!),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(normalizedWidth(context, 15)!),
                      child: Image.asset(
                        'assets/images/location.png',
                        fit: BoxFit.fill,
                        height: normalizedHeight(context, 150),
                        width: normalizedWidth(context, 150),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: normalizedHeight(context, 8)!,
                        horizontal: normalizedWidth(context, 8)!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                              fontSize: normalizedWidth(context, 16)!,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$house,$floor',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          city,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          country,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                            style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero)),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TextFormField(
                                              controller: houseTextField,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  labelText: 'House No.'),
                                            ),
                                            TextFormField(
                                              controller: floorTextField,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  labelText: 'Floor (Optional)'),
                                            ),
                                            TextFormField(
                                              controller: cityTextField,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                  labelText: 'City'),
                                            ),
                                            TextFormField(
                                              controller: countryTextField,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: const InputDecoration(
                                                  labelText: 'Country'),
                                            ),
                                            SizedBox(
                                              height:
                                                  normalizedHeight(context, 10),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(EdgeInsets
                                                                    .zero)),
                                                    onPressed: () {
                                                      _determinePosition();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'Use Current Location')),
                                                SizedBox(
                                                  width: normalizedWidth(
                                                      context, 20),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        house =
                                                            houseTextField.text;
                                                        floor =
                                                            floorTextField.text;
                                                        city = cityTextField.text;
                                                        country =
                                                            countryTextField.text;
                                                        countryTextField.clear();
                                                        houseTextField.clear();
                                                        floorTextField.clear();
                                                        cityTextField.clear();
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    // style: ButtonStyle(
                                                    //     backgroundColor:
                                                    //         MaterialStateProperty
                                                    //             .all(Colors
                                                    //                 .black),
                                                    // ),
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
                            child: const Text('Change Address'))
                      ],
                    ),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: normalizedHeight(context, 8)!,
                    horizontal: normalizedWidth(context, 8)!),
                child: Text(
                  'Payment Method',
                  style: TextStyle(
                      fontSize: normalizedWidth(context, 16),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: normalizedHeight(context, 8)!,
                        horizontal: normalizedWidth(context, 8)!),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        // color: Colors.grey,

                        'assets/images/Mastercard-Logo.png',
                        fit: BoxFit.fitWidth,
                        height: normalizedHeight(context, 90),
                        width: normalizedWidth(context, 90),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: normalizedHeight(context, 8)!,
                        horizontal: normalizedWidth(context, 8)!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MasterCard',
                          style: TextStyle(
                              fontSize: normalizedWidth(context, 16),
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '**** **** **** 7852',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  // const Expanded(child: SizedBox()),
                  Card(
                    color: const Color.fromARGB(255, 112, 185, 114),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          normalizedWidth(context, 30)!,
                                          normalizedHeight(context, 8)!,
                                          0,
                                          normalizedHeight(context, 8)!),
                                      child: Text(
                                        'Choose Your Payment Methord',
                                        style: TextStyle(
                                            fontSize:
                                                normalizedWidth(context, 20),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('MasterCard'),
                                      leading: Radio<PaymentMethod>(
                                        value: PaymentMethod.masterCard,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('GooglePay'),
                                      leading: Radio<PaymentMethod>(
                                        value: PaymentMethod.googlePay,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('PhonePay'),
                                      leading: Radio<PaymentMethod>(
                                        value: PaymentMethod.phonePay,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text('Visa Card'),
                                      leading: Radio<PaymentMethod>(
                                        value: PaymentMethod.visaCard,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            print('kf');
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              });
                            });
                      },
                    ),
                  ),
                  SizedBox(
                    width: normalizedWidth(context, 20),
                  ),
                ]),
              ),
              // const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      fontSize: normalizedWidth(context, 16),
                    ),
                  ),
                  Text(
                    'Rs. 1500',
                    style: TextStyle(
                        fontSize: normalizedWidth(context, 16),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping',
                    style: TextStyle(
                      fontSize: normalizedWidth(context, 16),
                    ),
                  ),
                  Text(
                    'Rs. 99',
                    style: TextStyle(
                        fontSize: normalizedWidth(context, 16),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Divider(
                // height: 10,
                color: Colors.black,
                indent: 2,
                endIndent: 2,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        fontSize: normalizedWidth(context, 16),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs. 1599',
                    style: TextStyle(
                        fontSize: normalizedWidth(context, 16),
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: normalizedHeight(context, 20),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(normalizedWidth(context, 20)!, 0,
                    normalizedWidth(context, 20)!, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              normalizedWidth(context, 15)!),
                        ))),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFormField(
                                    controller: houseTextField,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                        labelText: 'Enter Coupon Code'),
                                  ),
                                  SizedBox(
                                    height: normalizedHeight(context, 10),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    '${houseTextField.text} is not applicable');
                                            houseTextField.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              const Text('Check for Coupons')),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            normalizedHeight(context, 18)!,
                            0,
                            normalizedHeight(context, 18)!),
                        child: Text(
                          'Apply Coupons',
                          style: TextStyle(
                            fontSize: normalizedWidth(context, 20),
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: normalizedHeight(context, 10),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(normalizedWidth(context, 20)!, 0,
                    normalizedWidth(context, 20)!, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              normalizedWidth(context, 15)!),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderDetailScreen()));
                    },
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          normalizedWidth(context, 0)!,
                          normalizedHeight(context, 18)!,
                          normalizedWidth(context, 0)!,
                          normalizedHeight(context, 18)!,
                        ),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: normalizedWidth(context, 20),
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
