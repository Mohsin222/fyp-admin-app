import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';

import '../components/button2.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {



  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    bool showPassword = false;

    TextEditingController nameController =TextEditingController();
    
  TextEditingController phoneController =TextEditingController();
           


            @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
  }
   

  @override
  Widget build(BuildContext context) {
    
    final height =MediaQuery.of(context).size.height;
    print(MediaQuery.of(context).size.height/5);
    
    return Scaffold(
         appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
  
      ),

      body: Consumer<AuthProvider>(

        builder: (context, value,child) {

        phoneController.text=value.logedUser!.phone.toString();
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            margin: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: (){
                     FocusScope.of(context).unfocus();
              },
              child:Stack(children: [
                 ListView(
                children: [
                          Text(
                    "Edit Profile",
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(child: Stack(
      
                    children: [
                 value.file !=null ?
                      Container(
      
                         width: 130,
                          height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context).scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(value.file! )
                              )
                    
                                  
                                  ),
                             
                      )
                      :
                           Container(
      
                         width: 130,
                          height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    (value.logedUser!.profilepic !=null)?
                                    value.logedUser!.profilepic.toString()
                                    :'https://images.unsplash.com/photo-1671955100937-6c551efa6e15?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'
                                  )
                              )
                    
                                  
                                  ),
                             
                      ),
      
                      Positioned(child: InkWell(
                        onTap: (){
                          value.pickImage();
                        },
                        child: Container(
                               height: 40,
                                width: 40,
                                 decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                          child:  Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                        ),
                      )),
                
                 
                    ],
                  ),),
                            SizedBox(
                    height: 35,
                  ),
                      buildTextField("Full Name",value.logedUser!.fullname.toString(), false,nameController),
              
                  // buildTextField("Phone",value.logedUser!.phone.toString(), false,phoneController),
                  //  buildTextField("Phone Number",value.logedUser!.phone.toString(), false,phoneController)
                  // 
                  Container(
                    // margin: EdgeInsets.all(10),
           
                    width: MediaQuery.of(context).size.width/2,
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: phoneController,
        keyboardType: TextInputType.number,
        maxLength: 11,
        decoration: InputDecoration(
          
   
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: 'Phone Number',
            // labelStyle: TextStyle(color: Colors.white),
       
            hintText: value.logedUser!.phone,
            
            
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
                 focusedBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
                    enabledBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
            ),
      ),
    ),
                    SizedBox(
                    height: 35,
                  ),
             
      
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                                TextButton(
              
                        style: ButtonStyle(
             
                        ),
                
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white)),
                      ),
                            button2(text: 'Save',press: ()async{
                        //  final profileProvider =Provider.of<ProfileProvider>(context,listen: false);
                        //  profileProvider.changePofileDetails(uid: value.logedUser!.uid.toString());
                 await      value.changePofileDetails(context: context,phone: phoneController.text.trim(),name: nameController.text.trim() );
                            },)
                        ],
                  )
                ],
              ),

              value.loading ==true?
              Center(
                child: CircularProgressIndicator(),
              ):Container()
              ],)
            ),
          );
        }
      ),
    );
  }

    Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField,TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,

            ),
                 focusedBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
                    enabledBorder:const UnderlineInputBorder(
borderSide: BorderSide(color: Colors.white)
                ),
            
            ),
      ),
    );
  }
}

