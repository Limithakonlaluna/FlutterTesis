import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/conectar_placa.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/providers/sensor_provider.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Sensores extends StatefulWidget {
  static const String ROUTE = "/Sensores";

  Sensores({Key key}) : super(key: key);

  @override
  _SensoresState createState() => _SensoresState();
}

class _SensoresState extends State<Sensores> {
  SensorModel sensor = SensorModel();
  final sensorProvider = SensorProvider();

  String temperaturaMa = "";
  String temperaturaMi = "";
  String humedadsql = "";

  final _formKey = GlobalKey<FormState>();
  TextEditingController minima = TextEditingController();
  TextEditingController maxima = TextEditingController();
  TextEditingController humedad = TextEditingController();

  @override
  void didChangeDependencies() {
    obtenerdatosSensores().then((value) {
      if (value.length >= 1) {
        if (value != null) {
          temperaturaMa = value[0]['Sensores_maxima'].toString();
          temperaturaMi = value[0]['Sensores_minima'].toString();
          humedadsql = value[0]['Sensores_humedad'].toString();
          setState(() {});
        }

        setState(() {});
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("maxima");
    print(temperaturaMa);
    print("maxima");
    print(temperaturaMi);
    print("humedad");
    print(humedadsql);

    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Column(
              children: [
                listaSensores(),
                FlatButton(
                  color: Color.fromRGBO(0, 131, 163, 1),
                  onPressed: () {
                    _submit();
                    editarSensoressql();
                    // Navigator.pop(context);
                  },
                  child: Text(
                    "asignar parametros",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
    );
  }

  Future<List> obtenerdatosSensores() async {
    String placasql = ModalRoute.of(context).settings.arguments as String;
    var url =
        'http://152.173.140.177/pruebastesis/obtenerDatosSensor.php?Sensores_nombre="$placasql"';
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  void editarSensoressql() async {
    var placasql = ModalRoute.of(context).settings.arguments as String;
    var url =
        'http://152.173.140.177/pruebastesis/editarDatosSensoresql.php?Sensores_nombre=$placasql';
    await http.post(Uri.parse(url), body: {
      'Sensores_minima': minima.text,
      'Sensores_maxima': maxima.text,
      'Sensores_humedad': humedad.text,
    });
  }

  Widget listaSensores() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la temperatura minima de su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: minima,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'Temperatura minima:  ' + temperaturaMi + 'c°',
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la temperatura maxima de su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: maxima,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'Temperatura maxima:  ' + temperaturaMa + "c°",
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la humedad de su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextFormField(
            controller: humedad,
            maxLength: 3,
            decoration: InputDecoration(
              labelText: "humedad:  " + humedadsql + "%",
              suffixText: '%',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _submit() {
    var placa = ModalRoute.of(context).settings.arguments as String;

    if (minima.text.isEmpty) {
      minima.text = temperaturaMi;
      sensor.temp_minima = int.parse(temperaturaMi);
    } else {
      sensor.temp_minima = int.parse(minima.text);
    }

    if (maxima.text.isEmpty) {
      maxima.text = temperaturaMa;
      sensor.temp_maxima = int.parse(temperaturaMa);
    } else {
      sensor.temp_maxima = int.parse(maxima.text);
    }

    if (humedad.text.isEmpty) {
      humedad.text = humedadsql;
      sensor.humedad_minima = int.parse(humedadsql);
    } else {
      sensor.humedad_minima = int.parse(humedad.text);
    }

    sensorProvider.actualizarDatos(placa, sensor);
  }
}
