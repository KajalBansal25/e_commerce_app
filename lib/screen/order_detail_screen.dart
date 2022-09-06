import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 239, 239, 239),
          ], begin: Alignment.topLeft, end: Alignment.topRight),
        ),
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) => Card(
                    elevation: 5,
                    margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ID: 95 259105',
                            style: TextStyle(
                                color: Color.fromARGB(255, 152, 36, 188),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                '17 Sep, 22',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                  style: TextStyle(color: Colors.grey),
                                  '25 Sep, 22'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Delhi',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 36, 188),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hisar',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 36, 188),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconStepper(
                            icons: const [
                              Icon(Icons.abc),
                              Icon(Icons.adjust),
                              Icon(Icons.access_alarm),
                              Icon(Icons.supervised_user_circle),
                            ],

                            // activeStep property set to activeStep variable defined above.
                            activeStep: index,
                            activeStepColor: Colors.blue,
                            stepRadius: 16,
                            lineColor: Colors.black,
                            steppingEnabled: false,
                            enableNextPreviousButtons: false,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.blueAccent)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Image.network(
                                    'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Bag',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'x${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  child: Container(
                                    height: 82,
                                    width: 82,
                                    color: Colors.blueAccent,
                                    child: Center(
                                        child: Text(
                                      'Rs. 1500',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              itemCount: 5,
            ),
          ),
        ]),
      ),
    ));
  }
}
