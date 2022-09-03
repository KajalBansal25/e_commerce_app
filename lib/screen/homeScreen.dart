import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screen/product_page.dart';
import 'package:flutter/material.dart';

import 'deatils_of_product_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ProductModel>? _productModel = [];
  double totalPrice = 0;
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                  height: 400.0,
                  width: 400,
                  image: NetworkImage(
                      "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('New Products'),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductPage())),
                      child: Row(
                        children: const [Text('More'), Icon(Icons.play_arrow)],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 500.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _productModel!
                        .map(
                          (product) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomDetailPage()));
                            },
                            child: SizedBox(
                              width: 250.0,
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        Image(
                                            fit: BoxFit.fill,
                                            height: 200,
                                            width: 200,
                                            image: NetworkImage(
                                                "${product.image}")),
                                        const Positioned(
                                          top: 1,
                                          right:
                                              1, //give the values according to your requirement
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 28.0,
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('${product.category}'),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('Rs. ${product.price}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
