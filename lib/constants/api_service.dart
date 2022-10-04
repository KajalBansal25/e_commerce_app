import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/cart_model.dart';
import '../model/product_model.dart';
import '../model/user_data_modal.dart';
import 'api_constants.dart';

class ApiService {
  Future<List<ProductModel>?> getProducts() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointAllProducts);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        Map<String, dynamic> output = {"products": data};
        ProductListModel model = ProductListModel.fromJson(output);
        return model.products;
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<ProductModel>?> getProductsByCategory(category) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointCategory + category);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        Map<String, dynamic> output = {"products": data};
        ProductListModel model = ProductListModel.fromJson(output);
        return model.products;
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
        List data = jsonDecode(response.body);
        Map<String, dynamic> output = {"carts": data};
        CartListModel model = CartListModel.fromJson(output);
        return model.carts;
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

  Future<bool> postData({dynamic object}) async {
    try {
      var payload = jsonEncode(object);
      var uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.addToCart);
      var response = await http.post(
        uri,
        body: payload,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("Error postData $e");
    }
    return false;
  }

  Future<Userdata?> putUserData({dynamic object}) async {
    try {
      var payload = jsonEncode(object);
      var uri = Uri.parse('https://fakestoreapi.com/users/7');
      var response = await http.put(
        uri,
        body: payload,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Userdata modal = Userdata.fromJson((jsonDecode(response.body)));
        return modal;
      }
    } catch (e) {
      log("Error postData $e");
    }
    return null;
  }

  Future<bool> postUserVerification({required String username, required String password}) async {
    try {
      var uri = Uri.parse('https://fakestoreapi.com/auth/login');
      var response = await http.post(
        uri,
        body: {"username": username, "password": password},
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log("Error postData $e");
    }
    return false;
  }
}
