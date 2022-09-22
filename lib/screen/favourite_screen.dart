import 'package:flutter/material.dart';
import '../utils/Scaling.dart';
import '../widgets/product_card.dart';
import '../constants/api_service.dart';
import '../model/product_model.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
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
    super.build(context);
    return SafeArea(
      top: true,
      child: Scaffold(
          body: _productModel == null || _productModel!.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.fromLTRB(
                      normalizedWidth(context, 8)!,
                      normalizedHeight(context, 16)!,
                      normalizedWidth(context, 8)!,
                      0),
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
                        child: productCard(
                          productModel: _productModel,
                          onFavButtonClick: (int index) {
                            setState(() {
                              _productModel![index].favourite();
                            });
                            return null;
                          },
                          parentContext: context,
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
