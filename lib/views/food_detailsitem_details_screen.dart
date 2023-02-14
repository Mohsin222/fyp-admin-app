import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_app/constants/routes.dart';

import 'package:provider/provider.dart';


import '../models/food_item.dart';
import '../providers/find_food_provider.dart';
import '../widgets/discount_Dialog.dart';
import '../widgets/drop_down_btn.dart';

class FoodItemDetailScreen extends StatelessWidget {
final   FoodItem foodItem;
   FoodItemDetailScreen({super.key, required this.foodItem});


   
List<String> cityList = [
    'Ajman',
    'Al Ain',
    'Dubai',
    'Fujairah',
    'Ras Al Khaimah',
    'Sharjah',
    'Umm Al Quwain'
  ];




  @override
  Widget build(BuildContext context) {
    
    return
   Scaffold(
// floatingActionButton: FloatingActionButton(onPressed: (){
// // Provider.of<FindFood>(context,listen: false).addDisCount(uid: foodItem.uid.toString(), context: context);

// showDialog(context: context, builder: (context){
//   return DiscountDialog(foodItem: foodItem,);
// });

// },child: Icon(Icons.discount),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title:  Text(foodItem.name.toString(),style: Theme.of(context).textTheme.headline2,),
          centerTitle: true,
               leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          actions: [
           DropDownBtn(foodItem: foodItem,),
           

            
          ],
        ),
        body: Consumer<FindFood>(
       
          builder: ((context, value, child) 
            
          {
            return Banner(
                message: foodItem.discount! > 0?"${foodItem.discount}% off !!":'',
                             location: BannerLocation.topStart,
              child: Container(
            
                
              decoration: BoxDecoration(
                 
                image: DecorationImage(image: NetworkImage(foodItem.picture.toString()),fit: BoxFit.fill,opacity: 0.8)
              ),
                child: Stack(
                alignment: AlignmentDirectional.topStart,
                textDirection: TextDirection.ltr,
                fit: StackFit.loose,
                
                children: [
                  // SizedBox(height: 50,),
              
                      
                    
                     
                //  Positioned(
               
                //     top: 0,
                //     left: 0,
                //     right: 0,
                    
                //   //   child: Container(
               
                //   //     height: MediaQuery.of(context).size.height/1.8,
                //   //     decoration: BoxDecoration(
                //   //       image: DecorationImage(image: NetworkImage(foodItem.picture ?? 'https://images.unsplash.com/photo-1598217005661-13b6307fe2c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fGZha2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),fit: BoxFit.fill),
                //   //  color: Color.fromARGB(255, 25, 25, 26),
                    
                //   //     ),
                      
                     
                //   //   ),
                //   child: Container(),
                //   // child: CircleAvatar(
                //   //   radius: 100,
                //   //   backgroundImage: NetworkImage(foodItem.picture ?? 'https://images.unsplash.com/photo-1598217005661-13b6307fe2c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fGZha2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                //   // ),
                //   ),
                  Positioned(
                    
                    bottom: 0,
                    left: 0,
                    right: 0,
                    
                
                    child: Container(
                      padding: EdgeInsets.all(20),
               
                      height: MediaQuery.of(context).size.height/2,
                      decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
               topRight: Radius.circular(40.0),
                    // bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                    // bottomLeft: Radius.circular(40.0)
                    ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
            Expanded(child: Text(foodItem.name.toString(),style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
            Expanded(child: Row(
              children: [
                     
                  Text(foodItem.name.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  SizedBox(width: MediaQuery.of(context).size.width/10,),
                  Icon(foodItem.foodType=='meal'?Icons.food_bank:Icons.coffee),
                  Text(foodItem.foodType.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            
              ],
            )),
            Expanded(
            flex: 2,  
              child:
             
             Text(foodItem.description.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w300))),
            //Size1
             foodItem.discount! <= 0?
             Expanded(child: Row(
             
              children: [
                Text(foodItem.size1.toString()+":",style: Theme.of(context).textTheme.headline3,),
                SizedBox(
                  width: 10,
                ),
                    Text("${foodItem.price!}",style: Theme.of(context).textTheme.headline3,),
              ],
            ))
            :Expanded(child: Row(
             
              children: [
                Text(foodItem.size1.toString()+":",style: Theme.of(context).textTheme.headline3,),
                SizedBox(
                  width: 10,
                ),
                    Text("${foodItem.price!}",style: Theme.of(context).textTheme.headline3!.copyWith(
            decoration: TextDecoration.lineThrough
            
                    ),),
            
                      SizedBox(
                  width: 10,
                ),
                 
            
                       Text("${(foodItem.price!) - ((foodItem.price!.toInt())* 10/100)}",style: Theme.of(context).textTheme.headline3!.copyWith(
            
            
                    ),),
              ],
            )),
            
            
            //Size2
            
            foodItem.discount! <= 0?
            Expanded(child: Row(
             
              children: [
                Text(foodItem.size2.toString()+":",style: Theme.of(context).textTheme.headline3,),
                SizedBox(
                  width: 10,
                ),
                    Text("${foodItem.price!.toInt() *2}",style: Theme.of(context).textTheme.headline3,),
              ],
            ))
            :Expanded(child: Row(
             
              children: [
                Text(foodItem.size2.toString()+":",style: Theme.of(context).textTheme.headline3,),
                SizedBox(
                  width: 10,
                ),
                    Text("${foodItem.price!.toInt() *2}",style: Theme.of(context).textTheme.headline3!.copyWith(
            decoration: TextDecoration.lineThrough
            
                    ),),
            
                      SizedBox(
                  width: 10,
                ),
                 
            
                       Text("${(foodItem.price!*2) - ((foodItem.price!.toInt() *2)* 10/100)}",style: Theme.of(context).textTheme.headline3!.copyWith(
            
            
                    ),),
              ],
            )),
            
            
                        ],
                      )
                      
                     
                    ),
                  ),
                 Positioned(
                            left: 0,
                 top: 120,
                        
                    right: 0,
                   child: CircleAvatar(
                      radius: 100,
                      
                      backgroundImage: NetworkImage(foodItem.picture ?? 'https://images.unsplash.com/photo-1598217005661-13b6307fe2c2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fGZha2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'),
                      
                    ),
                 ),
                ],
              )),
            );
          }
        )
      ),
    );
  }
}