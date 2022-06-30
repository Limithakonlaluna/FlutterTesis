import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'package:flutter_tesisv2/api.dart';
import 'package:flutter_tesisv2/recuperar_contrasena.dart';
import 'package:flutter_tesisv2/registro.dart';
import 'package:flutter_tesisv2/src/admin/admin.dart';
import 'package:flutter_tesisv2/src/trabajador/trabajador.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  static const String ROUTE = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String apiUrl = Api.url;
  String msgError = "";

  Future login(String correo, String contrasena) async {
    Uri url = Uri.parse(apiUrl);
    if (_correo.text == "" && _contrasena.text == "" ||
        _correo.text == "" ||
        _contrasena.text == "") {
      Fluttertoast.showToast(
          msg: "porfavor ingrese un correo y una contraseña");
    } else {
      final res = await http.post(url,
          body: {"Usuario_correo": correo, "Usuario_contrasena": contrasena});

      final data = jsonDecode(res.body);

      if (data['Usuario_id'] == null) {
        Fluttertoast.showToast(
            msg:
                "el usuario ingresado no existe, verifique su correo y contraseña");
      } else {
        await FlutterSession().set('id', int.parse(data['Usuario_id']));
      }

      if (data['Rol_id'] == "3") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Trabajador()));
        _correo.clear();
        _contrasena.clear();
        setState(() {
          msgError = "";
        });
      } else if (data['Rol_id'] == "2") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        _correo.clear();
        _contrasena.clear();
        setState(() {
          msgError = "";
        });
      } else {
        setState(() {
          msgError = "Nombre de usuario y/o contraseña incorrectas";
        });
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 248, 255, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      height: 200,
                      child: Center(child: Image.asset("assets/logo.png")),
                    ),
                    Divider(),
                    Container(
                      child: Center(
                        child: Text(
                          'Inicia sesión',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    Divider(),
                    TextFormField(
                        controller: _correo,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Debe Colocar Dato";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "ingrese su correo electronico",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Correo electronico',
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => node.nextFocus()),
                    TextFormField(
                        controller: _contrasena,
                        validator: (_contrasena) {
                          if (_contrasena.isEmpty) {
                            return "Debe Colocar Dato";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(labelText: 'Contraseña'),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => node.unfocus()),
                    SizedBox(
                      height: 30.0,
                    ),
                    FlatButton(
                      color: Color.fromRGBO(0, 131, 163, 1),
                      onPressed: () {
                        login(_correo.text, _contrasena.text);
                      },
                      child: Text(
                        'Iniciar Sesion',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registro()));
                      },
                      child: Text(
                        ' registrate aquí',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    /*  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecuperarContrasena()));
                      },
                      child: Text(
                        "Has olvidado tu contraseña, pincha aqui",
                        style: TextStyle(color: Colors.black),
                      ),
                    ), */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
