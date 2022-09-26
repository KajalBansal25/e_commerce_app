import 'dart:developer';
import 'package:e_commerce_app/cubit/cart_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
// import 'package:e_commerce_app/model/cart_model.dart';
import 'package:e_commerce_app/screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  List cartProductDataList = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void appendData(var i, var j) {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).getUserCartData();
    BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is! ProductLoaded) {
        BlocProvider.of<ProductCubit>(context).getProductData();
        return null as Widget;
      }
      return null as Widget;
    });
    super.build(context);
    cartProductDataList = [];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Your Cart",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              child: SingleChildScrollView(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state1) {
                    if (state1 is ProductLoaded) {
                      return BlocBuilder<CartCubit, CartState>(
                          builder: (context, state2) {
                        if (state2 is CartLoaded) {
                          int cLen = state2.cartModel[0]?.products!.length ?? 0;
                          for (var j = 0; j < cLen; j++) {
                            for (var i = 0;
                                i < state1.productModel!.length;
                                i++) {
                              if (state1.productModel![i].id ==
                                  state2.cartModel[0]?.products![j].productId) {
                                {
                                  cartProductDataList.add({
                                    'pdtImg': state1.productModel![i].image
                                        .toString(),
                                    'pdtTitle': state1.productModel![i].title
                                        .toString(),
                                    'pdtPrice': state1.productModel![i].price,
                                    'crtPdtCount': state2
                                        .cartModel[0]?.products![j].quantity,
                                    "productId": state2
                                        .cartModel[0]?.products![j].productId
                                  });
                                }
                              }
                            }
                          }
                          print('$totalAmount');
                          print(cartProductDataList.length);
                        } else if (state2 is! CartLoaded) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return _customColumn(cartProductDataList);
                      });
                    } else if (state1 is! ProductLoaded) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Text('state1 is! ProductLoaded');
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if(state is CartLoaded) {
                        totalAmount = _getTotalAmount(cartProductDataList);

                        return Text(
                        '\$ $totalAmount ',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      );}
                      return const Text('Price::');
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()));
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
      ),
    );
  }

  Widget _customColumn(List cartList) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: cartList
                .map<Widget>(
                  (item) => GestureDetector(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(item["pdtImg"]),
                          width: 100,
                          height: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 120.0,
                              child: Text(
                                item["pdtTitle"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 120.0,
                              child: Text(
                                'Size: M',
                                style: TextStyle(
                                    color: Color.fromRGBO(180, 180, 180, 1.0)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("\$ ${item["pdtPrice"].toString()}"),
                          ],
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                print('${item["productId"]}');
                                putUpdateCountApi(
                                    item["productId"], item["crtPdtCount"]);
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 15.0,
                              ),
                              padding: const EdgeInsets.all(1.0),
                              splashRadius: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                              child: Text(item["crtPdtCount"].toString()),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add,
                                size: 15.0,
                              ),
                              padding: const EdgeInsets.all(1.0),
                              splashRadius: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          )),
    ]);
  }

  void putUpdateCountApi(int productId, int itemCount) async {
    try {
      var url = Uri.parse("https://fakestoreapi.com/carts/7");
      var response = await http.put(url);

      if (response.statusCode == 200) {
        print("=================>>${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  double _getTotalAmount(List cartList) {
    List<double> productAll = [];
    for (var key in cartList) {
      var temp = 0.0;
      temp = key["pdtPrice"] * key["crtPdtCount"];
      productAll.add(temp);
    }
    for (var i in productAll) {
      totalAmount = totalAmount + i;
    }

    return totalAmount.ceilToDouble();
  }

  @override
  bool get wantKeepAlive => true;
}
