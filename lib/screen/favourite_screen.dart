import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/Scaling.dart';
import '../widgets/product_card.dart';
// import '../constants/api_service.dart';
import '../model/product_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with AutomaticKeepAliveClientMixin {
  // late List<ProductModel>? _productModel = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _getData();
  // }

  // void _getData() async {
  //   _productModel = (await ApiService().getProducts())!;
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProductData();
    super.build(context);
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
                  normalizedWidth(context, 8)!),
              child: Text(
                "Your Favourites",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: normalizedWidth(context, 22)),
              ),
            ),
            SizedBox(
              height: normalizedHeight(context, 20),
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is! ProductLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<ProductModel>? favProduct = (state)
                        .productModel
                        ?.where((element) => element.isFavourite)
                        .toList();
                    return productCard(
                      productModel: favProduct,
                      onFavButtonClick: (int index) {
                        setState(() {
                          favProduct![index].favourite();
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
