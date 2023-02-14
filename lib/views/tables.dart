import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/services/background_services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tables')),

      body: Consumer<AuthProvider>(

        builder: (context, value,child) {
          return Column(
            children: [
              InkWell(
                onTap: (){
                  value.bookTable();
      FirebaseFirestore.instance.collection('Users').doc(value.logedUser!.uid).update(
        value.logedUser!.toMap()
      ).then((value) {
          Workmanager()
                        .registerOneOffTask(simpleTaskKey, simpleTaskKey,
                            inputData: <String, dynamic>{
                              'int': "MOHSIN IRFAAN",
                              'bool': true,
                              'double': 1.0,
                              'string': 'string',
                              'array': [1, 2, 3],
                           
                            },
                            initialDelay: Duration(minutes: 1));
      }).catchError((e){
    log(e.toString());
      });
      
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text('BOOK Table'),
                ),
              ),
      
                 Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                
                alignment: Alignment.center,
                // padding: EdgeInsets.all(20),
                child: ListTile(tileColor: Colors.grey,title:Text( 'Your Table'),
                subtitle: value.logedUser!.booktable == true ? 
                Text('1')
                :Text('0'),
                contentPadding: EdgeInsets.all(10),
                trailing: Icon(Icons.delete),
                ),
              ),
      Container(
       child: Text( 'Available Tables',style: Theme.of(context).textTheme.headline2,),
      ),
      
              Expanded(
                child: StreamBuilder(stream:  FirebaseFirestore.instance.collection("tablesdataset")
                
                .doc('My')
                // .collection('My')
                .snapshots(),
                
                builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active){
              
                 if(snapshot.hasData){
                 DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
                  // QuerySnapshot? dataSnapshot =snp as QuerySnapshot;
                
                  return GridView.builder(
                    // itemCount: snp['Length'],
              
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                   maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20
                
              ),
                    itemCount: snapshot.data!.data()!.length,
                    itemBuilder: (context,index){
                    // return Container(
                 
                    //   child: Icon(Icons.table_bar,
                    // color: Colors.grey,
                    // size: 100,),);
              
                    return   Container(
                          height: MediaQuery.of(context).size.height/2,
                                    margin: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                                      
                                        
                                         
                              child: Lottie.asset(
                                    'assets/animations/table.json',fit: BoxFit.cover),
                            ),
                          ),
                          Container(child: Text('4 chairs',style: TextStyle(color: Colors.black,fontSize: 22),),)
                        ],
                      ),
                    );
                  }, );
                  
                 }
              }
                   else{
                                   return Center(child: CircularProgressIndicator());
                          }
                                     return Center(child: Text('NO DATA'));
                }
                ),
                   ),
              ),
            ],
          );
        }
      ) );
  }
}