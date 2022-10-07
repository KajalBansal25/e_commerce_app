import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:e_commerce_app/widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            normalizedWidth(context, 8)!,
            normalizedHeight(context, 16)!,
            normalizedWidth(context, 8)!,
            0,
          ),
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
                    "All Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: normalizedWidth(context, 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Badge(
                      badgeContent: Text(
                        "${context.read<ProductCubit>().addToCaList!.length}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tabs(tabIndex: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is! ProductLoaded) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return productCard(
                        parentContext: context,
                        productModel: state.productModel!,
                        onFavButtonClick: (int index) {
                          setState(() {
                            BlocProvider.of<ProductCubit>(context)
                                .updateFavouriteList(
                                    state.productModel![index]);
                            context.read<ProductCubit>().getProductData();
                          });
                          return null;
                        },
                        onAddToCaButtonClick: (int index) {
                          setState(() {
                            BlocProvider.of<ProductCubit>(context)
                                .updateAddToCaList(state.productModel![index]);
                          });
                          return null;
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
