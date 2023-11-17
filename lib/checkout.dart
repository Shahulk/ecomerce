import 'dart:convert';
import 'dart:developer';
import 'package:ecomerce/appbar.dart';
import 'package:http/http.dart'as http;
import 'package:ecomerce/Models/usermodel.dart';
import 'package:ecomerce/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/cartprovider.dart';

class Checkout extends StatefulWidget {
  List<CartProduct> cart;
Checkout({super.key, required this.cart});
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int selectedValue = 1;
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  String? username;

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("isloggedin = " + username.toString());
  }
  orderPlace(
      List<CartProduct> cart,
      String amount,
      String paymentmethod,
      String date,
      String name,
      String address,
      String phone,
      ) async {
    try {
      String jsondata = jsonEncode(cart);
      log('jsondata =${jsondata}');

      final vm = Provider.of<Cart>(context, listen: false);

      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/order.php"
            // Webservice.mainurl1 + "order.jsp"
          ),
          body: {
            "username": username,
            "amount": amount,
            "paymentmethod": paymentmethod,
            "date": date,
            "quantity": vm.count.toString(),
            "cart": jsondata,
            'name': name,
            "address": address,
            "phone": phone,
          });

      if (response.statusCode == 200) {
        log(response.body);
        if (response.body.contains("Success")) {
          vm.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("YOUR ORDER SUCCESSFULLY COMPLETED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Homepage();
            },
          ));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
  String? name,phone,address;
String paymentmethod = "Cash on Delivery";
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 30,
        ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Checkout",
        style: TextStyle(fontSize: 30,
        color: Colors.white),),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0),
            child:
                FutureBuilder<UserModel?>(
                  future: Webservice().fetchUser(username.toString()),builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    name=snapshot.data!.name;
                    phone= snapshot.data!.phone;
                    address=snapshot.data!.address;
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Name :", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data!.name),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Phone :", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18,
                              ),),
                              Text(snapshot.data!.phone),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Address : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.5,
                                child: Text(snapshot.data!.address,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                )
              ),
            SizedBox(
              height: 10,

            ),
            RadioListTile(
              activeColor: Colors.blue.shade900,
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = 'Cash on Delivery';
                });
              },
              title: const Text(
                'Cash on Delivery',style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Pay Cash at home',style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),  RadioListTile(
              activeColor: Colors.blue.shade900,
              value: 2,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                paymentmethod = 'Online Payment';
                });
              },
              title: const Text(
                'Pay Now',style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Online Payment',style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ) ,
bottomSheet: Padding(
  padding: const EdgeInsets.all(8.0),
  child:   InkWell(onTap: () {
    String datetime = DateTime.now().toString();
orderPlace(widget.cart, vm.totalPrice.toString(), paymentmethod, datetime, name!, address!, phone!);
  },
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: Text("Checkout",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
          color: Colors.white),
      )
      ),

    ),
  ),
),
    );
  }
}
