


import 'dart:developer';

import 'package:ecomerce/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Viewcategoryproducts extends StatefulWidget {
 int? id ;
 String ? catname;
 Viewcategoryproducts({required this.id,required this.catname});

  @override
  State<Viewcategoryproducts> createState() => _ViewcategoryproductsState();
}

class _ViewcategoryproductsState extends State<Viewcategoryproducts> {
  @override
  Widget build(BuildContext context) {
    log("id = "+widget.id.toString());
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Text(widget.catname.toString()),
      ),
      body: FutureBuilder(
        future: Webservice().fetchCategoryproducts(widget.id!),
        builder: (context,snapshot) {
          if(
          snapshot.hasData
          ){
          return StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,

              crossAxisCount: 2, itemBuilder: (context,index){
            return InkWell(
              onTap: ()
              {


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
              const StaggeredTile.fit(1));
        }else{
return Center(
  child: CircularProgressIndicator(),
);
          }}
      ),
    );
  }
}
