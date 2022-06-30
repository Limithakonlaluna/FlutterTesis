import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';

class Trabajador extends StatefulWidget {
  static const String ROUTE = "/trabajador";
  final String id;

  const Trabajador({Key key, this.id}) : super(key: key);

  @override
  _TrabajadorState createState() => _TrabajadorState();
}

class _TrabajadorState extends State<Trabajador> {
  Future<Map> obtenerUsuarios() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.140.177/pruebastesis/obtenerHorario.php?Usuarioid=$id";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  List dataPub = [];
  int indexPublicacion;

  @override
  void initState() {
    verPublicaciones().then((value) {
      dataPub = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 165, 207, 1),
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
      body: ListView.builder(
        itemCount: dataPub.length,
        itemBuilder: (contex, index) {
          var imagen = dataPub[index]['Publicacion_imagen'];
          Pattern urlima =
              r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
          RegExp regExp = RegExp(urlima);

          return Container(
            margin: EdgeInsets.all(8),
            child: Card(
              color: Color.fromRGBO(240, 248, 255, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "     Titulo : " + dataPub[index]['Publicacion_nombre'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "     Autor : " + dataPub[index]['Usuario_nombre'],
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: dataPub[index]['Publicacion_imagen'] != null
                        ? regExp.hasMatch(imagen)
                            ? FadeInImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  dataPub[index]['Publicacion_imagen'],
                                ),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                              )
                            : FadeInImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                    "http://152.173.140.177/lefufuapp/public/uploads/publicaciones/$imagen"),
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                              )
                        : Image.asset(
                            "assets/logo_fondo.png",
                            height: 350,
                            fit: BoxFit.fitWidth,
                          ),
                  ),
                  Divider(),
                  Container(
                      child: Container(
                    width: 350,
                    child: Text(
                      dataPub[index]['Publicacion_descripcion'],
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  )),
                  Divider(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: TrabajadorBottomBar('trabajador'),
    );
  }

  Future<List> verPublicaciones() async {
    var url = "http://152.173.140.177/pruebastesis/obtenerPublicaciones.php";
    final response = await http.get(Uri.parse(url));
    final dataPub = jsonDecode(response.body);
    return dataPub;
  }
}
