import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/models/dealModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../constants/routes.dart';

class AddDealProvider extends DisposableProvider{


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
     var image = FirebaseStorage.instance.ref('deals').child('/${name}.jpg');
     UploadTask task = image.putFile(file!);
     TaskSnapshot snapshot = await task;
 url = await snapshot.ref.getDownloadURL(); 
print(url);

return url;
   } catch (e) {
     log(e.toString()+'image upload error');
   }


}
String? dealNo='';
String? item1='';
String? item2=''; 
String? item3='';
String? item4='';
String? description;
int? price=0;
String? picture;

//add food item to database
bool loading=false;

Future addItem(BuildContext context)async{
loading=true;
notifyListeners();
    var uuid = Uuid();
    var id =uuid.v1();
var imgData = await uploadFile();
DealModel dealModel =DealModel(
  dealNo: dealNo,
  item1: item1,
  item2: item2,
  item3: item3,
  item4: item4,
  price: price,
  discount: 0,
  picture: url,
  uid: id,
);

String? data;
if(imgData !=null){
 await FirebaseFirestore.instance
          .collection("deals")
          .doc(id)
          .set(dealModel.toMap())
          .then((value) {
            // data=value.toString();

file=null;
item1: '';
  item2: '';
  item3: '';
  item4: '';



loading=false;

 Navigator.popAndPushNamed(context, Router1.homeScreen);
 
notifyListeners();


          })
          .catchError((err){
            
loading=false;
notifyListeners();
    log(err+"ADD ERROR");
          });

          




}
notifyListeners();

log(data.toString()+'bbbbbbbbbb');
return data;
}
  


    @override
  void disposeValues() {

  }
}










abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}