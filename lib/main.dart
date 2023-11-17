import 'dart:developer';

import 'package:ecomerce/appbar.dart';
import 'package:ecomerce/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'Provider/cartprovider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // bool? isLoggedIn;
  // @override
  // void initState() {
  //   super.initState();
  //   _checkSession();
  // }
  //
  // void _checkSession() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  //   });
  //   log("isloggedin = " + isLoggedIn.toString());
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Loginpage());
  }
}
