

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp_app/components/text_field.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/providers/find_food_provider.dart';
import 'package:fyp_app/views/for_admin/add_deal.dart';
import 'package:fyp_app/views/home_screen.dart';
import 'package:fyp_app/views/tables_details.dart';
import 'package:fyp_app/widgets/bottom_bar.dart';
import 'package:fyp_app/widgets/dialog.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../widgets/drawer.dart';
import '../customer_query_page.dart';

class AdminHomeScreen extends StatelessWidget {

  TextEditingController _textController =TextEditingController();
  @override
  Widget build(BuildContext context) {
   
  adminhomeTile({ required Color color, required VoidCallback press,required String text ,String? img}){
    return  GestureDetector(
      onTap: press,
      child: Container( 
        
        alignment: Alignment.center,
                                        height: MediaQuery.of(context).size.height/2,
                                       //  margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(20),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff38374d),
                               image: DecorationImage(
                                     image: NetworkImage(img ?? ''),fit: BoxFit.fill,
                               )
                             ),
                             child: Text(text,style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),),
                             
                                    ),
    );
  }

    return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      backgroundColor: Color(0xff38374d),
      centerTitle: true,
      title: Text("Admin",style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),),
      actions: [
    IconButton(onPressed: () async {
                        // Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog1(
                                twobtn: true,
                                btnText: 'Logout',
                                showStatment: 'Are you sure',
                                press: () async {
                                  final authprovider =
                                      Provider.of<AuthProvider>(context,
                                          listen: false);
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) async {
                                    await AuthProvider.deleteSavedUserData();
                                    authprovider.nullLogedUser();
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    Navigator.pushNamed(
                                        context, Router1.homeRoute);
                                  }).catchError((e) {});
                                },
                              );
                            });
                      }, icon: Icon(Icons.logout_outlined,color: Colors.white,))
      ],
    ),
      bottomNavigationBar: OldBottomBar(),
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: Color(0xfff262434),
      resizeToAvoidBottomInset: true,
      // navigationBar: buildNavigationBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10),
        child: SafeArea(
          child: CupertinoScrollbar(
            
            child: Column(
       
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            //  Row(
            //   children: [

            
            //        Container(
                    
            //       padding: EdgeInsets.all(10),
            //       child: Text("Admin",style: Theme.of(context).textTheme.headline2,),
                 
            
            
            //     ),
            //   ],
            //  ),
                 Container(
                  height: 200,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height/4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color(0xffFF9A9E),
                    color: Color(0xff38374d)
                  ),
                 
                 child:Column(
                   children: [
                     StreamBuilder(
                      stream:FirebaseFirestore.instance.collection("tablesdataset")
                
                .doc('My')
                // .collection('My')
                .snapshots(),
                     
                       builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
 DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
  return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                     
                     
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text('Total No Tables',
                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                           ),
                            Text('${snp['Length']}',
                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                           ),
                            ],
                           ),
                         ),
                          ],
                         );

                          }
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                                     return Center(child: CircularProgressIndicator(),);
                        
                       }
                     ),


                      StreamBuilder(
                      stream:FirebaseFirestore.instance.collection("Users")
                
            .where('booktable',isEqualTo: true)
          
                // .collection('My')
                .snapshots(),
                     
                       builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
      QuerySnapshot snp =snapshot.data as QuerySnapshot;
  return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text('Total Book Tables',
                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                           ),
                            Text(snp.docs.length.toString(),
                           style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                           ),
                            ],
                           ),
                         ),
                     
                    
                          ],
                         );

                          }
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                                     return Center(child: CircularProgressIndicator(),);
                        
                       }
                     ),
                   ],
                 )
                 ),
                 SizedBox(height: 20,),
          
                   Expanded(
                    flex: 2,
                     child: Container(
                      //  height: MediaQuery.of(context).size.height/2,
                       // color: Colors.pinkAccent,
                     child: GridView.count(
                       mainAxisSpacing: 5,
                       crossAxisSpacing: 5,
                       childAspectRatio: 7/9,
                       shrinkWrap: true,
                       crossAxisCount: 2,
                     children: [
                       adminhomeTile(color: Color(0xff002661).withOpacity(0.9),text: 'Add Food',press: (){
                          Navigator.pushNamed(context,Router1.addFoodItem );
                       },
                       img: 'https://images.unsplash.com/photo-1626074353765-517a681e40be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2hpY2tlbiUyMGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'
                       ),
                                  
                      adminhomeTile(color: Color(0xff5151E5).withOpacity(0.8),text: 'Add Discount',press: (){
                   Navigator.pushNamed(context, Router1.addDiscount);
                      }),
                               
                               adminhomeTile(color: Color(0xffE80505).withOpacity(0.9),text: 'Add Deal',press: (){
                                    Navigator.pushNamed(context,Router1.addDeal);
                               }),
                        adminhomeTile(color: Color(0xffFF9A9E),text: 'View Book Tables',press: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TablesDetailScreen()));
                        }),


                            adminhomeTile(color: Color.fromARGB(255, 0, 211, 11),text: 'Customer Queries',press: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerQueryPage()));
                        }),
                        
                       
                     ],
                     ),
                     
                     ),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //  CupertinoNavigationBar buildNavigationBar(BuildContext context) {
  //   return CupertinoNavigationBar(        
  //       leading: CupertinoButton(
  //         padding: EdgeInsets.all(5),
  //         child: Text('Save', style: TextStyle(color: CupertinoColors.activeBlue)),
  //         onPressed: (){
  //           DrawerWidget();
  //         },
  //       ));
  // }
}