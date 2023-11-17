import 'dart:convert';
import 'dart:developer';

import 'package:ecomerce/Models/orderdetails.dart';

import 'Models/Categorymodel.dart';
import 'package:http/http.dart'as http;

import 'Models/productmodel.dart';
import 'Models/usermodel.dart';
class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  //http://bootcamp.cyralearnings.com/get_orderdetails.php
  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse("http://bootcamp.cyralearnings.com/getcategories.php"));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<List<ProductModel>> fetchProducts() async {
    final response =
    await http.get(Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<List<ProductModel>?> fetchCategoryproducts(int catid) async {
    try {
      final response = await http.post(Uri.parse("http://bootcamp.cyralearnings.com/get_category_products.php"),body: {
        "catid": catid.toString()
      });

      if (response.statusCode == 200) {
        log("respnse=== "+response.body.toString());
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load Product');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<UserModel?> fetchUser(String username) async {
    try {
      final response = await http.post(Uri.parse("http://bootcamp.cyralearnings.com/get_user.php"),
          body: {'username': username});

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future<List<OrderDetailsModel>?> fetchOrderdetails(String username) async {
    try {
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/get_orderdetails.php") ,
          body: {'username': username});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderDetailsModel>((json) => OrderDetailsModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}