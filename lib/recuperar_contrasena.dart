import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'login.dart';

class RecuperarContrasena extends StatefulWidget {
  static const String ROUTE = "/recuperarcontrasena";
  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  TextEditingController correocontroler = TextEditingController();
  TextEditingController contrasenacontroller = TextEditingController();
  TextEditingController contrasenanuevacontroller = TextEditingController();
  bool verificacion = false;
  List datosusu;
  @override
  void initState() {
    validarCorreo().then((value) {
      datosusu = value;
      setState(() {
        print(datosusu);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pattern passvalida = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,8}$";
    RegExp regExp = RegExp(passvalida);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              Divider(),
              Text("Ingrese el correo electronico asociado a su cuenta:"),
              SizedBox(
                height: 50,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: correocontroler,
                decoration: InputDecoration(
                  hintText: "Ingrese su correo",
                ),
              ),
              Divider(),
              FlatButton(
                  color: Color.fromRGBO(0, 131, 163, 1),
                  onPressed: () async {
                    datosusu = await validarCorreo();
                    print(datosusu);
                    if (correocontroler.text == "") {
                      Fluttertoast.showToast(
                          msg: "ingrese un correo por favor ");
                    } else if (datosusu.length <= 0) {
                      Fluttertoast.showToast(
                          msg:
                              "no se ha encontrado ningun correo en nuestra base de datos");
                    } else {
                      verificacion = true;
                      setState(() {});
                    }
                  },
                  child: Text(
                    "validar correo",
                    style: TextStyle(color: Colors.white),
                  )),
              Divider(),
              Visibility(
                child: Container(
                  child: ListBody(
                    children: [
                      TextFormField(
                        controller: contrasenacontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "ingrese su nueva contraseña",
                        ),
                      ),
                      Divider(),
                      Divider(),
                      TextFormField(
                        controller: contrasenanuevacontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "confirme su nueva contraseña",
                        ),
                      ),
                      Divider(),
                      Divider(),
                      FlatButton(
                        color: Color.fromRGBO(0, 131, 163, 1),
                        onPressed: () {
                          if (contrasenacontroller.text.isNotEmpty &&
                              contrasenanuevacontroller.text.isNotEmpty) {
                            if (regExp.hasMatch(contrasenacontroller.text) &&
                                regExp
                                    .hasMatch(contrasenanuevacontroller.text)) {
                              if (contrasenacontroller.text ==
                                  contrasenanuevacontroller.text) {
                                editarUsuario();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "las contraseñas deben ser iguales");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "la contraseñas deben tener minimo un caracter alfabetico y uno numerico y tener un largo minimo de 5 y maximo de 8");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "por favor rellene los campos de la contraseñas ");
                          }
                        },
                        child: Text(
                          "cambiar contraseña",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                visible: verificacion,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List> validarCorreo() async {
    var correo = correocontroler.text;
    var url =
        "http://152.173.140.177/pruebastesis/validarCorreo.php?Usuario_correo=$correo";
    final response = await http.get(Uri.parse(url));
    final datauser = jsonDecode(response.body);

    return datauser;
  }

  Future editarUsuario() async {
    var correo = correocontroler.text;

    var url =
        "http://152.173.140.177/pruebastesis/recuperarContrasena.php?Usuario_correo=$correo";
    await http.post(Uri.parse(url), body: {
      'Usuario_contrasena': contrasenacontroller.text,
    });
  }
}
