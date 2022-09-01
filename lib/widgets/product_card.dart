import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/product_model.dart';

import '../constants/api_service.dart';
import '../model/product_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, required this.index}) : super(key: key);
  final int? index;
  @override
  State<ProductCard> createState() => _ProductCardState(index);
}

class _ProductCardState extends State<ProductCard> {
  late List<ProductModel>? _productModel = [];
  final int? index;
  _ProductCardState(this.index);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    _productModel = (await ApiService().getProducts())!;
    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print("card pressed");
      },
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Colors.grey,
          elevation: 5,
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                          fit: BoxFit.cover, '${_productModel![index!].image}'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_outline,
                              color: Color.fromARGB(255, 255, 17, 0)),
                          onPressed: () {
                            // ignore: avoid_print
                            print("heart pressed");
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "${_productModel![index!].title}",
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
                    "${_productModel![index!].price}",
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
                          Color.fromARGB(255, 156, 155, 155))),
                  onPressed: () {},
                  child: const Text("Add to Cart"))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
