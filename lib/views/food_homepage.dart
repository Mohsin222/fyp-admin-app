import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/providers/profile_provider.dart';
import 'package:fyp_app/views/for_admin/add_food.dart';
import 'package:fyp_app/views/for_admin/admin_home_page.dart';
import 'package:fyp_app/views/home_screen.dart';
import 'package:fyp_app/views/profile_screen.dart';
import 'package:fyp_app/views/tables.dart';
import 'package:fyp_app/widgets/backgroundTask.dart';
import 'package:fyp_app/widgets/drawer.dart';
import 'package:fyp_app/widgets/grid_vi.dart';
import 'package:fyp_app/widgets/prac_timer.dart';
import 'package:provider/provider.dart';

import '../widgets/slideAnimation.dart';

class FoodHomePage extends StatelessWidget {
  const FoodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider= Provider.of<AuthProvider>(context,listen:false);
          final profileProvider= Provider.of<ProfileProvider>(context,listen:false);

    return Scaffold(

      appBar: AppBar(
        // leading: CircleAvatar(backgroundImage: NetworkImage(authProvider.logedUser!.profilepic.toString())),
        backgroundColor: Colors.white,
        // title: Text(authProvider.logedUser!.email.toString(),style: TextStyle(color: Colors.black),),
        actions: [IconButton(onPressed: ()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=>BackgroubdTasks()));
    // final proiv =Provider.of<AuthProvider>(context,listen: false);
    // print(proiv.logedUser!.fullname ??'aaa');
      }, icon: Icon(Icons.add))]),

      drawer: DrawerWidget(),
      body: Container(
         
        child: SingleChildScrollView(
          child: Column(children: [
     
              
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ImageSlideshow(
                isLoop: true,
                  width: double.infinity,
                  indicatorColor: Colors.blue,
                  autoPlayInterval: 0,

           
                      children: [
            Image.network(
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
            Image.network(
              'https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
          ],
              ),
            ),
       
            
            Container(
              // margin: EdgeInsets.all(10),
              child:    Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text('POPULAR FOOD',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    )),
                  ),
                   SingleChildScrollView(
                scrollDirection: Axis.horizontal,

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:10 ),
                  child: Row(
                    children: [
               Container(
                         
margin: EdgeInsets.only(right: 20),
height: MediaQuery.of(context).size.height/3.5,
                  // padding: EdgeInsets.all(20),
               width: MediaQuery.of(context).size.width/1.2,
              //  color: Colors.grey,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
              ),
               
                  child:  Image.network(
              'https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
                  
                  ),
          Container(
        height: MediaQuery.of(context).size.height/3.5,
margin: EdgeInsets.only(right: 20),
                  // padding: EdgeInsets.all(20),
               width: MediaQuery.of(context).size.width/1.2,
              //  color: Colors.grey,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
              ),
               
                  child:  Image.network(
              'https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
                  
                  ),
                       Container(
        height: MediaQuery.of(context).size.height/3.5,
margin: EdgeInsets.only(right: 20),
                  // padding: EdgeInsets.all(20),
               width: MediaQuery.of(context).size.width/1.2,
              //  color: Colors.grey,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
              ),
               
                  child:  Image.network(
              'https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
                  
                  ),
        
                  
   
       
      
              
                    ],
                  ),
                ),
              )
                ],
              )
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height/20,
            // ),
            //categories
               Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text('Categories',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    )),
                  ),
                  Container(
                  
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height,
                    constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.width>600?MediaQuery.of(context).size.height/5:MediaQuery.of(context).size.height/9 ,
                    // minHeight: MediaQuery.of(context).size.height/115
                    ),
                    // width: MediaQuery.of(context).size.width/4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                          // height: MediaQuery.of(context).size.height/16,
                          // width: MediaQuery.of(context).size.width/4,
                        decoration: BoxDecoration(border: Border.all(),

                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red
                        ),
                        child: Text('Cupertino as',style: TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis),),
                      );

                      return button2(text: 'NOHSBSS', press: (){});
                    }),
                  ),
                 Container(
              
              child:       Image.network(
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
              fit: BoxFit.cover,
            ),
            ),
//                 Container(
//               height: MediaQuery.of(context).size.height/2,
//               child:    StreamBuilder(
          
//                 stream: FirebaseFirestore.instance.collection("foodItems")
                
            
       
//                 .snapshots(),
//                 builder: (context, snapshot) {
// QuerySnapshot? dataSnapshot =snapshot.data as QuerySnapshot;
//                    if(snapshot.connectionState == ConnectionState.active){
//  if(snapshot.hasData) {


// //  print(ds['name'].toString());



   
           
                     

//                               return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     padding: EdgeInsets.zero,
//                     itemBuilder: (context,index){
//   FoodItem ?foodItem = FoodItem.fromMap(dataSnapshot.docs[index].data() as Map<String, dynamic>);
//                       // FoodItem foodItem =FoodItem.fromMap(dataSnapshot as Map<String,dynamic>);
                 
//                     return Webtile(foodItem: foodItem,);
//                   });
               
//  }
//                    }
                   
//                  else {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                      return Center(child: CircularProgressIndicator());
//                 }
              
                 
                
//               )
//             ),
              
          ]),
        ),
      ),
    );
  }
}



class Webtile extends StatelessWidget {
final FoodItem? foodItem;
  const Webtile({
    Key? key, required this.foodItem, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/6,
      child: Card(
                    color: Colors.red,
        child: Row(
          children: [
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(10),
                child: Image(image: NetworkImage(foodItem!.picture.toString()),
                fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(foodItem!.name.toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                    ),      
                    
                    ),
                  ),
                  Flexible(child: Text('Kabab paracta is made with chicken and wheatKabab paracta is made with chicken and wheat ',
                     style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400
                                                    ),   
                  )),
       Align(
                    alignment: Alignment.centerRight,
                    child: Text('\$'+foodItem!.price.toString(),
                                                          
                    
                    ),
       )
    
                ],),
              ),
            ),
          ],
        ) ,
      ),
    );
  }
}