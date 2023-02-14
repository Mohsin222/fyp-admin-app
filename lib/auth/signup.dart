import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/components/text_field.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../widgets/dialog.dart';

class SignupScreen extends StatefulWidget {
  

  




  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController =TextEditingController();
   TextEditingController passwordController =TextEditingController();
      TextEditingController cpasswordController =TextEditingController();
         TextEditingController phoneController =TextEditingController();
            TextEditingController nameController =TextEditingController();

   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

  
     
    return Scaffold(

      
  
      body: 
   
 
         
     SafeArea(
       child: Container(
             height: MediaQuery.of(context).size.height,
          
         decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage('assets/auth_img/auth_img.jpg'),fit: BoxFit.cover,
           
           )
         ),
         alignment: Alignment.center,
         child: Column(
          children: [
         Expanded(child: Container(
          alignment: Alignment.center,
          child: Text('Signup Screen',style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        letterSpacing: 2
          ))
         )),
         Expanded(
          flex: 5,
          child: Consumer<AuthProvider>(builder: (context, value, child) {
            return Form(
            key: _formKey,
            child: Container(
                  
                  //  height: MediaQuery.of(context).size.height/2,
                   width: MediaQuery.of(context).size.width/1.1,
             child: ClipRRect(
             borderRadius: BorderRadius.circular(25),
             child: SingleChildScrollView(
               child: Container(
               padding:  EdgeInsets.all(24),
               height: MediaQuery.of(context).size.height/1.5,
               width: MediaQuery.of(context).size.width/1.3,
                   
               decoration: BoxDecoration(
                 color: Colors.white.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(25),
                 
                 border: Border.all(width: 2,color: Colors.grey)
               ),
               child:Stack(children: [
                 Column(
                 children: [
                   SizedBox(
                     height:MediaQuery.of(context).size.height/10
                   ),
                   TextFormField(
                         keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: textfieldDecoration(hintText: 'Enter Email',styleColor: Colors.white),
                      style:  TextStyle(
                   color: Colors.white, 
                   fontSize: 15
                 ),
                         
                   validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
                   ),
                       TextFormField(
                        controller: passwordController,
                    decoration: textfieldDecoration(hintText: 'Enter your Password',styleColor: Colors.white),
                      style:  TextStyle(
                   color: Colors.white, 
                   fontSize: 15
                 ),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                   ),
             
                                          TextFormField(
                                       
                        controller: cpasswordController,
                    decoration: textfieldDecoration(hintText: 'Enter your conform Password',styleColor: Colors.white),
                      style:  TextStyle(
                   color: Colors.white, 
                   fontSize: 15
                 ),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                   ),
                         TextFormField(
                               keyboardType: TextInputType.name,
                    decoration: textfieldDecoration(hintText: 'Please Enter Your Name',styleColor: Colors.white),
                      style:  TextStyle(
                   color: Colors.white, 
                   fontSize: 15
                 ),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  return null;
                },
                   ),
                                TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.number,
                    decoration: textfieldDecoration(hintText: 'Please Enter Your Phone number',styleColor: Colors.white),
                      style:  TextStyle(
                        
                   color: Colors.white, 
                   fontSize: 15
                 ),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Phone number';

                  }else if(value.length <11){
                       return 'Please Enter 11 digit Phone number';
                  }
                  return null;
                },
                   ),
                    
                  //   SizedBox(
                  //    height:MediaQuery.of(context).size.height/10
                  //  ),
        

                 button2(text: 'Signup', press: ()async{
                    if (_formKey.currentState!.validate()) {
                  // debugPrint("Valid");
             
                  if(passwordController.text.trim() ==cpasswordController.text.trim()){
              await    value.registerUser(email: emailController.text.trim(), password: passwordController.text.trim(),phone: phoneController.text.trim(),context: context);
                  }else{
             log('password not match');
               showDialog(context: context, builder: (context){
  
     return Dialog1(twobtn: false,btnText: "ERROR",showStatment:"password  and conform password not match",press: ()async{
     });
    });
                  }
             
                        
                }
                 }, )
                
                 ],
               ),

              value.loading ==true? 
               Center(
                child: CircularProgressIndicator(),
               )
               :Container()
               ],)
               
               ),
             ),
                 ),
                   ),
          );
          },),),
         Expanded(child: Container(
          child: InkWell(
            onTap: (){
               Navigator.pushNamed(context,Router1.homeRoute );
            },
            child: RichText(text: TextSpan(
                  text: 'Already have account ',
                  children: [
                    TextSpan(text: 'Login',
                    style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.red),
                    )
                  ]
            )),
          ),
         )),
          
          ],
         )
         
         
         ),
     )
      
      );
    
  }

  textfieldDecoration({required String hintText,required Color styleColor}){
return textFieldDecoration.copyWith(
                hintText: hintText,
             hintStyle: TextStyle(
                  color: styleColor
                ),
                focusedBorder: UnderlineInputBorder(
borderSide: BorderSide(color: styleColor)
                ),
                    enabledBorder: UnderlineInputBorder(
borderSide: BorderSide(color: styleColor)
                ),
              );

  }
}