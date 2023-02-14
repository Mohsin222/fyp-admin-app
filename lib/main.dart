import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/auth/loginmscreen.dart';
import 'package:fyp_app/auth/signup.dart';
import 'package:fyp_app/constants/get_seaved_data.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/models/userModel.dart';
import 'package:fyp_app/providers/add_dealprovider.dart';
import 'package:fyp_app/providers/add_food_provider.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/providers/find_food_provider.dart';
import 'package:fyp_app/providers/profile_provider.dart';
import 'package:fyp_app/services/background_services.dart';
import 'package:fyp_app/views/food_homepage.dart';
import 'package:fyp_app/views/for_admin/add_deal.dart';
import 'package:fyp_app/views/tables.dart';
import 'package:fyp_app/widgets/backgroundTask.dart';
import 'package:fyp_app/widgets/hidden_drawer.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

void main() async{
  
  await   WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
    await Firebase.initializeApp();

     User? currentUser = FirebaseAuth.instance.currentUser;
       if(currentUser != null) {
        // UserModel? thisUserModel = await HelperClass.getSavedData();
        AuthProvider authProvider =AuthProvider();
//  UserModel? thisUserModel =
  await authProvider.getSavedDetails();
// runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) =>  MyApp1(userModel: thisUserModel!,), // Wrap your app
//   ),
//   );
// runApp(MyApp1(userModel: thisUserModel!));
  runApp(
          MyApp(currentUser:currentUser));
       }else{
        runApp(
           MyApp(currentUser:null));
       }
  
}




class MyApp extends StatelessWidget {
  final User? currentUser;

  const MyApp({super.key, required this.currentUser, });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => AddFoodProvider()),
          ChangeNotifierProvider(create: (_) => FindFood()),
                 ChangeNotifierProvider(create: (_) => ProfileProvider()),
                 ChangeNotifierProvider(create: (_) => AddDealProvider()),
                 
    ],
    child:  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
appBarTheme: AppBarTheme(color: Color(0xffFF9A9E),),
         primarySwatch: Colors.blue,
        useMaterial3: true,
        // scaffoldBackgroundColor: Color(0xffecedf4),
        scaffoldBackgroundColor: Color(0xfff262434),
        cardColor:Color(0xff38374d) ,

      textTheme: TextTheme(

             headline1: TextStyle(
                        color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Sevillana',
                              letterSpacing: 2
                            ),
          headline2: TextStyle(
                        color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Sevillana',
                              letterSpacing: 2
                            ),

                            headline3:  TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
        )
      ),
      // home: FoodHomePage(),
      initialRoute:  currentUser==null ?Router1.homeRoute:Router1.homeScreen,
  onGenerateRoute: Router1.generateRoute,
    ),
    );
  }
}



