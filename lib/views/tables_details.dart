import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fyp_app/views/user_detail.dart';

import '../models/userModel.dart';
import '../widgets/bottom_bar.dart';

class TablesDetailScreen extends StatefulWidget {
  const TablesDetailScreen({super.key});

  @override
  State<TablesDetailScreen> createState() => _TablesDetailScreenState();
}

class _TablesDetailScreenState extends State<TablesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
         length: 2,
      child: Scaffold(
            //bottom bar
      bottomNavigationBar: OldBottomBar(),
        appBar: AppBar(
          title: Text('Booked Tables',style: Theme.of(context).textTheme.headline3,),
          centerTitle: true,
          backgroundColor: Theme.of(context).cardColor,
               leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
      bottom:  TabBar(
              tabs: [
               Text('Booked Tables'),
                          Text('Penalty')
                // Tab(icon: Icon(Icons.music_video)),
              
              ],
            ), 
        ),
      body:  TabBarView(
            children: [
             BookedTablesWidget(),
             RemovePaneltyWidget(),
             
            ],
          ), // 
    
    
      ),
    );
  }

    
}


class BookedTablesWidget extends StatefulWidget {
  const BookedTablesWidget({super.key});

  @override
  State<BookedTablesWidget> createState() => _BookedTablesWidgetState();
}

class _BookedTablesWidgetState extends State<BookedTablesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("Users")
                
                .where('booktable',isEqualTo: true)
                // .collection('My')
                .snapshots(), builder: (BuildContext context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.active){
if(snapshot.hasData){
    // DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
    if(snapshot.data!.docs.length >0){
      QuerySnapshot snp =snapshot.data as QuerySnapshot;
    


         return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
        UserModel? userModel = UserModel.fromMap(snp.docs[index].data() as Map<String, dynamic>);
              return Slidable(

                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                                 SlidableAction(
                     backgroundColor:Colors.green,
                     icon: Icons.supervised_user_circle,
                     label: 'User',
                    
                    onPressed: (context){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(userModel: userModel)));
                    }),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                 children: [
                  SlidableAction(
                     backgroundColor:Colors.red,
                     icon: Icons.delete,
                     label: 'Delete',
                    
                    onPressed: (context)=> dismisMethod(userModel.uid.toString())),

                  
                 ],
                ),
                
                
                child: Container(
                 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                    color:  Color.fromARGB(255, 60, 105, 99),),
                
                  margin: EdgeInsets.all(10),
                  child: buildBookedTableUser(userModel)));
            });
    }else{
       return Center(
    child: Text('No Data',style: Theme.of(context).textTheme.headline1,),
  );
    }
}else{
  return Center(
    child: Text('No Data',style: Theme.of(context).textTheme.headline1,),
  );
}
                  }
                  return Center(child: CircularProgressIndicator(),);
                  },
                
       
        ),
      );
      
  }
        void dismisMethod(String uid)async{
await FirebaseFirestore.instance.collection('Users')
.doc(uid)
.update({
"booktable":false
}).then((value) {})
.catchError((e){
  log((e.toString()+ 'delete table error'));
});



        } 

  Widget buildBookedTableUser(UserModel userModel) =>ListTile(
    tileColor: Theme.of(context).cardColor,
    contentPadding: EdgeInsets.all(16),
    title: Text(userModel.fullname.toString(),style: TextStyle(color: Colors.white),),
    subtitle: Text(userModel.email.toString(),style: TextStyle(color: Colors.white)),
    leading: CircleAvatar(
      backgroundColor: Theme.of(context).cardColor,
      radius: 30,
      backgroundImage: NetworkImage(userModel.profilepic.toString()),
    ),
  );
}




//remove panelty widget
class RemovePaneltyWidget extends StatelessWidget {
  const RemovePaneltyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              child: StreamBuilder(
          stream:FirebaseFirestore.instance.collection("Users")
                
                .where('panalty',isEqualTo: true)
                // .collection('My')
                .snapshots(), builder: (BuildContext context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.active){
if(snapshot.hasData){
    // DocumentSnapshot snp =snapshot.data as DocumentSnapshot;
    if(snapshot.data!.docs.length >0){
      QuerySnapshot snp =snapshot.data as QuerySnapshot;
    
print(MediaQuery.of(context).size.width);

         return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
        UserModel? userModel = UserModel.fromMap(snp.docs[index].data() as Map<String, dynamic>);
              return Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width>380?
                180:200
                ,
                decoration: BoxDecoration(color: Colors.white),

                child: Column(
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                       CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userModel.profilepic.toString()),
                   ),
                   SizedBox(
                    width: 10,
                   ),
                 Expanded(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                         Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(userModel.fullname.toString(),style:TextStyle(
                          color: Colors.black,
                          fontSize: 24
                 
                        ),),
                      ),
                         Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(userModel.email.toString(),style:TextStyle(
                          color: Colors.black,
                          fontSize: 20
                 
                        ),),
                      ),
                    ],
                   ),
                 ),
                  ],
                ),
                Spacer(),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
                   Text('Remove Penalty',style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.red,fontSize: 20),),
                   IconButton(onPressed: ()async{

                    await FirebaseFirestore.instance.collection('Users')
.doc(userModel.uid)
.update({
"panalty":false
}).then((value) {})
.catchError((e){
  log((e.toString()+ 'penalty  error'));
});

                   }, icon: Icon(Icons.delete,color: Colors.red,))
        ],
       ),
                  ],
                ),
              );
            });
    }else{
       return Center(
    child: Text('No Data',style: Theme.of(context).textTheme.headline3),
  );
    }
}else{
  return Center(
    child: Text('No Data',style: Theme.of(context).textTheme.headline1,),
  );
}
                  }
                  return Center(child: CircularProgressIndicator(),);
                  },
                
       
        ),
             )
        ;
  }
}