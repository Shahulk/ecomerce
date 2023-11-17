import 'dart:developer';

import 'package:ecomerce/cartpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'orderdetails.dart';


class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
           color: Colors.white

          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "S H O P  W A V E",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),SizedBox(
                height: 20,
              ),

              Divider(),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: (){},
                leading: const Icon(Icons.home_outlined),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 15.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
              ),ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cartpage()),
                  );
                },


                leading: Icon(Icons.shopping_cart),
                title: const Text(
                  'Cart page',
                  style: TextStyle(fontSize: 15.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),

              ),

              ListTile(
                leading: const Icon(Icons.book_online_outlined),
                title: const Text(
                  'Order Details',
                  style: TextStyle(fontSize: 15.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderDetails()),
                  );
                },
              ),

              Divider(),
              ListTile(
                onTap: ()async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("isLoggedIn", false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>Loginpage()),
                  );
                },
                leading: Icon(Icons.power_settings_new_rounded,
                    color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 15.0),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}