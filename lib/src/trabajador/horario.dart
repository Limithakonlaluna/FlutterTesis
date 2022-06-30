import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_session/flutter_session.dart';

class Horario extends StatefulWidget {
  static const String ROUTE = "/horario";
  final String id;

  const Horario({Key key, this.id}) : super(key: key);

  @override
  _HorarioState createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  Future<Map> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.140.177/pruebastesis/obtenerHorario.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              FlutterSession().set('id', 0);
              Navigator.of(context).pushReplacementNamed("login");
            },
            child: FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                child: Text(
                  "Dia Lunes",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Martes",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Miercoles",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Jueves",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Viernes",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
              Container(
                child: Text(
                  "Dia Sabado",
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: FutureBuilder<dynamic>(
                  future: obtenerUsuarios(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.hasError)
                      print(snapshot.error);
                    return snapshot.hasData
                        ? ElementoLista(
                            inicio: snapshot.data['Horario_inicio'],
                            cierre: snapshot.data['Horario_fin'],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: TrabajadorBottomBar('horario'),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final String inicio;
  final String cierre;

  const ElementoLista({Key key, this.inicio, this.cierre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 220,
      padding: EdgeInsets.all(2),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color.fromRGBO(0, 131, 163, 1),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Inicio:   " + inicio,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Cierre:   " + cierre,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
