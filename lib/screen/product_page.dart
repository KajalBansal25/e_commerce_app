import 'package:badges/badges.dart';
import 'package:e_commerce_app/cubit/category_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_card.dart';
import 'package:e_commerce_app/utils/scaling.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProductData();
    return SafeArea(
        top: true,
        child: Scaffold(
          body: Padding(
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
                      "All Products",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: normalizedWidth(context, 22)),
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
                                  builder: (context) => Tabs(tabIndex: 2)));
                        },
                        icon: const Icon(Icons.shopping_cart_outlined),
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
                          productModel: (state).productModel,
                          onFavButtonClick: (int index) {
                            setState(() {
                              BlocProvider.of<ProductCubit>(context)
                                  .updateFavouriteList(
                                      (state).productModel![index]);
                              BlocProvider.of<CategoryCubit>(context)
                                  .updateFavouriteList(
                                      (state).productModel![index].id!);
                            });
                            return null;
                          },
                          parentContext: context,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
