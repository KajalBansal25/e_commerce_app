import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/constants/api_service.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:e_commerce_app/screen/product_page.dart';
import 'package:flutter/material.dart';

import 'deatils_of_product_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ProductModel>? _productModel = [];
  double totalPrice = 0;
  @override
  void initState() {
    // _controller.startAutoPlay();
    super.initState();
    _getData();
  }

  CarouselController _controller = new CarouselController();

  List<String> images = [
    "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
  ];

  void _getData() async {
    _productModel = (await ApiService().getProducts())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.stopAutoPlay();
  }

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Dla',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                // height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: CarouselSlider(
                  items: images.map<Widget>((index) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(index),
                                  fit: BoxFit.contain)));
                    });
                  }).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    // height: MediaQuery.of(context).size.height * 0.5,
                    aspectRatio: 1 / 1,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlay: true,

                    onPageChanged: (position, reason) {
                      print(reason);
                      print(CarouselPageChangedReason.controller);
                      setState(() {
                        _currentIndex = position;
                      });
                    },
                    enableInfiniteScroll: true,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(images.length, _currentIndex),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductPage())),
                      child: Row(
                        children: const [
                          Text(
                            'All Products',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.play_arrow)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 500.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _productModel!
                        .map(
                          (product) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomDetailPage(
                                            prodId: product.id,
                                          )));
                            },
                            child: SizedBox(
                              width: 250.0,
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        Image(
                                            fit: BoxFit.fill,
                                            height: 200,
                                            width: 200,
                                            image: NetworkImage(
                                                "${product.image}")),
                                        const Positioned(
                                          top: 1,
                                          right:
                                              1, //give the values according to your requirement
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 28.0,
                                          ),
                                        ),
                                      ]),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('${product.category}'),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text('Rs. ${product.price}'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }
}
