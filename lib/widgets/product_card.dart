// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../screen/details_of_product_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);
  // final int? index;
  final List<ProductModel>? productModel;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  get _productModel => widget.productModel;

  // final List<ProductModel>? _productModel;

  // _ProductCardState(this._productModel);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _productModel?.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomDetailPage(
                          prodId: _productModel![index].id.toString(),
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
                                '${_productModel![index].image}'),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _productModel![index].isFavourite == false
                            ? IconButton(
                                icon: const Icon(Icons.favorite_outline,
                                    color: Color.fromARGB(255, 255, 17, 0)),
                                onPressed: () {
                                  setState(() {
                                    _productModel![index].favourite();
                                  });
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.favorite,
                                    color: Color.fromARGB(255, 255, 17, 0)),
                                onPressed: () {
                                  setState(() {
                                    _productModel![index].favourite();
                                  });
                                },
                              )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${_productModel![index].title}",
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
                      "${_productModel![index].price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
}
