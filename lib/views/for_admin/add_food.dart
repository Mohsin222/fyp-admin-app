import 'dart:developer';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/backbtn.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/models/food_item.dart';
import 'package:fyp_app/providers/add_food_provider.dart';
import 'package:fyp_app/widgets/dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/text_field.dart';
import '../../constants/routes.dart';

class AddFood extends StatelessWidget {



GlobalKey<FormState> _addFoodKey = GlobalKey<FormState>();

 
    //  TextEditingController nameController =TextEditingController();
    //  TextEditingController priceController =TextEditingController();
    //     TextEditingController descriptionController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Food',style: TextStyle(color: Colors.white),),
      backgroundColor: Theme.of(context).cardColor,
      leading: BackBtn(),
      ),
// 
      body: Container(
            child: Form(
              key: _addFoodKey,
              child: Consumer<AddFoodProvider>(
            
             builder:(context,foodProvider,child) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child:SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                                   SizedBox(
              height: MediaQuery.of(context).size.height/20,
             
            ),
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
                                   textfield(value: "Enter Name",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter food name';
                                  }else{
                                        foodProvider.name=val;
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
                                        foodProvider.price=double.parse(value);
                                  }
                                   }),
                                  //  Size 1
                                   textfield(value: "Enter Size1",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Size1 name';
                                  }else{
                                        foodProvider.size1=val;
                                  }
                             
                                   }
                                   
                                   ),

                                         //  Size 2
                                   textfield(value: "Enter Size2",
                                  
                                   keyboardType: TextInputType.name,
                                   
                                   press: (val) {
               
                                        if (val!.isEmpty) {
                                    return 'Please enter Size1 name';
                                  }else{
                                        foodProvider.size2=val;
                                  }
                             
                                   }
                                   
                                   ),
 

      //drop down field
            DropdownButtonFormField(
            
            decoration: addfoodItem(hintText: '',styleColor: Colors.black),
                 dropdownColor: Theme.of(context).cardColor,
                 value: foodProvider.fooditemValue,
                 onChanged: ((value) {
                   foodProvider.pickCategory(value as String);
                 }),

                   items:  foodProvider.foodItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items,style: TextStyle(color: Colors.white),),
                );
            }).toList(),
            ),

            //meal drop down
            DropdownButtonFormField(
            
            decoration: addfoodItem(hintText: '',styleColor: Colors.black),
                 dropdownColor: Theme.of(context).cardColor,
                 value: foodProvider.foodtp,
                 onChanged: ((value) {
                   foodProvider.pickfoodType(value as String);
                 }),

                   items:  foodProvider.foodtype.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items,style: TextStyle(color: Colors.white),),
                );
            }).toList(),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height/20,
          
            ),
                                   //description
                                        Container(
                                          height: MediaQuery.of(context).size.height/8,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.white)),

                                 
                                          child: TextFormField(
                                            keyboardType: TextInputType.multiline,
                                        
                                          // minLines: null,
                                          maxLines: 10,
                                            decoration:textFieldDecoration.copyWith(
                                                        hintText: 'Enter Description',
                                                     hintStyle: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                              enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                         color: Colors.grey, 
                         width: 2)),
                      
                                                 
                                                        // focusedBorder: InputBorder.none,
                                   
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
            ),
                            //            ElevatedButton(onPressed: ()async{
                            
                            //    }, child: Text('Add',
                            //  style:   TextStyle(fontSize: 19,letterSpacing: 4,fontWeight: FontWeight.w400,color: Colors.white),
                            //    ),
                            //    style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color(0xffFF9A9E),
                            //     // maximumSize:Size( MediaQuery.of(context).size.width/2,10),
                            //     minimumSize: Size( MediaQuery.of(context).size.width/2,MediaQuery.of(context).size.height/18),
                            //    ),
                            //    ),

                
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
                    ) );
                }
              ),
            ),
          )
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