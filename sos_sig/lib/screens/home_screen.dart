// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_sig/models/models.dart';
import 'package:sos_sig/screens/screens.dart';
import 'package:sos_sig/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productsService = Provider.of<AlarmaService>(context);
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        elevation: 0.0,
        title: Center(
          child: Center(
              child: Text(
            'Home Screen',
            style: TextStyle(color: Colors.black87),
          )),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          cardAmbulancia(context, productsService, authService),
          cardPolicia(context, productsService, authService),
          cardBombero(context, productsService, authService),
          SizedBox(height: 40),
          MaterialButton(
            minWidth: size.width - 120,
            child: const Text('Ver Historial',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300)),
            color: Colors.green.shade300,
            elevation: 0,
            height: 50,
            shape: const StadiumBorder(),
            onPressed: () async {
              Navigator.pushNamed(context, 'historial');
            },
          )
        ],
      ),
    );
  }

  Widget cardAmbulancia(BuildContext context, AlarmaService productsService,
      AuthService authService) {
    TimeOfDay hora = TimeOfDay.now();
    DateTime fecha = DateTime.now();
    return GestureDetector(
      onTap: () {
        print(authService.user?.email);
        productsService.selectedAlarmas = AlarmaModel(
            estado: 'Por Confirmar',
            fecha:
                "${fecha.day.toString()}/${fecha.month.toString()}/${fecha.year.toString()}",
            hora: "${hora.hour.toString()}:${hora.minute.toString()}",
            latitud: 1.0,
            longitud: 1.0,
            tipo: 'Ambulancia',
            emailC: authService.user!.email.toString(),
            emailA: 'Sin Asignar');
        Navigator.pushNamed(context, 'loading');
      },
      child: CardTipo(
        startColor: Color.fromRGBO(33, 215, 170, 1.0),
        endColor: Color.fromRGBO(48, 133, 222, 1.0),
        child: InformationCard(
          titulo: 'Ambulancia',
          icono: Icon(
            Icons.health_and_safety,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget cardPolicia(BuildContext context, AlarmaService productsService,
      AuthService authService) {
    TimeOfDay hora = TimeOfDay.now();
    DateTime fecha = DateTime.now();
    return GestureDetector(
      onTap: () {
        print(authService.user?.email);
        productsService.selectedAlarmas = AlarmaModel(
            estado: 'Por Confirmar',
            fecha:
                "${fecha.day.toString()}/${fecha.month.toString()}/${fecha.year.toString()}",
            hora: "${hora.hour.toString()}:${hora.minute.toString()}",
            latitud: 1.0,
            longitud: 1.0,
            tipo: 'Policia',
            emailC: authService.user!.email.toString(),
            emailA: 'Sin Asignar');
        Navigator.pushNamed(context, 'loading');
      },
      child: CardTipo(
        startColor: Color.fromRGBO(60, 106, 244, 1.0),
        endColor: Color.fromRGBO(206, 60, 222, 1.0),
        child: InformationCard(
          titulo: 'Policia',
          icono: Icon(
            Icons.policy,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget cardBombero(BuildContext context, AlarmaService productsService,
      AuthService authService) {
    TimeOfDay hora = TimeOfDay.now();
    DateTime fecha = DateTime.now();
    return GestureDetector(
      onTap: () {
        productsService.selectedAlarmas = AlarmaModel(
            estado: 'Por Confirmar',
            fecha:
                "${fecha.day.toString()}/${fecha.month.toString()}/${fecha.year.toString()}",
            hora: "${hora.hour.toString()}:${hora.minute.toString()}",
            latitud: 1.0,
            longitud: 1.0,
            tipo: 'Bomberos',
            emailC: authService.user!.email.toString(),
            emailA: 'Sin Asignar');
        Navigator.pushNamed(context, 'loading');
      },
      child: CardTipo(
        startColor: Color.fromRGBO(255, 106, 45, 1.0),
        endColor: Color.fromRGBO(255, 165, 27, 1.0),
        child: InformationCard(
          titulo: 'Bombero',
          icono: Icon(
            Icons.fire_hydrant,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  final icono;
  final String titulo;
  const InformationCard({
    Key? key,
    required this.icono,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    titulo,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(child: SizedBox()),
        Container(
          child: icono, //Image(image: image),
        ),
      ],
    );
  }
}
