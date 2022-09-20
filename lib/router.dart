import 'package:e_commerce_app/screen/category_screen.dart';
import 'package:e_commerce_app/screen/order_detail_screen.dart';
import 'package:e_commerce_app/screen/payment_screen.dart';
import 'package:e_commerce_app/screen/product_image_preview_screen.dart';
import 'package:e_commerce_app/screen/product_page.dart';
import 'package:e_commerce_app/screen/profile_update_screen.dart';
import 'package:e_commerce_app/screen/single_order_detail_screen.dart';
import 'package:e_commerce_app/screen/tabs_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Tabs(
                  tabIndex: 0,
                ));
      case '/all_products':
        return MaterialPageRoute(builder: (_) => const ProductPage());
      // case '/single_product':
      //   return MaterialPageRoute(
      //       builder: (_) => CustomDetailPage(
      //             prodId: arguments.toString(),
      //             productModal: arguments as ProductModel,
      //           ));
      case '/product_image_screen':
        return MaterialPageRoute(
            builder: (_) => const ProductImagePreviewScreen());
      case '/cart':
        return MaterialPageRoute(
            builder: (_) => Tabs(
                  tabIndex: 2,
                ));
      case '/favourite':
        return MaterialPageRoute(
            builder: (_) => Tabs(
                  tabIndex: 1,
                ));
      case '/profile':
        return MaterialPageRoute(
            builder: (_) => Tabs(
                  tabIndex: 3,
                ));
      case '/profile_update':
        return MaterialPageRoute(builder: (_) => const ProfileUpdate());
      case '/payment':
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case '/order_detail':
        return MaterialPageRoute(builder: (_) => const OrderDetailScreen());
      case '/single_order_screen':
        return MaterialPageRoute(
            builder: (_) => const SingleOrderDetailScreen());
      case '/category':
        return MaterialPageRoute(
            builder: (_) => CategoryScreen(category: arguments.toString()));
      default:
        return null;
    }
  }
}
