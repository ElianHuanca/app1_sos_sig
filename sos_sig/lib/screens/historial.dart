// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_sig/screens/screens.dart';
import 'package:sos_sig/services/services.dart';
import 'package:sos_sig/widgets/widgets.dart';



class HistorialScreen extends StatelessWidget {
  const HistorialScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<AlarmaService>(context);
    if( productsService.isLoading ) return CircularLoading();
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial De Peticiones'),
        backgroundColor: Colors.green.shade300,
      ),
      body: ListView.builder(
        itemCount: productsService.alarmas.length,
        itemBuilder: ( BuildContext context, int index ) => GestureDetector(
          /* onTap: () {
            productsService.selectedAlarmas = productsService.alarmas[index].copy();
            Navigator.pushNamed(context, 'loading3');
          }, */
            child: AlarmaCard(
              product: productsService.alarmas[index],
            ),  
        )
      ),
      
   );
  }
}