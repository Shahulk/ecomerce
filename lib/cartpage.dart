import 'package:ecomerce/Provider/cartprovider.dart';
import 'package:ecomerce/checkout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Cart",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty?SizedBox():
            IconButton(
                onPressed: () {
                  context.read<Cart>().clearCart();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ))
          ],
        ),
        body:
        Consumer<Cart>(
          builder: (context, cartvalue, child) {
            if(
            cartvalue.getItems.isNotEmpty
            )
            return

          ListView.builder(
            itemCount: cartvalue.count,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Padding(
                            padding: EdgeInsets.only(left: 9),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(cartvalue.getItems[index].imagesUrl), fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  cartvalue.getItems[index].name,
                                  maxLines:2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cartvalue.getItems[index].price.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade900),
                                    ),
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {cartvalue.getItems[index].qty==1?cartvalue.removeItem(cartvalue.getItems[index]):
                                                cartvalue.reduceByOne(cartvalue.getItems[index]);
                                              },
                                              icon:cartvalue.getItems[index].qty==1?  Icon(
                                                Icons.delete,
                                                size: 18,
                                              ):
                                              Icon(
                                                Icons.minimize_rounded,
                                                size: 18,
                                              )),
                                          Text(
                                            cartvalue.getItems[index].qty.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red.shade900),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                cartvalue.increment(
                                                  cartvalue.getItems[index]
                                                );
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 18,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              );
            },
          ); return Center(
              child: Text("Empty Cart",style: TextStyle(fontWeight: FontWeight.bold),),
            ); },
        ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Total : "+  context.watch<Cart>().totalPrice.toString(),style: TextStyle(
              fontSize: 20,
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold
            )),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkout(cart: context.read<Cart>().getItems,)),
                );
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black
                ),
                child: Center(
                  child: Text(
                    "Order Now",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
