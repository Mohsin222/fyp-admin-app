import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/routes.dart';
import '../models/userModel.dart';
import '../widgets/dialog.dart';

class ProfileProvider extends ChangeNotifier{

UserModel logedUser=UserModel();
getuserData(UserModel userModel){
  logedUser = userModel;
  notifyListeners();
}
Future changePofileDetails({required String name, required String phone,required BuildContext context})async{

if(file !=null ){
   await uploadFile().then((value) {
 logedUser.profilepic=url;
   }
   );

 
}
final authProvider =Provider.of<AuthProvider>(context,listen:false);
authProvider.logedUser=logedUser;
  logedUser.fullname=name;
  logedUser.phone=phone;
  // logedUser!.profilepic =url;


FirebaseFirestore.instance

.collection('Users')
.doc(authProvider.logedUser!.uid)
.update(logedUser.toMap())
.then((value) async{
// savedUserDetailInLocal(logedUser!.uid.toString(),context);
// getUpgradeLogedUser(logedUser);
 logedUser =await savedonLocal();
   Navigator.pushNamed(context,Router1.foodHomePageRoute);
  notifyListeners();




}).catchError((e){

            showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: false,btnText: "ERROR",showStatment: e.toString(),press: ()async{
     });
    });

});



}
//after update profile save new data in local storage
  Future savedonLocal()async{
    try {

          SharedPreferences prefs = await SharedPreferences.getInstance();


String? encodedMap = json.encode(logedUser.toMap());
print(encodedMap+'AAAAAAAAAAAAAAAAAAAa');


await prefs.setString('data', encodedMap);


} catch (e) {
  log(e.toString()+'Saved Data errrr');
}
  }


 getprofileDatafromSavedDetails(UserModel? userModel)async{

logedUser= userModel!;
notifyListeners();
  log(logedUser.profilepic.toString());

}

  // @override
  // void disposeValues() {
  //   // TODO: implement disposeValues
  //   // logedUser=null;
  // }

//file picker
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
//xxxxx file picker end xxxxxxxxxx
  String url='';
Future uploadFile()async{
   try {
     String name = DateTime.now().microsecondsSinceEpoch.toString();
     var image = FirebaseStorage.instance.ref('Users').child('/${name}.jpg');
     UploadTask task = image.putFile(file!);
     TaskSnapshot snapshot = await task;
 url = await snapshot.ref.getDownloadURL(); 
print(url);

return url;
   } catch (e) {
     log(e.toString()+'image upload error');
   }

}


}


