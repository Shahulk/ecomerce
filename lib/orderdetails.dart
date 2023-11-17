import 'dart:developer';

import 'package:ecomerce/webservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Order Details", style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
          ),
        ),
        body: FutureBuilder(
          future:Webservice().fetchOrderdetails(username.toString()) ,
          builder: (context, snapshot) {
            return

         ListView.builder(
              itemCount: snapshot.data?.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(padding: EdgeInsets.all(10),
                    child: Card(
                        elevation: 0,
                        color: Color.fromARGB(15, 74, 20, 140),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ExpansionTile(
                            trailing: Icon(Icons.arrow_drop_down),
                            textColor: Colors.black,
                            collapsedTextColor: Colors.black,
                            iconColor: Colors.redAccent,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  DateFormat.yMMMEd()
                                      .format(snapshot.data! [index].date),
                                  //  "12-03-2023",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  //order_details.paymentmethod.toString(),
                                    snapshot.data![index].paymentmethod,
                                  //  "Online",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green.shade900,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  //   order_details.totalamount.toString() +
                                  //   "20000"
                                    snapshot.data![index].totalamount.toString()+
                                        " /-",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red.shade900,
                                        fontWeight: FontWeight.w300))

                              ],
                            ),
                            children: [
                              ListView.separated(
                                  itemCount:snapshot.data![index].products.length,
                                 // 2,
                                 //  order_details.products.length,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(top: 25),
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)),
                                      child: SizedBox(
                                        height: 100,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 80,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 9),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    // color: Colors.amber,
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            20)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          Webservice()
                                                              .imageurl +snapshot.data![index].products[index].image
                                                          // order_details
                                                          //     .products[
                                                          // index]
                                                          //     .image
                                                        //  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGUU3VWK2nTbvZRiUCORkJJ80S4JrCoCqoYQ&usqp=CAU",
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  // child: Image.network(product.imagesUrl.first)
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(6.0),
                                                child: Wrap(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(
                                                       // "product name",
                                                        snapshot.data![index].products[index].productname,
                                                        // order_details
                                                        //     .products[index]
                                                        //     .productname,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600,
                                                            color: Colors.grey
                                                                .shade700),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 8,
                                                          right: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(

                                                       snapshot.data![index].products[index].price.toString()  ,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .red
                                                                    .shade900),
                                                          ),
                                                          Text(
                                                           // "2" +
                                                            snapshot.data![index].products[index].quantity.toString()+
                                                                // order_details
                                                                //     .products[
                                                                // index]
                                                                //     .quantity
                                                                //     .toString() +
                                                                " X",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .green
                                                                    .shade900),

                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ])));
              });   },
        ));
  }
}