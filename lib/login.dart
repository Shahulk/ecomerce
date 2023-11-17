

import 'dart:convert';
import 'dart:developer';
import 'package:ecomerce/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecomerce/appcolor.dart';
import 'package:ecomerce/resgistration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String? Username, Password;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Homepage()));
    }
  }
  bool processing = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

 login(String  username, password) async {
    try {
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> Data = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/login.php"
          // Webservice.mainurl + "registration.jsp"
        ),
        body: Data,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("LOGIN SUCCESSFULLY COMPLETED",
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
        } else {
          log("login failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("LOGIN FAILED !!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }
      } else {
        result = {log(json.decode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://img.freepik.com/premium-vector/online-shopping-with-cart-pop-art-style_24911-19049.jpg"),fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45,color: Colors.black),
                    ),
                  ),
                  Text("Login With Your Username and Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextFormField(
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration.collapsed(
                              hintText: "username",hintStyle: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            onChanged: (text) {
                              setState(() {
                                Username = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Username ";
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration.collapsed(
                              hintText: "Password",hintStyle: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            onChanged: (text) {
                              setState(() {
                                Password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Password ";
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width/2,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          primary: Colors.white,
                          backgroundColor: Colors.black
                        ),
                          onPressed:(){
                          if(_formkey.currentState!.validate()){
                            log("username = " + Username.toString());
                            log("Password = " + Password.toString());
                            login(Username!,Password);
                          }
                          }, child: Text("Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),))),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?",
                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      ),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Registrationpage();
                          },
                          ));
                          log("go to Registration");
                        },
                        child: Text(
                          "Go to Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,

                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
