import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screen/details_of_product_page.dart';
import 'package:e_commerce_app/screen/payment_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  late List<CartModel>? _cartModel = [];
  // late List<ProductModel> _data;

  @override
  void initState() {
    super.initState();
    _getData();
    // _data = ApiService().data;
    // if (kDebugMode) {
    //   print(_data);
    // }
  }

  void _getData() async {
    _cartModel = (await ApiService().getCartProduct())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: _cartModel == null || _cartModel!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
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
                              child: SingleChildScrollView(
                                child: Column(
                                    children: _cartModel!
                                        .map(
                                          (cart) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomDetailPage(
                                                            prodId: cart
                                                                .products![0]
                                                                .productId.toString()),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Image(
                                                    image: NetworkImage(
                                                        "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg"),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 120.0,
                                                        child: Text(
                                                          '',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 120.0,
                                                        child: Text(
                                                          'Size: ',
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      180,
                                                                      180,
                                                                      180,
                                                                      1.0)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(''),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
