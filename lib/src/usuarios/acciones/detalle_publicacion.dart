import 'package:flutter/material.dart';

import 'package:flutter_tesisv2/src/usuarios/acciones/listar_publicaciones.dart';

import 'package:http/http.dart' as http;

class DetallePublicacion extends StatefulWidget {
  final int indexPub;

  final List listaPub;

  const DetallePublicacion({Key key, this.indexPub, this.listaPub})
      : super(key: key);

  @override
  _DetallePublicacionState createState() => _DetallePublicacionState();
}

class _DetallePublicacionState extends State<DetallePublicacion> {
  @override
  Widget build(BuildContext context) {
    var imagen = widget.listaPub[widget.indexPub]['Publicacion_imagen'];
    Pattern urlima =
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
    RegExp regExp = RegExp(urlima);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed("listapub");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              var url =
                  "http://152.173.140.177/pruebastesis/eliminarPublicacion.php";
              await http.post(Uri.parse(url), body: {
                "Publicacion_id": widget.listaPub[widget.indexPub]
                    ['Publicacion_id']
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListaPublicaciones()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: Column(
            children: [
              Center(
                child: widget.listaPub[widget.indexPub]['Publicacion_imagen'] !=
                        null
                    ? regExp.hasMatch(imagen)
                        ? FadeInImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                              widget.listaPub[widget.indexPub]
                                  ['Publicacion_imagen'],
                            ),
                            placeholder: AssetImage('assets/jar-loading.gif'),
                          )
                        : FadeInImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                                "http://152.173.140.177/lefufuapp/public/uploads/publicaciones/$imagen"),
                            placeholder: AssetImage('assets/jar-loading.gif'),
                          )
                    : Image.asset(
                        "assets/logo_fondo.png",
                        height: 350,
                        fit: BoxFit.fitWidth,
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nombre Publicacion:  " +
                    widget.listaPub[widget.indexPub]['Publicacion_nombre'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Divider(),
              Text(
                "Descripcion:  " +
                    widget.listaPub[widget.indexPub]['Publicacion_descripcion'],
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
