import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:intl/intl.dart';

class ReagendarInstalacion extends StatefulWidget {
  // ignore: constant_identifier_names
  static const String ROUTE = "/reagendarinstalacion";
  final String id;

  const ReagendarInstalacion({Key key, this.id}) : super(key: key);

  @override
  _ReagendarInstalacionState createState() => _ReagendarInstalacionState();
}

class _ReagendarInstalacionState extends State<ReagendarInstalacion> {
  var _currenteSelectedDate;

  TextEditingController controlFecha = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: [
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Text("Ingrese una nueva fecha"),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                          enableInteractiveSelection: false,
                          controller: controlFecha,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Debe Seleccionar Una Fecha para Reagendar la Instalacion";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Fecha',
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            callDatePicker();
                          }),
                      SizedBox(
                        height: 25.0,
                      ),
                      FlatButton(
                        color: Color.fromRGBO(0, 131, 163, 1),
                        child: Text(
                          "Listo",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            reagendarinstalacion();
                            Navigator.of(context)
                                .pushReplacementNamed("instalaciones");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: TrabajadorBottomBar('instalaciones'),
    );
  }

  void reagendarinstalacion() async {
    var id = await FlutterSession().get('id');
    var orden = ModalRoute.of(context).settings.arguments as String;
    var url = "http://152.173.140.177/pruebastesis/reagendarInstalacion.php";
    http.post(
      Uri.parse(url),
      body: {
        "Orden_Fecha": controlFecha.text.toString(),
        "Orden_id": orden.toString()
      },
    );
  }

  void callDatePicker() async {
    var selectedDate = await getDatePikerWidget();
    if (selectedDate != null) {
      final myFormat = DateFormat('yyyy-MM-d');
      controlFecha.text = myFormat.format(selectedDate);

      setState(() {});
    }
  }

  Future<DateTime> getDatePikerWidget() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2022),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child);
        });
  }
}
