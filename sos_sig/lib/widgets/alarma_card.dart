// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:sos_sig/models/models.dart';

class AlarmaCard extends StatelessWidget {
  final AlarmaModel product;
  const AlarmaCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade300,
        child:Icon(
          Icons.railway_alert_rounded,
          color: Colors.white,
        ),
      ),
      title: Text(
        product.tipo,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(product.estado),
    );
  }
}
