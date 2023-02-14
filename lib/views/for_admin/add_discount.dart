import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/providers/find_food_provider.dart';
import 'package:fyp_app/views/for_admin/admin_home_page.dart';
import 'package:provider/provider.dart';

class AddDiscount extends StatefulWidget {
  const AddDiscount({super.key});

  @override
  State<AddDiscount> createState() => _AddDiscountState();
}

class _AddDiscountState extends State<AddDiscount> {
int alldiscount=0;
int singlediscount=0;
setAllItmeDiscount()async{
 var collection =   FirebaseFirestore.instance.collection('foodItems').where("foodType",isEqualTo: 'meal');

var querySnapshots = await collection.get();
for (var doc in querySnapshots.docs) {
  await doc.reference.update({
    'discount': alldiscount,
  })
  .then((value) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomeScreen()));
  })
  
  .catchError((e){
    log(e.toString() +'discount error');
  });



}
Provider.of<FindFood>(context,listen: false).getListOfFood();
}



//singleItemDisCount


final TextStyle listTextStyle =TextStyle(
      fontSize: 30,
      color: Colors.black,
    );

List listItem=[

               0, 
            10,
            20,
            30,
            40
          
              ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
       leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      //all item discount      

            Container(
              decoration: BoxDecoration(border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
              ),
              child: Column(
                children: [

                  Container(

                    child: Text('All Items Discount',style:Theme.of(context).textTheme.headline2),
                  ),
                  Container(
              decoration: BoxDecoration(border: Border.all()),
              height: 150,
              child: CupertinoPicker(
              children: List.generate(listItem.length, (index) {
                return Text(listItem[index].toString(),style: Theme.of(context).textTheme.headline3,);
              }),
              diameterRatio: 1,
           
                //  offAxisFraction: 0.5,
                    looping: true,
              onSelectedItemChanged: (value){
                 alldiscount=listItem[value];
                 setState(() {
                   
                 });
              },
              itemExtent: 25,
          ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(alldiscount.toString()+'%',style:Theme.of(context).textTheme.headline1),
                ElevatedButton(onPressed: (){
                  setAllItmeDiscount();
                }, 
                         style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xff1fc9b1),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                    ),
                child: Text('Set',style:Theme.of(context).textTheme.headline3)),
            
              ],
            ),
                ],
              ),
            ),

//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
SizedBox(height: 20,),




          ],
        ),
      ),
    );
  }
  
}

