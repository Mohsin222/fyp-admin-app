import 'dart:convert';

import 'package:fyp_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';

class HelperClass{

  static  Future<UserModel?> getSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



  final  String? encodedMap  = prefs.getString("data") ;


  Map<String,dynamic> decodedMap = json.decode(encodedMap!);

if(decodedMap !=null){
    UserModel a =UserModel.fromMap(decodedMap);
  
print('${a.email} ++ ${a.fullname}');

  return a;
}


  }
}