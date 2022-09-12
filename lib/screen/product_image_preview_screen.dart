import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/utils/Scaling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class ProductImagePreviewScreen extends StatefulWidget {
  const ProductImagePreviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductImagePreviewScreen> createState() =>
      _ProductImagePreviewScreenState();
}

class _ProductImagePreviewScreenState extends State<ProductImagePreviewScreen> {
  List<String> images = [
    "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
  ];
  final CarouselController _controller = CarouselController();

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
            if (kDebugMode) {
              print(currentIndex);
            }
          });
          _controller.jumpToPage(currentIndex);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: normalizedHeight(context, 3)!,horizontal: normalizedWidth(context, 3)!),
          width: MediaQuery.of(context).size.width * 0.16,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(images[index]),
              fit: BoxFit.fitHeight,
            ),
            border: Border.all(
                width: normalizedWidth(context, 2)!,
                color: currentIndex == index ? Colors.blue : Colors.grey),
          ),
        ),
      );
    });
  }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Center(
            child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new))
            ],
          ),
          CarouselSlider(
              carouselController: _controller,
              items: images.map<Widget>((index) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(index),
                              fit: BoxFit.contain)));
                });
              }).toList(),
              options: CarouselOptions(
                  // initialPage: currentIndex,
                  height: MediaQuery.of(context).size.height * 0.6,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (position, reason) {
                    setState(() {
                      currentIndex = position;
                    });
                  })),
          const Expanded(child: Text('')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, currentIndex),
          )
        ])),
      )),
    );
  }
}
