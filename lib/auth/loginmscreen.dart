import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_app/auth/signup.dart';
import 'package:fyp_app/components/button2.dart';
import 'package:fyp_app/components/text_field.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:fyp_app/providers/auth_provider.dart';
import 'package:fyp_app/views/food_homepage.dart';
import 'package:fyp_app/widgets/hidden_drawer.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  

  




  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController =TextEditingController();
   TextEditingController passwordController =TextEditingController();

   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

  
     
    return Scaffold(

      
  
      body: 
   
 
         
     SafeArea(
       child: SingleChildScrollView(
         child: Consumer<AuthProvider>  (builder: (context, value, child) {
           return Container(
               height: MediaQuery.of(context).size.height,
         
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage('assets/auth_img/auth_img.jpg'),fit: BoxFit.cover,
             
             )
           ),
           alignment: Alignment.center,
           child:   value.loading ==true? Center(child: CircularProgressIndicator(),): Column(
            children: [
           Container(
            alignment: Alignment.center,
            child: Text('LoginScreen',style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 2
            ))
           ),
           Spacer(),
           Form(
             key: _formKey,
             child: Container(
                   
                    // height: MediaQuery.of(context).size.height/2,
                    // width: MediaQuery.of(context).size.width/1.1,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
              padding:  EdgeInsets.all(24),
              // height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width/1.3,
                  
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                
                border: Border.all(width: 2,color: Colors.grey)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height:MediaQuery.of(context).size.height/10
                  ),
                  TextFormField(
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
                   
                   SizedBox(
                    height:MediaQuery.of(context).size.height/10
                  ),
                
                button2(press: (){
                   if (_formKey.currentState!.validate()) {
                 debugPrint("Valid");
            value.login(email:emailController.text.trim(),password: passwordController.text.trim(),context: context);
               //  Timer(Duration(seconds: 5),(){

               //  });

                 
               }
                }, text: 'Login',
                
                )
               
                ],
              ),
              
              ),
                  ),
                    ),
           ),
           Expanded(child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
            },
             child: Container(
              child: RichText(text: TextSpan(
                    text: 'Not have account ',
                    children: [
                      TextSpan(text: 'Signup',
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
           
           
           );
         },)     ),
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