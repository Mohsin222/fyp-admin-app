import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/constants/get_seaved_data.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/models/userModel.dart';
import 'package:fyp_app/providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/dialog.dart';


FirebaseFirestore _firestore = FirebaseFirestore.instance;
class AuthProvider with ChangeNotifier{

  
  UserModel? logedUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthProvider(){
   getSavedDetails();

  }

bool loading=false;
Future login({required String email, required String password, required BuildContext context}) async {
try {
  loading=true;
  UserModel? lgUser;
     UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());
                 User? user = userCredential.user;

                 lgUser = UserModel(
        uid: user!.uid,
        email: user.email,
      );
       if (lgUser != null){
    savedUserDetailInLocal(user.uid.toString(),context);
                notifyListeners();

                
       }
} catch (e) {
  log(e.toString()+'Login FUNCTION ERROR');
    loading=false;
    showDialog(context: context, builder: (context){
  
     return Dialog1(twobtn: false,btnText: "ERROR",showStatment: e.toString(),press: ()async{
     });
    });
}
}

//save user details
 savedUserDetailInLocal(String uid, BuildContext context) async {
    var data;
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .where('uid', isEqualTo: uid)
          //.doc('Zv1c2Cbz0lV819FzkYip')
          .limit(1)
          .get()
          .then((value) => data = value.docs[0]);
      logedUser = UserModel(
          email: data['email'],
          fullname: data['fullname'],
          profilepic: data['profilepic'],
          uid: data['uid'],
          phone: data['phone']
          );
       final profileProvider =Provider.of<ProfileProvider>(context,listen: false);
       profileProvider.getuserData(logedUser!);
      notifyListeners();

if(logedUser !=null){
  loading=false;
  Navigator.pushReplacementNamed(context,Router1.homeScreen );
    await savedonLocal();
}
return logedUser;
// return logedUser;
    } catch (e) {
      loading=false;
      logedUser=null;
      notifyListeners();
      log("User detail Fetch Error " + e.toString());
    }
  }

  Future savedonLocal()async{
    try {

          SharedPreferences prefs = await SharedPreferences.getInstance();


String? encodedMap = json.encode(logedUser!.toMap());
print(encodedMap+'AAAAAAAAAAAAAAAAAAAa');


await prefs.setString('data', encodedMap);


} catch (e) {
  log(e.toString()+'Saved Data errrr');
}
  }

       Future<UserModel?> getSavedDetails() async {
    final prefs = await SharedPreferences.getInstance();



   var encodedMap  = prefs.getString("data") ;


  Map<String,dynamic> decodedMap = json.decode(encodedMap.toString());

if(decodedMap.isNotEmpty){
    UserModel a =UserModel.fromMap(decodedMap);
    logedUser=a;
ProfileProvider profileProvider = ProfileProvider();
profileProvider.getuserData(logedUser!);
  
print('${a.email} ++ ${a.fullname}');

  return a;
}


  }

  Future registerUser ({required String email ,required String password,required String phone, required BuildContext context})async{
      //  log('aaaaaaaaaaaaa');
loading=true;
notifyListeners();

         try {
            UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString());

log(userCredential.toString());
                 User? user = userCredential.user;
  // logedUser = UserModel(
  //       uid: user!.uid,
  //     );
                  String? uid = userCredential.user!.uid;
      UserModel newUser = UserModel(
          uid: uid,
          email: email,
          fullname: "User",
          booktable: false,
          phone: phone,
          profilepic:
              "https://images.unsplash.com/photo-1633524588221-ae94a1947870?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fG5vJTIwaW1hZ2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60");

              logedUser=newUser;
  if (logedUser != null) {
   
      
        await _firestore
            .collection('Users')
            .doc(uid)
            .set(newUser.toMap())
            .then((value) {
               Navigator.pushReplacementNamed(context,Router1.homeScreen );
            });
            
savedonLocal();
       loading=false;
        notifyListeners();
        
  }else{
           loading=false;
    logedUser=null;
  }
         } catch (e) {
          loading=false;
           log(e.toString());
             showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: false,btnText: "ERROR",showStatment: e.toString(),press: ()async{
     });
    });

           
         }

return logedUser;
  }



  //logout
   //delete saved Details
  static Future deleteSavedUserData ()async{
       SharedPreferences prefs = await SharedPreferences.getInstance();


try {
  bool data  =await prefs.remove('data') ;
    log(data.toString());


    
    
} catch (e) {
  log(e.toString()+'deleteSavedUserData Log');
}
  }





//update profile
Future changePofileDetails({required String name, required String phone,required BuildContext context})async{
loading=true;
if(file !=null ){
  logedUser!.profilepic= await uploadFile();

   if(name !=''){
    logedUser!.fullname=name;
 
   }
   if(phone !=null){
     logedUser!.phone=phone;
   }
  

 
}
   if(name !=''){
    logedUser!.fullname=name;
 
   }
   if(phone !=null){
     logedUser!.phone=phone;
   }


  // logedUser!.profilepic =url;


FirebaseFirestore.instance

.collection('Users')
.doc(logedUser!.uid)
.update(logedUser!.toMap())
.then((value) async{
// savedUserDetailInLocal(logedUser!.uid.toString(),context);
// getUpgradeLogedUser(logedUser);
file=null;
 savedonLocal();
   notifyListeners();
   loading=false;
   Navigator.pushNamed(context,Router1.homeScreen);





}).catchError((e){

            showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: false,btnText: "ERROR",showStatment: e.toString(),press: ()async{
     });
    });

});



}

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



bookTable(){

  logedUser!.booktable =true;
  notifyListeners();
}

deletebookTable(){

  logedUser!.booktable =false;
  log(logedUser!.booktable.toString());
  notifyListeners();
}

//null logedUser
void nullLogedUser(){
  logedUser =null;
  notifyListeners();
}
}