import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../widgets/product_card.dart';
import '../constants/api_service.dart';
import '../model/product_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
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
      title: "Shop App",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Product Detail Page",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GridView.builder(
                                // itemCount: _productModel?.length,
                                itemCount: _productModel!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        mainAxisExtent: 350,
                                        childAspectRatio: 2 / 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: ((context, index) {
                                  return ProductCard(
                                    index: index,
                                  );
                                })),
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
