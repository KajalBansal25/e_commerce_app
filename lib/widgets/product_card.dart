// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../screen/details_of_product_page.dart';

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
                  builder: (parentContext) => CustomDetailPage(
                        prodId: productModel![index].id.toString(),
                      )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Colors.grey,
          elevation: 5,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.network(
                              fit: BoxFit.contain,
                              height: 180,
                              '${productModel![index].image}'),
                        ),
                      ],
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
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${productModel[index].title}",
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 118, 111, 111),
                      ),
                    ),
                  ),
                  Text(
                    "\$ ${productModel[index].price}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 156, 155, 155))),
                  onPressed: () {},
                  child: const Text("Add to Cart"))
            ],
          ),
        ),
      );
    },
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 350,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10),
  );
}
