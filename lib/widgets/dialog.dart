import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_app/components/button2.dart';

class Dialog1 extends StatelessWidget {
  final bool twobtn;
  final VoidCallback press;
  final String btnText;
  final String showStatment;
  const Dialog1({super.key,   this.twobtn=false, required this.press, required this.btnText, required this.showStatment});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        child: Dialog(
         
          // insetAnimationCurve:Curves.easeIn,
      elevation: 0,
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
          height: width > 800
              ? height / 1.5
              : width > 600
                  ? height / 1.5
                  : height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Stack(
            // fit: StackFit.
            // loose,
       
            clipBehavior: Clip.none,
            children: [
              Container(
           
               padding: EdgeInsets.all(10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                 
                  children: [
                        SizedBox(
                      height: 30,
                    ),
                    Flexible(
                      child:  Text(
                        showStatment,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        dialogBtn(
                          text: 'Back',
                          press: () {
                            Navigator.of(context).pop();
                          },

                          // child: const Text("Okay"),
                        ),

                        Visibility(
                          visible: twobtn,
                          child:     dialogBtn(
                          text: btnText,
                          press:press,
                                                  
                          // child: const Text("Okay"),
                                                ),)
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -30,
                left: 0,
                right: 0,
                // bottom: 0,
                child: Container(
                  width: 80,
                  height: 80,
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
                          image: AssetImage(
                            'assets/auth_img/auth_img.jpg',
                          ))),
                ),
              )
            ],
          )),
    ));
  }


  Widget dialogBtn({required String text, required VoidCallback press}){
    return ElevatedButton(
                    onPressed:press,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xff1fc9b1),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 20),
                    ),
       
                    child: Text(
                      text,
                      style: TextStyle(
      fontSize: 14,
      letterSpacing: 2.2,
      color: Colors.white),
                    ),
                  );
  }
}
