import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TimerFunction extends StatefulWidget {
  const TimerFunction({super.key});

  @override
  State<TimerFunction> createState() => _TimerFunctionState();
}

class _TimerFunctionState extends State<TimerFunction> {

int timeleft=60;

  void _countdown(){
    Timer.periodic(Duration(seconds: 2), (timer) { 
    if(timeleft >0){
        setState(() {
        timeleft--;
      });
    }else{
      timer.cancel();
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.baby_changing_station),onPressed: (){
        Navigator.pop(context);
      },)),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Text(timeleft ==0 ? 'Done':timeleft.toString(),style: TextStyle(fontSize: 30),),
          MaterialButton(onPressed: _countdown,child: Text('START'),color: Colors.pinkAccent,)
        ],
      )),
    );
  }
}