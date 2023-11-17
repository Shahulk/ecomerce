

import 'dart:developer';

import 'package:ecomerce/Detailspage.dart';
import 'package:ecomerce/viewcategoryproduct.dart';
import 'package:ecomerce/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _AppbarState();
}

class _AppbarState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: Text(
          "S H O P   W A V E",
          style: TextStyle(fontSize: 30),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Category",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              child: FutureBuilder(
                future: Webservice().fetchCategory(),
                builder: (context,snapshot) {
                  if(
                  snapshot.hasData
                  ){
                  return ListView.builder(

                      scrollDirection: Axis.horizontal,
                      itemCount:snapshot.data!.length ,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Viewcategoryproducts(id: snapshot.data![index].id,catname:snapshot.data![index].category ,);
                              },));
                            },
                            child: Container(
                              height: 80,
                              width: 200,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              child: Center(
                                child: Text(
                                snapshot.data![index].category,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white)
                                ),
                              ),
                            ),
                          ),
                        );
                      });}else{
                    return Center(
                      child: CircularProgressIndicator(

                      ),
                    );
                  }
                }
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Offer Products %",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child:
                Container(
                  child:
                  FutureBuilder(
                    future: Webservice().fetchProducts(),
                    builder: (context,snapshot) {
                      if(snapshot.hasData){

                      return StaggeredGridView.countBuilder(
                        physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,

                          crossAxisCount: 2, itemBuilder: (context,index){
                          return InkWell(
                            onTap: ()
                          {
                            log("cart");
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Detailspage(id: snapshot.data![index].id, image:Webservice().imageurl+snapshot.data![index].image ,
                              price:snapshot.data![index].price.toDouble(), name: snapshot.data![index].productname, description: snapshot.data![index].description);
                        },));


                          },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: 100,maxHeight: 250
                                          ),
child: Image.network(Webservice().imageurl+snapshot.data![index].image,
  // "https://4.imimg.com/data4/WN/WW/MY-26510561/rado-jubile-centrix-rose-gold-watch-for-men.jpg"
  fit: BoxFit.fill,),
                                        ),
                                      ),
                                      Text(snapshot.data![index].productname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                      Text("Rs . "+snapshot.data![index].price.toString(),style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                      },

                          staggeredTileBuilder: (context) =>
                          const StaggeredTile.fit(1));}
                      else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
