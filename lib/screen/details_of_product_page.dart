import 'package:e_commerce_app/screen/product_image_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/model/single_product_modal.dart';

import '../constants/api_constants.dart';
import '../main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/Scaling.dart';

//ignore: must_be_immutable
class CustomDetailPage extends StatefulWidget {
  CustomDetailPage({Key? key, required this.prodId}) : super(key: key);
  String prodId;
  @override
  State<CustomDetailPage> createState() => _CustomDetailPageState();
}

class _CustomDetailPageState extends State<CustomDetailPage> {
  ProductModal? _userModel = ProductModal();
  bool circular = true;
  final List<String> reportList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String selectedChoice = "S";
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    var url = Uri.parse(ApiConstants.baseUrl +
        ApiConstants.usersEndpointSingleProduct +
        widget.prodId);
    var response = await http.get(url);
    var temp = json.decode(response.body);
    setState(() {
      _userModel = ProductModal.fromJson(temp);
      circular = false;
    });
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in reportList) {
      choices.add(Container(
        padding: EdgeInsets.symmetric(
            horizontal: normalizedWidth(context, 2)!,
            vertical: normalizedHeight(context, 2)!),
        child: ChoiceChip(
          label: Text(item,style: const TextStyle(color: Colors.white),),
          selectedColor: Colors.redAccent,
          backgroundColor: Colors.grey.shade600,
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
    return SafeArea(
      child: Scaffold(
        body: circular
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(
                    normalizedWidth(context, 8)!,
                    normalizedHeight(context, 16)!,
                    normalizedWidth(context, 8)!,
                    normalizedHeight(context, 0)!),
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
                                    builder: (context) => MyApp(tabIndex: 2)));
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: normalizedWidth(context, 10)!,
                                    vertical: normalizedHeight(context, 10)!),
                                child: Image(
                                  image: NetworkImage("${_userModel?.image}"),
                                  height: normalizedHeight(context, 350),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: normalizedHeight(context, 20)!,
                                  bottom: normalizedHeight(context, 5)!,
                                  right: normalizedHeight(context, 30)!,
                                  left: normalizedHeight(context, 30)!),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: normalizedWidth(context, 200),
                                    child: Text(
                                      '${_userModel?.title}',
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: normalizedWidth(context, 15),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$ ${_userModel?.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: normalizedWidth(context, 19),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: normalizedWidth(context, 15)!,
                                  right: normalizedWidth(context, 15)!,
                                  top: normalizedHeight(context, 10)!),
                              child: ExpansionTile(
                                title: Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: normalizedWidth(context, 15),
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
                            _userModel?.category == "men's clothing" ||
                                    _userModel?.category == "women's clothing"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            normalizedWidth(context, 30)!),
                                    child: const Text(
                                      'Size',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : const Text(''),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: normalizedWidth(context, 25)!),
                                child:
                                    _userModel?.category == "men's clothing" ||
                                            _userModel?.category ==
                                                "women's clothing"
                                        ? SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Wrap(
                                              children: _buildChoiceList(),
                                            ),
                                          )
                                        : const Text('')),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: normalizedHeight(context, 35),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: normalizedWidth(context, 16)!,
                              vertical: normalizedHeight(context, 0)!),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: normalizedWidth(context, 65),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(normalizedWidth(context, 60)!),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: normalizedWidth(context, 30),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            normalizedWidth(context, 80)!),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(normalizedWidth(context, 60)!),
                                    )),
                                onPressed: () {},
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
