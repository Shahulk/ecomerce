// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsModel> orderDetailsModelFromJson(String str) => List<OrderDetailsModel>.from(json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

String orderDetailsModelToJson(List<OrderDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsModel {
  int id;
  int username;
  double totalamount;
  String paymentmethod;
  DateTime date;
  List<Product> products;

  OrderDetailsModel({
    required this.id,
    required this.username,
    required this.totalamount,
    required this.paymentmethod,
    required this.date,
    required this.products,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    id: json["id"],
    username: json["username"],
    totalamount: json["totalamount"]?.toDouble(),
    paymentmethod: json["paymentmethod"],
    date: DateTime.parse(json["date"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "totalamount": totalamount,
    "paymentmethod": paymentmethod,
    "date": date.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String productname;
  double price;
  String image;
  int quantity;

  Product({
    required this.productname,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productname: json["productname"],
    price: json["price"]?.toDouble(),
    image: json["image"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productname": productname,
    "price": price,
    "image": image,
    "quantity": quantity,
  };
}
