import 'dart:convert';
import 'dart:developer';

import 'package:ecomerce/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Registrationpage extends StatefulWidget {
  const Registrationpage({Key? key}) : super(key: key);

  @override
  State<Registrationpage> createState() => _RegistrationpageState();
}

class _RegistrationpageState extends State<Registrationpage> {
  String ? name,phone,address,username,password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  registration(String name, phone, address, username, password) async {
    try {
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> Data = {
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/registration.php"

        ),
        body: Data,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("registration successfully completed",);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("REGISTRATION SUCCESSFULLY COMPLETED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Loginpage();
            },
          ));
        } else {
          log("registration failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("REGISTRATION FAILED !!!",
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
    return  Scaffold(
      backgroundColor: Colors.red.shade700,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Center(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "Register Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
                Text("Complete Your Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(
                  height: 70,
                ),  Padding(
                  padding: const EdgeInsets.all( 10),
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
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          decoration: InputDecoration.collapsed(
                            hintText: "Name",
                          ),
                          onChanged: (text) {
                            setState(() {
                              name = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Name text";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),  Padding(
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
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          decoration: InputDecoration.collapsed(
                            hintText: "Phone",
                          ),
                          onChanged: (text) {
                            setState(() {
                              phone = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Phone text";
                            }else if(
                            value.length>10||value.length<10
                            ){
                              return "Please enter valid number";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: TextFormField(
                          maxLines: 4,
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          decoration: InputDecoration.collapsed(
                            hintText: "Address",
                          ),
                          onChanged: (text) {
                            setState(() {
                              address = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Address text";
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
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          decoration: InputDecoration.collapsed(
                            hintText: "username",
                          ),
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Username text";
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
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          decoration: InputDecoration.collapsed(
                            hintText: "Password",
                          ),
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Your Password text";
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
                            log("username = " + username.toString());
                            log("Password = " + password.toString());
                            registration(name!,phone,address,username,password);
                          }
                        }, child: Text("Register",
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
    );
  }
}
