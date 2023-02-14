import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
  }
}