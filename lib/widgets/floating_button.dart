import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Icon(Icons.add, color: Colors.white, size: 25,),
    );
  }
}
