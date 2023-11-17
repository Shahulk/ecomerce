import 'dart:developer';

import 'package:ecomerce/Provider/cartprovider.dart';
import 'package:ecomerce/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
class Detailspage extends StatelessWidget{
  String ? name , image , description;
  int id;
  double price ;
  Detailspage(
  { required this.id,
    required this.image,
    required this.price,
    required this.name,
    required this.description

}
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width*0.8,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: NetworkImage(image!),
                  ),
                ),
                // Positioned(
                //   left: 15,
                //     top: 20,
                //     child:CircleAvatar(
                //       backgroundColor: Colors.grey.withOpacity(0.5),
                //       child: IconButton(
                //         icon: Container(
                //           child: Icon(
                //             Icons.arrow_back_ios_new,
                //             color: Colors.black,
                //           ),
                //         ),
                //         onPressed: () {
                //           Navigator.push(context, MaterialPageRoute(builder: (context){
                //             return Homepage();
                //
                //           }));
                //         },
                //       ),
                //     ) )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: (20)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),

                )
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 2, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10),
                      child: Text(
                        name!,style: TextStyle(color: Colors.grey.shade600,fontSize: 22,fontWeight: FontWeight.bold),


                      ),
                    ),Text("Rs. " + price!.toString(),style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(
                      height: 20,

                    ),
                    Text(description!,textScaleFactor: 1.1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 10,)

                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(onTap: (){  var existingItemCart = context
            .read<Cart>().getItems.firstWhereOrNull((element) => element.id == id);
        if (existingItemCart != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Text("This item already in cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }

        else {
          context.read<Cart>().addItem(id, name!, price, 1, image!);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Text("Add to Cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
        }},



          child: Container(
            height: 46,
            decoration: BoxDecoration(
                color: Colors.black,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(child: Text("Add to cart",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
            color: Colors.white),
            )
          ),

    ),)),);
  }

}