import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
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
    final double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedBuilder(
            animation: _animationController!,
            builder: (context,  child) {
              return Transform(
                transform: Matrix4.translationValues(
                  _animation!.value * width,
                  0.0,
                  0.0,
                ),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


class SlideAnimation extends StatefulWidget {
  final Widget child;
  const SlideAnimation({super.key, required this.child});

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin{

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
       final double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: AnimatedBuilder(
            animation: _animationController!,
            builder: (context,  child) {
              return Transform(
                transform: Matrix4.translationValues(
                  _animation!.value * 100,
                  0.0,
                  0.0,
                ),
                child: child
              );
            },
          ),
    );
  }
}