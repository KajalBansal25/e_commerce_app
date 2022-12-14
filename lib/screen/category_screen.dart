import 'package:badges/badges.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/widgets/product_card.dart';
import 'package:e_commerce_app/utils/scaling.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context)
        .getProductByCategories(widget.category);
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
                    widget.category.toString().toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: normalizedWidth(context, 22)!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoaded) {
                          return Badge(
                            badgeContent: Text(
                              "${state.addToCartList!.length}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tabs(
                                      tabIndex: 2,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_cart_outlined),
                            ),
                          );
                        }
                        return const Text("");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: normalizedHeight(context, 20),
              ),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      return productCard(
                        parentContext: context,
                        productModel: state.categoriesData![widget.category],
                        onFavButtonClick: (int index) {
                          setState(() {
                            BlocProvider.of<ProductCubit>(context)
                                .updateFavouriteList((state)
                                    .categoriesData![widget.category][index]);
                            context.read<ProductCubit>().getProductData();
                          });
                          return null;
                        },
                        onAddToCaButtonClick: (int index) {
                          setState(() {
                            BlocProvider.of<ProductCubit>(context)
                                .updateAddToCaList((state)
                                    .categoriesData![widget.category][index]);
                          });
                          return null;
                        },
                      );
                    }
                    return const Text("data");
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
