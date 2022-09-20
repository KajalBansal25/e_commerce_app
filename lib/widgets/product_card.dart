import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../model/product_model.dart';
import '../screen/details_of_product_page.dart';
import '../utils/scaling.dart';

Widget productCard(
    {required List<ProductModel>? productModel,
    required VoidCallback? Function(int index) onFavButtonClick,
    BuildContext? parentContext}) {
  return GridView.builder(
    itemCount: productModel?.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              parentContext!,
              MaterialPageRoute(
                  builder: (parentContext) => BlocProvider<ProductCubit>.value(
                        value: BlocProvider.of<ProductCubit>(context),
                        child: CustomDetailPage(
                          prodId: productModel![index].id.toString(),
                          productModal: productModel[index],
                        ),
                      )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(normalizedWidth(context, 15)!),
          ),
          elevation: 5,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: normalizedHeight(context, 5)!,
                          horizontal: normalizedWidth(context, 16)!),
                      child: Center(
                        child: Image.network(
                            fit: BoxFit.scaleDown,
                            height: normalizedHeight(context, 180),
                            '${productModel![index].image}'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        productModel[index].isFavourite == false
                            ? IconButton(
                                icon: const Icon(Icons.favorite_outline,
                                    color: Color.fromARGB(255, 255, 17, 0)),
                                onPressed: () => onFavButtonClick(index))
                            : IconButton(
                                icon: const Icon(Icons.favorite,
                                    color: Color.fromARGB(255, 255, 17, 0)),
                                onPressed: () => onFavButtonClick(index))
                      ],
                    ),
                  ]),
                ],
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: normalizedWidth(context, 8)!,
                        vertical: normalizedHeight(context, 8)!),
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
              )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: normalizedWidth(context, 8)!),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              normalizedWidth(context, 25)!),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: const Center(child: Text("Add to Cart"))),
              )
            ],
          ),
        ),
      );
    },
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: normalizedWidth(parentContext!, 200)!,
        mainAxisExtent: MediaQuery.of(parentContext).size.height * 0.45,
        // childAspectRatio: 0.55,
        crossAxisSpacing: normalizedWidth(parentContext, 10)!,
        mainAxisSpacing: normalizedHeight(parentContext, 20)!),
  );
}
