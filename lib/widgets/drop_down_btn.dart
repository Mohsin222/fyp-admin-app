import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/providers/find_food_provider.dart';
import 'package:provider/provider.dart';

import 'discount_Dialog.dart';


//food details Dropdown
class DropDownBtn extends StatelessWidget {
  final FoodItem foodItem;
  const DropDownBtn({super.key, required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      
                position: PopupMenuPosition.over,
        color: Theme.of(context).cardColor,
          icon: Icon(Icons.menu,color: Colors.white,),
              
          onSelected: (String result) {
            switch (result) {
              case 'filter1':
                print('filter 1 clicked');
                break;
              case 'filter2':
                print('filter 2 clicked');
                break;
              case 'clearFilters':
                print('Clear filters');
                break;
              default:
            }
          },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
  PopupMenuItem<String>(
      
              child: InkWell(
                onTap: (){
               showDialog(context: context, builder: (context){
  return DiscountDialog(foodItem: foodItem,);
});
                },
                child:Text('Add Discount',style: TextStyle(color: Colors.white),) ,
              )
            ),

        

              PopupMenuItem<String>(
      
              child: InkWell
              (
                onTap: ()async{
            var snap =      FirebaseFirestore.instance.collection('foodItems').where('uid',isEqualTo: foodItem.uid.toString())
                  .snapshots();
                  
    await snap.forEach((element) async { 
       List<DocumentSnapshot> documents = element.docs;
      //  for(var document in documents){
await documents[0].reference.delete(

).
then((value) {
  Provider.of<FindFood>(context,listen: false).getListOfFood();
    ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
       content: Text('Item deleted successfully'),
       
     ),
    );
      Navigator.pushReplacementNamed(context, Router1.homeScreen);
    })
    .catchError((err){

     ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
       content: Text('Item not deleted'),
       
     ),
    );
   
    });

      //  }
    });
                },
                child:Text('Delete Product',style: TextStyle(color: Colors.white)) ,
              )
            ),


            //delete product
              PopupMenuItem<String>(
      
              child: InkWell(
                onTap: (){
                  FirebaseFirestore.instance.collection("foodItems")
                 .where("name",isEqualTo: foodItem.name).get().then((querySnapshot ) {

               
                 });

               showDialog(context: context, builder: (context){
  return DiscountDialog(foodItem: foodItem,);
});
                },
                child:Text('Delete Product',style: TextStyle(color: Colors.white),) ,
              )
            ),
            ]
    );
  }
}