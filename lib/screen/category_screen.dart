import 'package:badges/badges.dart';
import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../constants/api_service.dart';
import '../model/product_model.dart';
import 'package:e_commerce_app/utils/Scaling.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<ProductModel>? _productModel = [];
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
    return SafeArea(
      top: true,
      child: Scaffold(
          body: _productModel == null || _productModel!.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.fromLTRB(
                      normalizedWidth(context, 8)!,
                      normalizedHeight(context, 16)!,
                      normalizedWidth(context, 8)!,
                      0),
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: normalizedWidth(context, 22)!),
                          ),
                          Badge(
                            padding: EdgeInsets.fromLTRB(
                                normalizedWidth(context, 8)!,
                                normalizedHeight(context, 16)!,
                                normalizedWidth(context, 8)!,
                                normalizedHeight(context, 16)!),
                            position: BadgePosition.center(),
                            // stackFit: ,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                              },
                              icon: const Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: normalizedHeight(context, 20),
                      ),
                      Expanded(
                        child: productCard(
                          productModel: _productModel,
                          onFavButtonClick: (int index) {
                            setState(() {
                              _productModel![index].favourite();
                            });
                            return null;
                          },
                          parentContext: context,
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
