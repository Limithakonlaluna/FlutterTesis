import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tesisv2/src/usuarios/acciones/editar_usuario.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Cuenta extends StatefulWidget {
  static const String ROUTE = "/cuenta";

  @override
  _CuentaState createState() => _CuentaState();
}

class _CuentaState extends State<Cuenta> {
  List dataUsuario = [];
  int indexUsuario;
  final foto = ImagePicker();
  File fotoi;

  @override
  void initState() {
    verUsuario().then((value) {
      dataUsuario = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed("editarusuario"),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dataUsuario.length,
        itemBuilder: (context, index) {
          var imagen = dataUsuario[index]['Usuario_foto'];
          Pattern urlima =
              r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
          RegExp regExp = RegExp(urlima);
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => EditarUsuario(
                    indexCult: index,
                    listaCult: dataUsuario,
                  ),
                ),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Bienvenido " +
                                dataUsuario[index]['Usuario_nombre'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      child: dataUsuario[index]['Usuario_foto'] != null
                          ? dataUsuario[index]['Usuario_foto'] != "null"
                              ? regExp.hasMatch(imagen)
                                  ? FadeInImage(
                                      image: NetworkImage(
                                          dataUsuario[index]['Usuario_foto']),
                                      placeholder:
                                          AssetImage('assets/jar-loading.gif'),
                                    )
                                  : FadeInImage(
                                      image: NetworkImage(
                                          "http://152.173.140.177/lefufuapp/public/uploads/trabajadores/$imagen"),
                                      placeholder:
                                          AssetImage('assets/jar-loading.gif'),
                                    )
                              : Image.asset(
                                  "assets/no-image.png",
                                  fit: BoxFit.fill,
                                )
                          : Image.asset(
                              "assets/no-image.png",
                              fit: BoxFit.fill,
                            ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          "Nombre: " "" + dataUsuario[index]['Usuario_nombre'],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                        leading: Icon(Icons.email),
                        title: Text(
                          "Correo: " "" + dataUsuario[index]['Usuario_correo'],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                          "Direccion: " "" +
                              dataUsuario[index]['Usuario_direccion'],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          "Telefono: " "" +
                              dataUsuario[index]['Usuario_telefono'],
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List> verUsuario() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.140.177/pruebastesis/obtenerUsuario.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final dataUsuario = jsonDecode(response.body);
    return dataUsuario;
  }
}
