

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/models/userModel.dart';


import '../constants/routes.dart';
import '../models/dealModel.dart';
import '../views/food_detailsitem_details_screen.dart';

class FindFood extends ChangeNotifier{
  FindFood(){
    getListOfFood();
      getListOfDeals();
  }
List<UserModel> bookedTable=[];
  void getAllbookedTables()async{
CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Users');
   QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
UserModel userModel =UserModel();

    querySnapshot.docs.forEach((element) { 
      bookedTable.add( UserModel.fromMap(element.data() as Map<String,dynamic>));

      });
      print(bookedTable[1].booktable);
      notifyListeners();
 
  }

  String searchcategory='chicken';

  void selectCategory(String value){

searchcategory=value;
notifyListeners();
  }

  List<Icon> categoryIcon =[
    // Icon( Icons.new_releases, ),

Icon( FontAwesomeIcons.bowlFood,size: 35, ),
Icon( FontAwesomeIcons.bowlFood,size: 35, ),
Icon(FontAwesomeIcons.pizzaSlice,size: 35,color: Colors.white,),
Icon( FontAwesomeIcons.burger,size: 35, ),
Icon( FontAwesomeIcons.coffee,size: 35, ),
Icon(FontAwesomeIcons.plateWheat,size: 35,),
Icon(Icons.food_bank,size: 35,),

  ];
  // List categorytext = ["pizza","burger","Drink","Lunch","Beackfast"];

    List categorytext =[
    "chicken",
    "beef",
    "pizza",
    "burger",
    "drink",
    "chapati",
    "paratha",

  ];
      var foodImages =[
    // "https://images.unsplash.com/photo-1626074353765-517a681e40be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2hpY2tlbiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1534939561126-855b8675edd7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmVlZiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1571066811602-716837d681de?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1571091655789-405eb7a3a3a8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJ1cmdlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1576092768241-dec231879fc3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHRlYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1600935926387-12d9b03066f0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cm90aXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    // "https://images.unsplash.com/photo-1668357530437-72a12c660f94?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFyYXRoYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "assets/category_img/chicken.jpg",
    "assets/category_img/beef.jpg",
    "assets/category_img/pizza.jpg",
    "assets/category_img/burger.jpg",
   "assets/category_img/drink.jpg",
    "assets/category_img/roti.jpg",
    "assets/category_img/paratha.jpg",
  ];


FoodItem foodItem =FoodItem(available: false, description: '', name: '', price: 0, uid: '',popular: false,foodType: '',category: '');
  bool singlefoodloading =false;
  FoodItem? singleFoodItem;
 Future  findFood(String uid,BuildContext context)async{
try {
  singlefoodloading =true;
  singleFoodItem=null;

     FirebaseFirestore.instance.collection('foodItems')
    .where("uid",isEqualTo: uid)
    
    .snapshots()
    .listen((value) {
      print(value.docs[0]['price'].toString());
//  DocumentSnapshot querySnapshot = value.docs as DocumentSnapshot;


  List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =value.docs ;
 singleFoodItem =FoodItem.fromMap(querySnapshot[0].data());
   singlefoodloading =false;

     Navigator.push(context, MaterialPageRoute(builder: (context)=>FoodItemDetailScreen(foodItem: singleFoodItem!)));
 
//  singleFoodItem=null;
 notifyListeners();



    
    });

} catch (e) {
  log(e.toString());
}
  // return singleFoodItem!;
  }
List<FoodItem> allFood =[];


//chanr single food after moving to details screen
void chnageSingleFoodToNew(FoodItem foodItem){
  singleFoodItem =foodItem;
  // singlefoodloading=false;
  notifyListeners();
}
  
  
  //get list of all foods
  getListOfFood()async{
  
allFood.clear();
    final docRef = FirebaseFirestore.instance.collection("foodItems");
docRef.snapshots().listen(
      (event) {
        //  print("current data: ${event.docs}");
       List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =event.docs ;



try {
    querySnapshot.forEach((element) { 
      allFood.add( FoodItem.fromMap(element.data()));
      //  print(element.data()[1].toString() +'111');
      // print(element['price']);
   
      });
      notifyListeners();
   
    

} catch (e) {
  log(e.toString()+'aaaaaaaaaaaaaaaaa');
}


  
   

  
      
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

String searchQuery="pizza";
updateSearchQuery(String val){
  searchQuery=val;
  notifyListeners();
}
  //serach food in food list
 List<FoodItem> getFilteredData(){
 
  return allFood.where((element) =>
  
  element.category!.contains(searchQuery)
   ).toList();
  

 }






 //add singelDiscount
 List<String> discount=[
"0","10","20","30","40"
];
void updateInitialDiscountValue(String value){
  initialvalue=value;
  notifyListeners();
}
String initialvalue ="0";
   addDisCount({required String uid,required BuildContext context})async{

  var snap =  FirebaseFirestore.instance.collection('foodItems')
    .where('uid',isEqualTo: uid)
    .snapshots();

    await snap.forEach((element) async { 
       List<DocumentSnapshot> documents = element.docs;
      //  for(var document in documents){
await documents[0].reference.update({
  "discount":int.parse(initialvalue),
}).
then((value) {
   getListOfFood();
      Navigator.pushNamed(context, Router1.homeScreen);
    })
    .catchError((err){

      log(err.toString() + 'discount error');
    });

      //  }
    });

   }






   //deals
 List<DealModel> allDeals =[];
   getListOfDeals()async{
    allDeals.clear();
      final docRef = FirebaseFirestore.instance.collection("deals");
docRef.snapshots().listen(
      (event) {
        //  print("current data: ${event.docs}");
       List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot =event.docs ;



try {
    querySnapshot.forEach((element) { 
      allDeals.add( DealModel.fromMap(element.data()));
      //  print(element.data()[1].toString() +'111');
      // print(element['price']);
   
      });
      notifyListeners();
      // print(allFood);

} catch (e) {
  log(e.toString()+'aaaaaaaaaaaaaaaaa');
}


  
   

  
      
      },
      onError: (error) => print("Listen failed: $error"),
    );


   }


}