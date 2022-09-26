import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/cubit/category_cubit.dart';
import 'package:e_commerce_app/cubit/product_cubit.dart';
import 'package:e_commerce_app/screen/category_screen.dart';
import 'package:e_commerce_app/screen/product_page.dart';
import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();

  List<String>? images = [
    "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
    "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
  ];

  List<String>? categoryImages = [
    "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
    "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
    "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
  ];

  List<String>? categoryName = [
    "men's clothing",
    "jewelery",
    "electronics",
    "women's clothing"
  ];

  @override
  void dispose() {
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
              Text(
                'DLA',
                style: TextStyle(
                    fontSize: normalizedWidth(context, 30),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: normalizedHeight(context, 15),
              ),
              SizedBox(
                width: normalizedWidth(context, 300),
                child: CarouselSlider(
                  items: images?.map<Widget>((index) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                          width: normalizedWidth(context, 300),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(index),
                                  fit: BoxFit.contain)));
                    });
                  }).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    aspectRatio: 1 / 1,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    onPageChanged: (position, reason) {
                      if (kDebugMode) {
                        print(reason);
                        print(CarouselPageChangedReason.controller);
                      }
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
                children: indicators(images?.length, _currentIndex),
              ),
              Padding(
                padding: EdgeInsets.all(normalizedWidth(context, 20)!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories ',
                      style: TextStyle(
                          fontSize: normalizedWidth(context, 18),
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<ProductCubit>.value(
                                    value:
                                        BlocProvider.of<ProductCubit>(context),
                                    child: BlocProvider<CategoryCubit>.value(
                                      value: BlocProvider.of<CategoryCubit>(
                                          context),
                                      child: const ProductPage(),
                                    ),
                                  ))),
                      child: Row(
                        children: [
                          Text(
                            'All Products',
                            style: TextStyle(
                                fontSize: normalizedWidth(context, 18),
                                fontWeight: FontWeight.bold),
                          ),
                          const Icon(Icons.play_arrow)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: normalizedHeight(context, 308),
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider<CategoryCubit>.value(
                              value: BlocProvider.of<CategoryCubit>(context),
                              child: BlocProvider<ProductCubit>.value(
                                value: BlocProvider.of<ProductCubit>(context),
                                child: CategoryScreen(
                                  category: categoryName![index],
                                ),
                              ),
                            ),
                          ));
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: normalizedHeight(context, 10)!,
                          vertical: normalizedWidth(context, 20)!),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: normalizedHeight(context, 8)!,
                            vertical: normalizedWidth(context, 8)!),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                                fit: BoxFit.fitHeight,
                                height: normalizedHeight(context, 200),
                                width: normalizedWidth(context, 200),
                                image: NetworkImage(categoryImages![index])),
                            SizedBox(
                              height: normalizedHeight(context, 10),
                            ),
                            Text(
                              categoryName![index].toUpperCase(),
                              style: TextStyle(
                                  fontSize: normalizedWidth(context, 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: categoryImages?.length,
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
        margin: EdgeInsets.symmetric(
            horizontal: normalizedWidth(context, 3)!,
            vertical: normalizedHeight(context, 3)!),
        width: normalizedWidth(context, 10),
        height: normalizedHeight(context, 30),
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }
}
