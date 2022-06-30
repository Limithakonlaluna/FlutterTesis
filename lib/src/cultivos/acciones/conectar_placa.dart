import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/detalle_cultivos.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/providers/sensor_provider.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Placa extends StatefulWidget {
  static const String ROUTE = '/conectarplaca';
  final String algo;

  const Placa({Key key, this.algo}) : super(key: key);
  @override
  _PlacaState createState() => _PlacaState();
}

class _PlacaState extends State<Placa> {
  TextEditingController macPlaca = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Pattern macvalida = r"^([0-9A-Fa-f]{2}[:]){5}([0-9A-Fa-f]{2})$";
    RegExp regExp = RegExp(macvalida);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      drawer: NavDrawer(),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Text(
                  //
                  "Vamos a vincular su producto ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    maxLength: 17,
                    controller: macPlaca,
                    decoration: InputDecoration(
                        labelText: 'Ingrese la MAC de su placa'),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                    color: Color.fromRGBO(0, 131, 163, 1),
                    onPressed: () {
                      if (macPlaca.text != "") {
                        if (regExp.hasMatch(macPlaca.text)) {
                          vincularPlaca();
                          Navigator.pushNamed(context, "cultivos");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Por favor ingrese una mac valida ");
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "por favor ingrese alguna mac");
                      }
                    },
                    child: const Text(
                      "aceptar",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
    );
  }

  void vincularPlaca() async {
    var cultivo = ModalRoute.of(context).settings.arguments as String;
    print('vinculando placa ${macPlaca.text} al cultivo $cultivo');
    var cultivo1 = widget.algo;
    // print('vinculando placa ${macPlaca.text} al cultivo $cultivo1');
    var url = "http://152.173.140.177/pruebastesis/agregarMac.php";
    // final response = await http.get(Uri.parse(url));
    await http.post(
      Uri.parse(url),
      body: {
        "Cultivo_id": cultivo1,
        "Sensores_nombre": macPlaca.text,
      },
    );

    SensorProvider().actualizarDatos(macPlaca.text, SensorModel());
  }
}
