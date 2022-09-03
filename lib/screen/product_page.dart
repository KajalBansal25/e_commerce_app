import 'package:badges/badges.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../constants/api_service.dart';
import '../model/product_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with AutomaticKeepAliveClientMixin {
  late List<ProductModel>? _productModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _productModel = (await ApiService().getProducts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: "Shop App",
      home: SafeArea(
        top: true,
        child: Scaffold(
            // backgroundColor: Color.fromARGB(255, 218, 218, 218),
            body: _productModel == null || _productModel!.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 221, 221, 221),
                        Color.fromARGB(255, 239, 239, 239),
                      ], begin: Alignment.topLeft, end: Alignment.topRight),
                    ),
                    child: Padding(
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
                              Text(
                                "${_productModel![0].category}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              Badge(
                                padding: EdgeInsets.all(5),
                                position: BadgePosition.center(),
                                // stackFit: ,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyApp(tabindex: 2)));
                                  },
                                  icon:
                                      const Icon(Icons.shopping_cart_outlined),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ProductCard(
                              productModel: _productModel,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
