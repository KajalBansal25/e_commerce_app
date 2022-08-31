import 'dart:developer';

import 'package:e_commerce_app/constants/api_constants.dart';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:http/http.dart' as http;

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
}
