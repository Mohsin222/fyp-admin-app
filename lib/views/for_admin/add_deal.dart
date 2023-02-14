import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/providers/add_dealprovider.dart';
import 'package:fyp_app/widgets/dialog.dart';
import 'package:provider/provider.dart';

import '../../components/text_field.dart';
import '../../providers/add_food_provider.dart';

class AddDeal extends StatelessWidget {

GlobalKey<FormState> _addFoodKey = GlobalKey<FormState>();

     TextEditingController dealNoController =TextEditingController();
     TextEditingController priceController =TextEditingController();
        TextEditingController item1Controller =TextEditingController();

              TextEditingController item2Controller =TextEditingController();
                    TextEditingController item3Controller =TextEditingController();
                           TextEditingController item4Controller =TextEditingController();
                    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
   automaticallyImplyLeading: false,
          title: Text('Add Deal',style: TextStyle(color: Colors.white),),backgroundColor: Theme.of(context).cardColor,),
body: Container(child: Form(
       key: _addFoodKey,
       child: Consumer<AddDealProvider>(
             builder:(context,foodProvider,child){
              return Container(
                   margin: EdgeInsets.symmetric(horizontal: 10),
                   child: SingleChildScrollView(
                    child: Stack(
                        children: [
                          Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                                   SizedBox(
              height: MediaQuery.of(context).size.height/20,
             
            ),
            //image Container
                            InkWell(
                              onTap: (){
                               foodProvider.pickImage();
                              },
                              child: DottedBorder(
                                //  dashPattern: [6, 3, 2, 3],
                                borderType: BorderType.RRect,
                                color: Colors.white,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/5,
                                  margin: EdgeInsets.all(10),
                                  // color: Colors.red,
                    
                                  child: foodProvider.file !=null?
                                Image.file(foodProvider.file!,fit: BoxFit.cover,):
                                 Icon(Icons.image_outlined,size: 60,color: Colors.white,)
                                  
                                ),
                              ),
                            ),
                                 
      //name field              
                                   textfield(value: "Enter Deal No",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter food name';
                                  }else{
                                        foodProvider.dealNo=val;
                                  }
                             
                                   }
                                   
                                   ),
                                          textfield(value: "Enter Price",
                                  
                                                 keyboardType: TextInputType.number,
                                          press: (value) {
                                    
                                        if (value!.isEmpty) {
                                    return 'Please enter price ';
                                  }
                                  else{
                                        foodProvider.price=int.parse(value);
                                  }
                                   }),
                                  //  Size 1
                                   textfield(value: "Enter Item1",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Item1 name';
                                  }else{
                                        foodProvider.item1=val;
                                  }
                             
                                   }
                                   
                                   ),
                                       //  item 2
                                   textfield(value: "Enter Item2",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Item2 name';
                                  }else{
                                        foodProvider.item2=val;
                                  }
                             
                                   }
                                   
                                   ),
    //  item3
                                   textfield(value: "Enter Item3",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Item3 name';
                                  }else{
                                        foodProvider.item3=val;
                                  }
                             
                                   }
                                   
                                   ),
                                       //  item4
                                   textfield(value: "Enter Item4",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Item1 name';
                                  }else{
                                        foodProvider.item4=val;
                                  }
                             
                                   }
                                   
                                   ),
                              
 

    

 
   
             SizedBox(
              height: MediaQuery.of(context).size.height/20,
          
            ),
                                   //description
                                        Container(
                                          height: MediaQuery.of(context).size.height/8,
                                          decoration: BoxDecoration(border: Border.all()),
                                 
                                          child: TextFormField(
                                            keyboardType: TextInputType.multiline,
                                        
                                          // minLines: null,
                                          maxLines: 10,
                                            decoration:textFieldDecoration.copyWith(
                                                        hintText: 'Enter Description',
                                                     hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                             
                                                              focusedBorder:OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
          color:Colors.white,
          width: 3,
        )
    ),
                    enabledBorder:const OutlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
                                   
                                                      ) ,                     
                                                      validator: (value) {
                                    
                                        if (value!.isEmpty) {
                                    return 'Please enter description';
                                  }
                            else{
                                        foodProvider.description=value;
                                  }
                                   }
                                          ),
                                        ),
                              SizedBox(
              height: MediaQuery.of(context).size.height/20,
          
            ),
                              

                               Container(
                                width: MediaQuery.of(context).size.width/2,
                                 child: button2(text: 'Add', press: ()async{
                                    if (_addFoodKey.currentState!.validate()) {
                                  debugPrint('valid');
                  
                          if(foodProvider.file !=null){
                             var data=     await   foodProvider.addItem();
                           if(data !=null){
                            // ignore: use_build_context_synchronously
                            Navigator.popAndPushNamed(context, Router1.homeScreen);
                          }
                           }else{
                    showDialog(context: context, builder: (context){
    
     return Dialog1(twobtn: false,btnText: "Back",showStatment: 'Pick Image',press: ()async{
     });
    });
                            log('PICK IMAGE');
                           }
                           
                                        
                              }
                                 }),
                               )

                
                          ],
                                  ),

                                  foodProvider.loading == true?
                                  const Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(child: CircularProgressIndicator()),)
                                  
                                  :const SizedBox()
                        ],
                      ),
                   ),

              );
             }
       ),
       
)),

    );
  }



  textfield({required String value,required String? press(value),required TextInputType keyboardType}){
  return TextFormField(
    keyboardType: keyboardType,
            
                    decoration: addfoodItem(hintText: value,styleColor: Colors.white),
                      style:  TextStyle(
                   color: Colors.white, 
                   fontSize: 15
                 ),
                 
              
                   validator: press,
                   );
}

        addfoodItem({required String hintText,required Color styleColor}){
return textFieldDecoration.copyWith(
                hintText: hintText,
             hintStyle: const TextStyle(
                  color: Colors.white
                ),
                focusedBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
                    enabledBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
              );

  }

}