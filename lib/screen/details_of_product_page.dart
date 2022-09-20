import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/screen/product_image_preview_screen.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/product_model.dart';
import '../utils/Scaling.dart';

//ignore: must_be_immutable
class CustomDetailPage extends StatefulWidget {
  CustomDetailPage({Key? key, required this.prodId, required this.productModal})
      : super(key: key);
  String prodId;
  ProductModel productModal;
  @override
  State<CustomDetailPage> createState() => _CustomDetailPageState();
}

class _CustomDetailPageState extends State<CustomDetailPage> {
  final List<String> reportList = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String selectedChoice = "S";
  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in reportList) {
      choices.add(Container(
        padding: EdgeInsets.symmetric(
            horizontal: normalizedWidth(context, 2)!,
            vertical: normalizedHeight(context, 2)!),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Colors.grey.shade600,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
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
              normalizedHeight(context, 0)!),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<ProductCubit>().getProductData();
                      Navigator.pop(
                        context,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tabs(tabIndex: 2)),
                        ModalRoute.withName('/'),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
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
                                      const ProductImagePreviewScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: normalizedWidth(context, 10)!,
                              vertical: normalizedHeight(context, 10)!),
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
                            left: normalizedHeight(context, 30)!),
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
                            top: normalizedHeight(context, 10)!),
                        child: ExpansionTile(
                          title: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: normalizedWidth(context, 15),
                                fontWeight: FontWeight.w500),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                '${widget.productModal.description}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                      (widget.productModal.category.toString() ==
                                  "Category.MEN_S_CLOTHING" ||
                              widget.productModal.category.toString() ==
                                  "Category.WOMEN_S_CLOTHING")
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedWidth(context, 30)!),
                              child: const Text(
                                'Size',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          : const Text(''),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: normalizedWidth(context, 25)!),
                          child: (widget.productModal.category.toString() ==
                                      "Category.MEN_S_CLOTHING" ||
                                  widget.productModal.category.toString() ==
                                      "Category.WOMEN_S_CLOTHING")
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    children: _buildChoiceList(),
                                  ),
                                )
                              : const Text('')),
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
                        vertical: normalizedHeight(context, 0)!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.productModal.isFavourite == false
                            ? Container(
                                height: normalizedHeight(context, 35),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.redAccent),
                                width: normalizedWidth(context, 65),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_outline,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        // widget.productModal.favourite();
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
                                    color: Colors.redAccent),
                                width: normalizedWidth(context, 65),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite,
                                        color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        // widget.productModal.favourite();
                                        BlocProvider.of<ProductCubit>(context)
                                            .updateFavouriteListFromDetailScreen(
                                                widget.productModal);
                                      });
                                    },
                                  ),
                                ),
                              ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: normalizedWidth(context, 80)!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    normalizedWidth(context, 60)!),
                              )),
                          onPressed: () {},
                          child: const Text(
                            'Add to Cart',
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

  onFavButtonClick(index) {}
}
