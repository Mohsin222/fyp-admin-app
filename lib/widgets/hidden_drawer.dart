import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/auth/loginmscreen.dart';
import 'package:fyp_app/views/food_homepage.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {

  List<ScreenHiddenDrawer> _pages=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages=[

      
      ScreenHiddenDrawer(
        ItemHiddenMenu(name: "Homepage",
        baseStyle: TextStyle(),
        selectedStyle: TextStyle(),
        colorLineSelected: Colors.deepOrange
        ),
        
      

      FoodHomePage()
      ),

          ScreenHiddenDrawer(
        ItemHiddenMenu(name: "Login Screen",
        baseStyle: TextStyle(),
        selectedStyle: TextStyle()
        ),
        
      

      LoginScreen()
      ),
      
          ScreenHiddenDrawer(
        ItemHiddenMenu(name: "Login Screen",
        baseStyle: TextStyle(),
        selectedStyle: TextStyle()
        ),
        
      

      LoginScreen()
      ),
      
          ScreenHiddenDrawer(
        ItemHiddenMenu(name: "Login Screen",
        baseStyle: TextStyle(),
        selectedStyle: TextStyle()
        ),
        
      

      LoginScreen()
      ),
      
          ScreenHiddenDrawer(
        ItemHiddenMenu(name: "Login Screen",
        baseStyle: TextStyle(),
        selectedStyle: TextStyle()
        ),
        
      

      LoginScreen()
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.deepPurple,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      contentCornerRadius: 100,
    );
  }
}