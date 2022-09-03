import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../model/single_product_model.dart';
import 'api_constants.dart';

class ApiService {
  Future<List<ProductModel>?> getProducts() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ProductModel> _model = productModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Welcome?> getSingleProducts() async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpointSingleProduct);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Welcome model = welcomeFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
