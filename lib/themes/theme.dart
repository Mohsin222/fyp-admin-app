
import 'package:flutter/material.dart';

class StyleTheme{

    static final darkTheme = ThemeData(

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
      ),

      scaffoldBackgroundColor: Color(0xff06091d),
    errorColor: Colors.red,

    primaryColorDark: const Color(0xff282b33),
    primaryColorLight: Color.fromARGB(255, 102, 119, 110),
    cardColor: Color(0xff2a2b34),
    primaryColor: Colors.white,
   
    
    
  
    backgroundColor: Color(0xff06091d),

        textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),

        headline5: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w300
      ),

      
        )

    );



 static final lightTheme = ThemeData(
scaffoldBackgroundColor: Colors.white,

cardColor: const Color(0xffF1F6F7),
 primaryColorDark: Color.fromARGB(255, 7, 11, 15),
    primaryColorLight:  const Color(0xff006bec),
    
    primaryColor: Colors.black,

    textTheme: const TextTheme(
      headline6: TextStyle(
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.w900
      ),

             headline5: TextStyle(
        fontSize: 26,
        color: Colors.black,
        fontWeight: FontWeight.w300
      ),

                   headline2: TextStyle(
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),


      

    ),
    buttonTheme: ButtonThemeData(
      
    )
     );


    
  // static Future<String?> getTheme() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? currentTheme = sharedPreferences.getString("theme");
  //   return currentTheme;
  // }
  
 static   Future<bool> getTheme() async {

//     SharedPreferences prefs = await SharedPreferences.getInstance();
// bool darkThem=false;
// log('YES');
// ThemeProvider themeProvider =ThemeProvider();
//     darkThem = prefs.getBool("theme") ?? false;
//     themeProvider.darkThem=darkThem;
// return darkThem;
return false;
  }


  

}