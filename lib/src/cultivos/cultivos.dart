import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/agregar_cultivo.dart';
import 'package:flutter_tesisv2/src/cultivos/acciones/detalle_cultivos.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:flutter_tesisv2/src/usuarios/sidebar.dart';
import 'package:http/http.dart' as http;

class Cultivo extends StatefulWidget {
  static const String ROUTE = '/cultivos';
  @override
  _CultivoState createState() => _CultivoState();
}

class _CultivoState extends State<Cultivo> {
  List dataCult = [];

  @override
  void initState() {
    verCultivos().then((value) {
      dataCult = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 165, 207, 1),
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("home");
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: dataCult.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => DetalleCultivo(
                      indexCult: index,
                      listaCult: dataCult,
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Nombre del cultivo : " +
                                  dataCult[index]['Cultivo_apodo'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "tipo del cultivo : " +
                                  dataCult[index]['Tipo_nombre'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                margin: EdgeInsets.all(9),
                                width: 120.0,
                                height: 120.0,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      dataCult[index]['Cultivo_imagen']),
                                  placeholder:
                                      AssetImage('assets/jar-loading.gif'),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(240, 248, 255, 1),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        child: Icon(
          Icons.add,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AgregarCultivo())),
      ),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
    );
  }

  Future<List> verCultivos() async {
    var id = await FlutterSession().get('id');
    var url =
        "http://152.173.140.177/pruebastesis/obtenerCultivo.php?Usuario_id=$id";
    final response = await http.get(Uri.parse(url));
    final dataProd = jsonDecode(response.body);
    return dataProd;
  }
}
