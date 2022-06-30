import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:http/http.dart' as http;

class SensorProvider {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  final databaseRef = FirebaseDatabase.instance.reference();

  void actualizarDatos(String mac, SensorModel model) async {
    print('estoy weando con la placa $mac');
    databaseRef.child('/$mac').update(model.toJson());
  }

  void listarDatos(String mac) async {}
}
