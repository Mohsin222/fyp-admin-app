
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/backbtn.dart';
import 'package:fyp_app/models/contact_us.dart';

class CustomerQueryPage extends StatelessWidget {
  const CustomerQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        backgroundColor: Theme.of(context).cardColor,

        
      ),
      body: StreamBuilder(
     stream:FirebaseFirestore.instance.collection("ContactsUs")
                
                .where('email',isNotEqualTo:null )
                // .collection('My')
                .snapshots(),
        builder: (BuildContext context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.active){
if(snapshot.hasData){

if(snapshot.data!.docs.length >0){
   QuerySnapshot snp =snapshot.data as QuerySnapshot;

   
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
               ContactUs? contactUs = ContactUs.fromMap(snp.docs[index].data() as Map<String, dynamic>);
            return Container(
              padding: EdgeInsets.all(10),
              height: 200,
              child: Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
           children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    
            Text(contactUs.email.toString(),style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 22,letterSpacing: 0),),
            // IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,))
        ],
      ),
      SizedBox(height: 20,),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          // height: 30,
          child: Flexible(child: Text(contactUs.description.toString(),style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 14,color: Colors.white),)),
        ),
      ),

      Text('22 January 2023',style: TextStyle(color: Colors.white),),
      
           ],
      
                  ),
                ),
              ),
            );
          });

}else{
  return Center(child: Text('No Data',style: Theme.of(context).textTheme.headline3,),);
}

   

}else{
  return Center(child: Text('No Data',style: Theme.of(context).textTheme.headline3,),);
}
          }
         return Center(
          child: CircularProgressIndicator(),
         );
        }
      ),
    );
  }
}