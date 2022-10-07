import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:e_commerce_app/cubit/cart_cubit.dart';
import 'package:e_commerce_app/screen/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin {
  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CartCubit>(context).getProductAndCartData();
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartLoaded) {
                      return _customColumn(state.cartProductDataList);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: normalizedHeight(context, 140)!,
                    vertical: normalizedWidth(context, 15)!,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text('Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customColumn(List cartList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: normalizedHeight(context, 1.0)!,
                    vertical: normalizedWidth(context, 1)!,
                  ),
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
                                  width: normalizedWidth(context, 100),
                                  height: normalizedHeight(context, 100),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: normalizedHeight(context, 10),
                                    ),
                                    SizedBox(
                                      width: normalizedWidth(context, 120.0),
                                      child: Text(
                                        item["pdtTitle"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                          fontSize:
                                              normalizedWidth(context, 16),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: normalizedHeight(context, 10),
                                    ),
                                    SizedBox(
                                      width: normalizedWidth(context, 120),
                                      child: const Text(
                                        'Size: M',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            180,
                                            180,
                                            180,
                                            1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: normalizedHeight(context, 10),
                                    ),
                                    Text("\$ ${item["pdtPrice"].toString()}"),
                                  ],
                                ),
                                SizedBox(
                                  width: normalizedWidth(context, 83),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        putUpdateCountApi(item["productId"],
                                            item["crtPdtCount"]);
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: normalizedWidth(context, 15),
                                      ),
                                      padding: const EdgeInsets.all(1.0),
                                      splashRadius: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        2.0,
                                        0.0,
                                        2.0,
                                        0.0,
                                      ),
                                      child:
                                          Text(item["crtPdtCount"].toString()),
                                    ),
                                    SizedBox(
                                      height: normalizedHeight(context, 10),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        size: normalizedWidth(context, 15),
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
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: normalizedHeight(context, 20.0)!,
                vertical: normalizedWidth(context, 10.0)!,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        totalAmount = 0.0;
                        totalAmount = _getTotalAmount(cartList);

                        return Text(
                          '\$ $totalAmount ',
                          style: TextStyle(
                            fontSize: normalizedWidth(context, 15),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                      return const Text('Price::');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void putUpdateCountApi(int productId, int itemCount) async {
    try {
      var url = Uri.parse("https://fakestoreapi.com/carts/7");
      var response = await http.put(url);

      if (response.statusCode == 200) {
        debugPrint("=================>>${response.body}");
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
