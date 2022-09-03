import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:e_commerce_app/model/single_product_model.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:flutter/widgets.dart';

import '../main.dart';

class CustomDetailPage extends StatefulWidget {
  const CustomDetailPage({Key? key}) : super(key: key);

  @override
  State<CustomDetailPage> createState() => _CustomDetailPageState();
}

class _CustomDetailPageState extends State<CustomDetailPage> {
  late Welcome? _userModel = Welcome();

  @override
  void initState() {
    super.initState();
    print('${_userModel?.image}');
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getSingleProducts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return _userModel == null || _userModel?.image == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MaterialApp(
            home: SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyApp(tabindex: 2)));
                            },
                            icon: const Icon(Icons.shopping_cart_outlined),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 10,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image(
                                  image: NetworkImage("${_userModel?.image}"),
                                  height: 350,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 5.0,
                                    right: 30.0,
                                    left: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        '${_userModel?.title}',
                                        softWrap: true,
                                        maxLines: 2,
                                        // overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${_userModel?.price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10),
                                child: ExpandablePanel(
                                  header: const Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  collapsed: Text(
                                    '${_userModel?.description}',
                                    softWrap: true,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  expanded: Text('${_userModel?.description}'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Size',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 80.0,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Text('M'),
                                                padding:
                                                    const EdgeInsets.all(0.0)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Text('L'),
                                                padding:
                                                    const EdgeInsets.all(0.0)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Text('XL'),
                                                padding:
                                                    const EdgeInsets.all(0.0)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Text('XXL'),
                                                padding:
                                                    const EdgeInsets.all(0.0)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.0),
                                      color: Colors.blue),
                                  child: const Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 85.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(60),
                                      )),
                                  onPressed: () {},
                                  child: const Text(
                                    '+Add to Cart',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
