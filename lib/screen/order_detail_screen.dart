import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:e_commerce_app/utils/scaling.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            Text(
              'Orders',
              style: TextStyle(
                fontSize: normalizedWidth(context, 22)!,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(
          height: normalizedHeight(context, 60),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: ((context, index) => Card(
                  elevation: 5,
                  margin: EdgeInsets.fromLTRB(
                      normalizedWidth(context, 16)!,
                      normalizedHeight(context, 5)!,
                      normalizedWidth(context, 16)!,
                      normalizedHeight(context, 5)!),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        normalizedWidth(context, 15)!,
                        normalizedHeight(context, 15)!,
                        normalizedWidth(context, 15)!,
                        normalizedHeight(context, 15)!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: 95 259105',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 152, 36, 188),
                              fontSize: normalizedWidth(context, 20),
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
                          children: [
                            Text(
                              'Delhi',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 122, 36, 188),
                                  fontSize: normalizedWidth(context, 20),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Hisar',
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 122, 36, 188),
                                  fontSize: normalizedWidth(context, 20),
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
                              side: const BorderSide(color: Colors.blueAccent)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    normalizedWidth(context, 16)!,
                                    normalizedHeight(context, 16)!,
                                    normalizedWidth(context, 16)!,
                                    normalizedHeight(context, 16)!),
                                child: Image.network(
                                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                                  height: normalizedHeight(context, 50),
                                  width: normalizedWidth(context, 50),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Bag',
                                    style: TextStyle(
                                      fontSize: normalizedWidth(context, 16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'x${index + 1}',
                                    style: TextStyle(
                                      fontSize: normalizedWidth(context, 16),
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
                                  height: normalizedHeight(context, 82),
                                  width: normalizedWidth(context, 82),
                                  color: Colors.blueAccent,
                                  child: Center(
                                      child: Text(
                                    'Rs. 1500',
                                    style: TextStyle(
                                        fontSize: normalizedWidth(context, 16),
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
    ));
  }
}
