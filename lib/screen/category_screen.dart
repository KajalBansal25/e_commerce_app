import 'package:badges/badges.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../constants/api_service.dart';
import '../model/product_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<ProductModel>? _productModel = [];
  // var category;
  // _CategoryScreenState(this.category);
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _productModel =
        (await ApiService().getProductsByCategory(widget.category))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        top: true,
        child: Scaffold(
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
                                widget.category.toString().toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              Badge(
                                padding: const EdgeInsets.all(5),
                                position: BadgePosition.center(),
                                // stackFit: ,
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyApp()));
                                  },
                                  icon:
                                      const Icon(Icons.shopping_cart_outlined),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
}
