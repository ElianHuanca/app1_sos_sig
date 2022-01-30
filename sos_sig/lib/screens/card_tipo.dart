// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CardTipo extends StatelessWidget {
  final Widget child;
  final Color startColor;
  final Color endColor;

  const CardTipo(
      {Key? key,
      required this.child,
      required this.startColor,
      required this.endColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            startColor,
            endColor,
          ],
        ),
        /* border: Border.all(
          color: Color.fromRGBO(164, 164, 166, 1.0),
        ), */
        // color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(164, 164, 166, 1.0),
            spreadRadius: 0.1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.all(15.0),
      child: child,
    );
  }
}
