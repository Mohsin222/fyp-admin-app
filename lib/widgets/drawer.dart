import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/views/onboarding_screen.dart';
import 'package:fyp_app/views/viewallfood.dart';

import 'package:fyp_app/widgets/dialog.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      // margin: EdgeInsets.symmetric(vertical: 39),
      child: Drawer(
        
        
        shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
        // backgroundColor: Colors.green[500],

        child: ListView(
          

            padding: EdgeInsets.zero,
            children: [
               Consumer<AuthProvider>(
                builder:((context, value, child) {
                  return UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    value.logedUser!.profilepic?? 'https://images.unsplash.com/photo-1671212041192-443a5a171150?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5MHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
              ),
              accountEmail: Text(value.logedUser!.email.toString()),
              accountName: Text(
                value.logedUser!.fullname.toString(),
                style: TextStyle(fontSize: 24.0),
              ),
              decoration: BoxDecoration(
                color: Colors.black87,
              ),
            );
                }) ),
           Container(
            padding: EdgeInsets.all(24),
             child: Wrap(
              spacing: 19,
              // runSpacing: 16,
              children: [
                 ListTile(
                  onTap: (){
                      Navigator.pushNamed(context, Router1.tableScreen);
                  },
                leading:  Icon(Icons.table_bar),
                title:  Text(
                  'Tables',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
  drawerTile(icon: Icons.home,press: (){

  }, title: 'Profile'),
  drawerTile(icon: Icons.menu,press: (){}, title: 'Profile'),
              drawerTile(icon: Icons.person,press: (){}, title: 'aaaa'),
              Divider(),
                       drawerTile(icon: Icons.logout,press: ()async{
     Navigator.pop(context);    
  showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: true,btnText: 'Logout',showStatment: 'Are you sure',press: ()async{
                  
final  authprovider =Provider.of<AuthProvider>(context,listen: false);
                await      FirebaseAuth.instance.signOut().then((value)async {
await AuthProvider.deleteSavedUserData();
 authprovider.nullLogedUser();
         Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context,Router1.homeRoute );
                    }).catchError((e){

                    });


     },);
    });

   
            //  authprovider.nullLogedUser();
                  // User? currentUser = FirebaseAuth.instance.currentUser;
              

                  //   await     AuthProvider.deleteSavedUserData();
            //       if(currentUser ==null){
  
            //     Navigator.popUntil(context, (route) => route.isFirst);
            // await    Navigator.pushNamed(context,Router1.homeRoute );
            //       }
                

            //  Timer(Duration(seconds: 3),()async{
        
            //  });


                       }, title: 'Logout'),
                                drawerTile(icon: Icons.logout,press: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return OnBoardingScreen();
                                  }));
                                }, title: 'prijfa'),
              ],
             ),
           ),
            ],
        ),
      ),
    );
  }


  drawerTile({required VoidCallback press,required String title, required IconData icon}){
    return   ListTile(
      
              leading:  Icon(icon),
              title:  Text(
                title,
                style: TextStyle(fontSize: 24.0),
              ),
              onTap: press,
            );
  }
}


