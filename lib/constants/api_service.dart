import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/cart_model.dart';
import '../model/product_model.dart';
import '../model/single_product_modal.dart';
import '../model/user_data_modal.dart';
import 'api_constants.dart';

class ApiService {
  Future<List<ProductModel>?> getProducts() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointAllProducts);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProductModel> model = productModelFromJson(response.body);

        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ProductModel>?> getProductsByCategory(category) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointCategory + category);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<ProductModel> model = productModelFromJson(response.body);

        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CartModel>?> getCartProduct() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointCartProducts);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<CartModel> model = cartModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<Userdata?> getUserData() async {
    var url = Uri.parse('https://fakestoreapi.com/users/1');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      return Userdata.fromJson(temp);
    }
    return null;
  }
}
