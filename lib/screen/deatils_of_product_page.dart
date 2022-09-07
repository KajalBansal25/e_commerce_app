import 'package:e_commerce_app/screen/product_image_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:e_commerce_app/model/single_product_model.dart';
import 'package:e_commerce_app/constants/api_service.dart';

import '../main.dart';

class CustomDetailPage extends StatefulWidget {
  const CustomDetailPage({Key? key}) : super(key: key);

  @override
  State<CustomDetailPage> createState() => _CustomDetailPageState();
}

class _CustomDetailPageState extends State<CustomDetailPage> {
  late Welcome? _userModel = Welcome();
  final List<String> reportList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String selectedChoice = "S";
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getSingleProducts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in reportList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Colors.grey.shade600,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    }
    return choices;
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductImagePreviewScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image(
                                    image: NetworkImage("${_userModel?.image}"),
                                    height: 350,
                                  ),
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
                                        maxLines: 3,
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$ ${_userModel?.price}',
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
                                    left: 15, right: 15, top: 10),
                                child: ExpansionTile(
                                  title: const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        '${_userModel?.description}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Text(
                                  'Size',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    children: _buildChoiceList(),
                                  ),
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
                                SizedBox(
                                  width: 65,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.favorite_border,
                                      size: 30,
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
