import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/backbtn.dart';
import 'package:fyp_app/models/userModel.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;
  const UserDetails({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        leading: BackBtn(),
      ),
           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
           body: SafeArea(
                minimum: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                             CircleAvatar(
                radius: 50,
                backgroundColor:Color(0xffFF9A9E) ,
                backgroundImage: NetworkImage(userModel.profilepic.toString()),
              ),
                      Text(
                userModel.fullname.toString(),
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
       
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              InfoCard(text: userModel.phone.toString(), icon: Icons.phone, press: (){},),
              
              // InfoCard(
              //     text: location,
              //     icon: Icons.location_city,
              //     onPressed: () async {}),
              InfoCard(text: userModel.email.toString(), icon: Icons.email,press: (){}, ),
                  ],
                ),
           ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
 final VoidCallback press;


  InfoCard(
      {required this.text, required this.icon, required this.press,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: press,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: "Source Sans Pro"),
          ),
        ),
      ),
    );
  }
}