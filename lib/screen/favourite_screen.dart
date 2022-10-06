import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/scaling.dart';
import '../widgets/product_card.dart';
import '../model/product_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProductData();
    return SafeArea(
      top: true,
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.fromLTRB(normalizedWidth(context, 8)!,
            normalizedHeight(context, 16)!, normalizedWidth(context, 8)!, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  normalizedWidth(context, 8)!,
                  normalizedHeight(context, 8)!,
                  normalizedWidth(context, 8)!,
                  normalizedHeight(context, 8)!),
              child: Text(
                "Your Favourites",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: normalizedWidth(context, 22)),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is! ProductLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<ProductModel>? favProduct =
                        BlocProvider.of<ProductCubit>(context).favouriteList;
                          // print("hello Favourite Screen ${favProduct?.length}");
                    return productCard(
                      productModel: favProduct,
                      onFavButtonClick: (int index) {
                        setState(() {
                          BlocProvider.of<ProductCubit>(context)
                              .updateFavouriteList(favProduct![index]);
                        });
                        return null;
                      },
                      onAddToCaButtonClick: (int index){
                        setState(() {
                          BlocProvider.of<ProductCubit>(context)
                              .updateAddToCaList(favProduct![index]);
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
