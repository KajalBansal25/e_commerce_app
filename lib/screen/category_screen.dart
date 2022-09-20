import 'package:badges/badges.dart';
import 'package:e_commerce_app/cubit/category_cubit.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_card.dart';
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
    BlocProvider.of<CategoryCubit>(context).getProdByCategory(widget.category);
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.fromLTRB(normalizedWidth(context, 8)!,
            normalizedHeight(context, 16)!, normalizedWidth(context, 8)!, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CategoryCubit>(context)
                        .updateCateogyState();
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
                              builder: (context) => Tabs(
                                    tabIndex: 2,
                                  )));
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
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  // print();
                  if (state is! CatergoryLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return productCard(
                      productModel: state.listOfAllCatergory[widget.category],
                      onFavButtonClick: (int index) {
                        setState(() {
                          state.listOfAllCatergory[widget.category][index]
                              .favourite();
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
      )),
    );
  }
}
