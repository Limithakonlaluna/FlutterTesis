import 'package:flutter/material.dart';

class TrabajadorBottomBar extends StatelessWidget {
  final String barItem;
  final Map<String, int> _barItemIndexMap = {
    'datostrabajador': 0,
    'trabajador': 1,
    'instalaciones': 2,
    'horario': 3,
  };

  TrabajadorBottomBar(this.barItem);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      currentIndex: _barItemIndexMap[barItem],
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.blueGrey,
            size: 27,
          ),
          label: 'Perfil',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.blueGrey,
            size: 27,
          ),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
            color: Colors.blueGrey,
            size: 27,
          ),
          label: 'Instalaciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.watch_later_rounded,
            color: Colors.blueGrey,
            size: 27,
          ),
          label: 'Horario',
        ),
      ],
      onTap: (index) => _handleNavigationAction(context, index),
    );
  }

  void _handleNavigationAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'datostrabajador');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, 'trabajador');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, 'instalaciones');
        break;

      case 3:
        Navigator.pushReplacementNamed(context, 'horario');

        break;
    }
  }
}

class ClienteBottomBar extends StatelessWidget {
  final String barItem;
  final Map<String, int> _barItemIndexMap = {
    'alertas': 0,
    'home': 1,
    'cultivos': 2,
  };

  ClienteBottomBar(this.barItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      currentIndex: _barItemIndexMap[barItem],
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'notificaciones',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ),
          label: 'cultivo',
        ),
      ],
      onTap: (index) => _handleNavigationAction(context, index),
    );
  }

  void _handleNavigationAction(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'alertas');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, 'home');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, 'cultivos');

        break;
    }
  }
}
