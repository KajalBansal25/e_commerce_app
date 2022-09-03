import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screen/payment_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
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
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: _productModel == null || _productModel!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(Icons.arrow_back_ios_rounded),
                          // ),
                          Text(
                            "Your Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            // height: 600,
                            child: SingleChildScrollView(
                              child: Column(
                                  children: _productModel!
                                      .map(
                                        (product) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image(
                                                image: NetworkImage(
                                                    "${product.image}"),
                                                width: 100,
                                                height: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 120.0,
                                                    child: Text(
                                                      '${product.title}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 120.0,
                                                    child: Text(
                                                      'Size: ${product.category}',
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              180,
                                                              180,
                                                              180,
                                                              1.0)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text('${product.price}'),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    size: 15.0,
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Icon(
                                                    Icons.remove,
                                                    size: 15.0,
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    size: 15.0,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Total'),
                                    Text('Rs. 1560'),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 140.0, vertical: 15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                child: const Text('Payment'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
