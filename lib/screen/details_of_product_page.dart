import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:e_commerce_app/model/cart_model.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/screen/product_image_preview_screen.dart';

//ignore: must_be_immutable
class CustomDetailPage extends StatefulWidget {
  CustomDetailPage({Key? key, required this.prodId, required this.productModal})
      : super(key: key);
  int? prodId;
  ProductModel productModal;
  @override
  State<CustomDetailPage> createState() => _CustomDetailPageState();
}

class _CustomDetailPageState extends State<CustomDetailPage> {
  final List<String> reportList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String selectedChoice = "S";
  bool responseStatus = false;
  get prodId => widget.prodId;

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in reportList) {
      choices.add(
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: normalizedWidth(context, 2)!,
            vertical: normalizedHeight(context, 2)!,
          ),
          child: ChoiceChip(
            label: Text(
              item,
              style: const TextStyle(color: Colors.white),
            ),
            selectedColor: Colors.redAccent,
            backgroundColor: Colors.grey.shade600,
            selected: selectedChoice == item,
            onSelected: (selected) {
              setState(() {
                selectedChoice = item;
              });
            },
          ),
        ),
      );
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            normalizedWidth(context, 8)!,
            normalizedHeight(context, 16)!,
            normalizedWidth(context, 8)!,
            normalizedHeight(context, 0)!,
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
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tabs(tabIndex: 2),
                                  ),
                                  ModalRoute.withName('/'),
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
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProductImagePreviewScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: normalizedWidth(context, 10)!,
                            vertical: normalizedHeight(context, 10)!,
                          ),
                          child: Image(
                            image: NetworkImage("${widget.productModal.image}"),
                            height: normalizedHeight(context, 350),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: normalizedHeight(context, 20)!,
                          bottom: normalizedHeight(context, 5)!,
                          right: normalizedHeight(context, 30)!,
                          left: normalizedHeight(context, 30)!,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: normalizedWidth(context, 200),
                              child: Text(
                                '${widget.productModal.title}',
                                softWrap: true,
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: normalizedWidth(context, 15),
                                ),
                              ),
                            ),
                            Text(
                              '\$ ${widget.productModal.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: normalizedWidth(context, 19),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: normalizedWidth(context, 15)!,
                          right: normalizedWidth(context, 15)!,
                          top: normalizedHeight(context, 10)!,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: normalizedWidth(context, 15),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                '${widget.productModal.description}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      (widget.productModal.category.toString() ==
                                  "men's clothing" ||
                              widget.productModal.category.toString() ==
                                  "women's clothing")
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: normalizedWidth(context, 30)!,
                              ),
                              child: const Text(
                                'Size',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const Text(''),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: normalizedWidth(context, 25)!,
                        ),
                        child: (widget.productModal.category.toString() ==
                                    "men's clothing" ||
                                widget.productModal.category.toString() ==
                                    "women's clothing")
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  children: _buildChoiceList(),
                                ),
                              )
                            : const Text(''),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: normalizedHeight(context, 35),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: normalizedWidth(context, 16)!,
                      vertical: normalizedHeight(context, 0)!,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.productModal.isFavourite == false
                            ? Container(
                                height: normalizedHeight(context, 35),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.redAccent,
                                ),
                                width: normalizedWidth(context, 65),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ProductCubit>()
                                          .getProductData();
                                      setState(() {
                                        BlocProvider.of<ProductCubit>(context)
                                            .updateFavouriteListFromDetailScreen(
                                                widget.productModal);
                                      });
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                height: normalizedHeight(context, 35),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.redAccent,
                                ),
                                width: normalizedWidth(context, 65),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        BlocProvider.of<ProductCubit>(context)
                                            .updateFavouriteListFromDetailScreen(
                                                widget.productModal);
                                        context
                                            .read<ProductCubit>()
                                            .getProductData();
                                      });
                                    },
                                  ),
                                ),
                              ),
                        widget.productModal.isAddToCart == false
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: normalizedWidth(context, 80)!,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        normalizedWidth(context, 60)!,
                                      ),
                                    )),
                                onPressed: () async {
                                  context
                                      .read<ProductCubit>()
                                      .addToCaList!
                                      .length;
                                  CartModel cart = CartModel(
                                    id: 11,
                                    userId: prodId,
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
                                  responseStatus =
                                      await ApiService().postData(object: cart);
                                  setState(() {
                                    BlocProvider.of<ProductCubit>(context)
                                        .updateAddToCaListFromDetailScreen(
                                            widget.productModal);
                                  });
                                  // ignore: use_build_context_synchronously
                                  context.read<ProductCubit>().getProductData();
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: normalizedWidth(context, 65)!,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        normalizedWidth(context, 60)!,
                                      ),
                                    )),
                                onPressed: () {
                                  setState(() {
                                    BlocProvider.of<ProductCubit>(context)
                                        .updateAddToCaListFromDetailScreen(
                                            widget.productModal);
                                  });
                                  context.read<ProductCubit>().getProductData();
                                },
                                child: const Text(
                                  'Remove From Cart',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
