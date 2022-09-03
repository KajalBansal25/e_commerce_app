import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/screen/order_detail_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 255, 255, 255),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                                builder: (context) =>
                                    const MyApp(tabindex: 2)));
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Text(
                    'Payment',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/location.png',
                        fit: BoxFit.fill,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Home',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '727, Second Floor',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'New York',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'USA',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        // color: Colors.grey,

                        'assets/images/Mastercard-Logo.png',
                        fit: BoxFit.fitWidth,
                        height: 90,
                        width: 90,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'MasterCard',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '**** **** **** 7852',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Card(
                    color: const Color.fromARGB(255, 112, 185, 114),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ]),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Rs. 1500',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Shipping',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Rs. 99',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                children: const [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rs. 1599',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 148, 211, 170)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.green)))),
                    onPressed: () {},
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 18, 0, 18),
                        child: Text(
                          'Apply Coupons',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(220, 0, 0, 0)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderDetailScreen()));
                    },
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(80, 18, 80, 18),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
