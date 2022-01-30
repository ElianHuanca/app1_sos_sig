import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:sos_sig/models/models.dart';

class AlarmaService extends ChangeNotifier {
  final String _baseUrl = 'sosscz-22cd4-default-rtdb.firebaseio.com';
  final List<AlarmaModel> alarmas = [];
  late AlarmaModel selectedAlarmas;
  final User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  bool isSavig = false;
  AlarmaService() {
    loadAlarmas();
  }
  Future<List<AlarmaModel>> loadAlarmas() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'alarma.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = AlarmaModel.fromMap(value);
      tempProduct.id = key;
      if(tempProduct.emailC.contains(user!.email.toString())){
        alarmas.add(tempProduct);
      } 
      //alarmas.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return alarmas;
  }

  Future<String> createAlarma(AlarmaModel product) async {
    final url = Uri.https(_baseUrl, 'alarma.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);
    product.id = decodedData['name'];
    alarmas.add(product);
    return product.id!;
  }
}
