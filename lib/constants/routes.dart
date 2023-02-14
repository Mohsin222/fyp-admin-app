import 'package:flutter/material.dart';
import 'package:fyp_app/auth/loginmscreen.dart';
import 'package:fyp_app/auth/signup.dart';
import 'package:fyp_app/views/food_homepage.dart';
import 'package:fyp_app/views/for_admin/add_deal.dart';
import 'package:fyp_app/views/for_admin/add_discount.dart';
import 'package:fyp_app/views/for_admin/add_food.dart';
import 'package:fyp_app/views/for_admin/admin_home_page.dart';
import 'package:fyp_app/views/home_screen.dart';
import 'package:fyp_app/views/onboarding_screen.dart';
import 'package:fyp_app/views/profile_screen.dart';
import 'package:fyp_app/views/tables.dart';

class Router1 {
  static const String homeRoute = '/';
  static const String foodHomePageRoute = '/foodHomePage';
  

  static const String profileScreen = '/profileScreen';
    static const String tableScreen = '/tableScreen';
 static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  // admin routes

   static const String addDiscount = '/adminHomePage';
static const String homeScreen = '/AdminHomeScreen';
  static const String addFoodItem = '/addFoodItem';
  static const String addDeal = '/addDeal';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => AdminHomeScreen());
      case foodHomePageRoute:
        return MaterialPageRoute(builder: (_) => const FoodHomePage());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
           case tableScreen:
        return MaterialPageRoute(builder: (_) => TablesScreen());

        case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

         case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      // admin routes
 
      case addFoodItem:
        return MaterialPageRoute(builder: (_) => AddFood());
              case addDeal:
        return MaterialPageRoute(builder: (_) => AddDeal());

        case addDiscount:
        return MaterialPageRoute(builder: (_) => AddDiscount());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
