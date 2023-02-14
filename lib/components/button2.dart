import 'package:flutter/material.dart';

class button2 extends StatelessWidget {
  final String text ;
  final VoidCallback press;
  const button2({
    Key? key, required this.text, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                    onPressed:press,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xff1fc9b1),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 50),
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