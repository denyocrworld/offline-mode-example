import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:offline_app/service/connection_service/connection_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService {
  Future<List> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isOffline = await ConnectionService().isOffline();
    print("isOffline: $isOffline");
    if (isOffline) {
      var jsonString = prefs.getString("products") ?? "[]";
      return jsonDecode(jsonString);
    }

    var response = await Dio().get(
      "https://capekngoding.com/demoapi/api/products",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map obj = response.data;
    var list = obj["data"];

    prefs.setString("products", jsonEncode(list));
    return list;
  }
}
