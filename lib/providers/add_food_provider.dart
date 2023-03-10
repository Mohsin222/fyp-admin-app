import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/widgets/dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddFoodProvider extends DisposableProvider{

var foodtype=[
  "meal",
  "drink"
];
  var foodItems =[
    "chicken",
    "beef",
    "pizza",
    "burger",
    "drink",
    "chapati",
    "paratha",

  ];

var  fooditemValue='chicken';
var foodtp='meal';

pickfoodType(String value){
foodtp=value;
notifyListeners();
}

pickCategory(String value){
fooditemValue=value;
notifyListeners();
}

 File? file ;
pickImage()async{
  try {
      final ImagePicker _picker = ImagePicker();
XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);



  if(pickedFile !=null){
       file= File(pickedFile.path) ;
       notifyListeners();
  }else{
    log('Pick File');
  }


  } catch (e) {
    print(e.toString());
  }
}
  String url='';
Future uploadFile()async{
   try {
     String name = DateTime.now().microsecondsSinceEpoch.toString();
     var image = FirebaseStorage.instance.ref('foodItems').child('/${name}.jpg');
     UploadTask task = image.putFile(file!);
     TaskSnapshot snapshot = await task;
 url = await snapshot.ref.getDownloadURL(); 
print(url);

return url;
   } catch (e) {
     log(e.toString()+'image upload error');
   }

}
  
String? name='';
String? description='';
double? price=0; 
String? size1='';
String? size2='';
//add food item to database
bool loading=false;
Future addItem(BuildContext context)async{
loading=true;
notifyListeners();
    var uuid = Uuid();
    var id =uuid.v1();
var imgData = await uploadFile();
  FoodItem foodItem =FoodItem(
    name: name,
    price:price,
    description: description,
    picture: imgData,
available: true,
uid: id,
category: fooditemValue,
foodType: foodtp,
popular: true,
discount: 0,
size1: size1,
size2: size2,
 
  );

// dynamic data='';
if(imgData !=null){
 await FirebaseFirestore.instance
          .collection("foodItems")
          .doc(id)
          .set(foodItem.toMap())
          .then((value) {
            // data=value;
name='';
description='';
price=0;
file=null;


loading=false;
       Navigator.popAndPushNamed(context, Router1.homeScreen);
notifyListeners();


          })
          .catchError((err){
            
loading=false;
              showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: false,btnText: "Back",showStatment: err,press: ()async{
     });
    });
notifyListeners();

    log(err+"ADD ERROR");
          });

          




}
notifyListeners();

// log(data.toString()+'bbbbbbbbbb');
// return data;
}







  @override
  void disposeValues() {
    file = null;
    name=null;
    price=null;
    description=null;
 
  }

}


abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}