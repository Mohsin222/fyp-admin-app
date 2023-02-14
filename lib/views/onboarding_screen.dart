import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/constants/routes.dart';
import 'package:provider/single_child_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with  SingleTickerProviderStateMixin{
 AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      
      duration: Duration(seconds: 1),
    );
    _animationController!.forward();
    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1535923987804-b43cb426f2ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTIwfHxncmlsbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'),fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            Spacer(),
                AnimatedBuilder( animation: _animationController!, builder: ((context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                             _animation!.value * 100,
                  0.0,
                  0.0,
                    ),
                    child: Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    text:TextSpan(
                    text: 'Choose Your Delecious ',
                    // style:  TextStyle(
                    //   color: Colors.black,
                    //         fontSize: 28,
                    //         fontWeight: FontWeight.w700
                    //       ),
                    style: Theme.of(context).textTheme.headline1!.copyWith(color: Colors.white,fontSize: 38,fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: 'Food',
                          //      style:  TextStyle(
                          //   fontSize: 28,
                          //   fontWeight: FontWeight.w700,
                          //  color: Colors.orange[100],
                          //  fontFamily: "Prosto One",
                          // ),
                          style:  Theme.of(context).textTheme.headline1!.copyWith(color:  Colors.orange[100],fontSize: 38,fontWeight: FontWeight.bold),
                            ),
                          ]
                  ) ),
                ),
                  );
                  
                })),
             
            textButton1(context:context,color:Colors.transparent,text: "LOGIN", press: () {         Navigator.pushNamed(context, Router1.loginScreen);},),
            textButton1(context:context,color:Colors.orange[100]!,text: 'SIGN UP', press: () {Navigator.pushNamed(context, Router1.signUpScreen);  }),

          ],
        ),
      ),
    );
  }
 textButton1({required BuildContext context,required Color color, required String text,required VoidCallback press}) {
    return InkWell(
      onTap: press,
      child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white),
                   color: color,
              borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
         
              height: 70,
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 5,top: 20),
              child:  Text(text,
              style: TextStyle(
      
                fontSize: 24,letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: "Prosto One",
              ),)),
    );
  }
 
}

 