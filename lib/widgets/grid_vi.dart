import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/providers/find_food_provider.dart';

import 'package:provider/provider.dart';





class CustomGrid extends StatelessWidget {
 



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,

        body:  Consumer<FindFood>(
          builder: (context, value, child) {
            return StreamBuilder(
                   stream: FirebaseFirestore.instance.collection("foodItems")
                   .where("popular",isEqualTo: true)
                  //  .where("$popular",isEqualTo: popular != null ? true:val)
                   .where("category",isEqualTo: value.searchcategory)
           
                   .snapshots(),
          builder: (context, snapshot) {
   QuerySnapshot dataSnapshot =snapshot.data as QuerySnapshot;
                   if(snapshot.connectionState == ConnectionState.active){

if(snapshot.hasData){
if(snapshot.data!.docs.length >0){

  
 return Container(
  margin: EdgeInsets.symmetric(horizontal: 5),
  
            color: Colors.white,
             
                child: GridView.custom(
                  
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing:0,
            pattern: [
              WovenGridTile(0.6),
              WovenGridTile(
            6/ 11,
            crossAxisRatio: 1,
            
            alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: snapshot.data!.docs.length,
            (context, index) {
                FoodItem? foodItem = FoodItem.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
              return GestureDetector(
                onTap: ()async{
             
                         final prov = Provider.of<FindFood>(context,listen: false);
                       
           await   prov.findFood(foodItem.uid.toString(),context);







    
  
                   
                       
                },
                child: Container(
                           
                       
        
                // clipBehavior: Clip.antiAlias,
                // // shape: ShapeBorder(),
                // semanticContainer: true,
                // shadowColor: Colors.black,
                // borderOnForeground: false,
                // elevation: 10,
            
                child: Column(
                          children: [
                Expanded(child: value.singlefoodloading ==true?
                Center(child: CircularProgressIndicator(),)
                :Container(
                  clipBehavior: Clip.antiAlias,
                  // width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image(image: NetworkImage(foodItem.picture.toString()),fit: BoxFit.cover,),),),
                
                      
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Text('CHicken Tikka'.toUpperCase(),style: TextStyle(color: Colors.black38),),
                  ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            alignment: Alignment.centerLeft,
                    child: Text('500',style: TextStyle(color: Colors.black),),
                  ),
                          ],
                ),
                          ),
              );
}
          ),
        ));
}else{
  return Center(child: Text('No Data'),);
}
}else{
return Center(child: Text('No Data'),);
}
                   }

                   if(snapshot.connectionState ==ConnectionState.waiting ){
                     return Center(child:CircularProgressIndicator(color: Colors.red,));
                   }
 return Center(child:CircularProgressIndicator(color: Colors.red,));
           
          }
        );
          },
        ),
      );
  }
}