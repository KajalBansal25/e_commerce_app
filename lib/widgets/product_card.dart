import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/screen/details_of_product_page.dart';

Widget productCard(
    {required List<ProductModel>? productModel,
    required VoidCallback? Function(int index) onFavButtonClick,
    required VoidCallback? Function(int index) onAddToCaButtonClick,
    BuildContext? parentContext}) {
  return productModel == null
      ? const Center(child: CircularProgressIndicator())
      : GridView.builder(
          itemCount: productModel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  parentContext!,
                  MaterialPageRoute(
                    builder: (parentContext) => MultiBlocProvider(
                      providers: [
                        BlocProvider<ProductCubit>.value(
                          value: BlocProvider.of<ProductCubit>(context),
                        ),
                      ],
                      child: CustomDetailPage(
                        prodId: productModel[index].id,
                        productModal: productModel[index],
                      ),
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    normalizedWidth(context, 15)!,
                  ),
                ),
                elevation: 5,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: normalizedHeight(context, 5)!,
                                horizontal: normalizedWidth(context, 16)!,
                              ),
                              child: Center(
                                child: Image.network(
                                  fit: BoxFit.scaleDown,
                                  height: normalizedHeight(context, 180),
                                  '${productModel[index].image}',
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                productModel[index].isFavourite == false
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.favorite_outline,
                                          color:
                                              Color.fromARGB(255, 255, 17, 0),
                                        ),
                                        onPressed: () =>
                                            onFavButtonClick(index),
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color:
                                              Color.fromARGB(255, 255, 17, 0),
                                        ),
                                        onPressed: () =>
                                            onFavButtonClick(index),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: normalizedWidth(context, 8)!,
                              vertical: normalizedHeight(context, 8)!,
                            ),
                            child: Text(
                              "${productModel[index].title}",
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: normalizedHeight(context, 16)!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$ ${productModel[index].price}",
                            style: TextStyle(
                              fontSize: normalizedHeight(context, 16)!,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 8)!,
                      ),
                      child: productModel[index].isAddToCart == false
                          ? ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      normalizedWidth(context, 25)!,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                CartModel cart = CartModel(
                                  id: 11,
                                  userId: productModel[index].id,
                                  date: DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now()),
                                  products: [
                                    Product(
                                      productId: 2,
                                      quantity: 1,
                                    ),
                                  ],
                                  v: 0,
                                );
                                await ApiService().postData(object: cart);
                                onAddToCaButtonClick(index);
                              },
                              child: const Center(
                                child: Text("Add to Cart"),
                              ),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      normalizedWidth(context, 25)!,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () => onAddToCaButtonClick(index),
                              child: const Center(
                                child: Text("Remove From Cart"),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: normalizedWidth(parentContext!, 200)!,
            mainAxisExtent: MediaQuery.of(parentContext).size.height * 0.45,
            crossAxisSpacing: normalizedWidth(parentContext, 10)!,
            mainAxisSpacing: normalizedHeight(parentContext, 20)!,
          ),
        );
}
