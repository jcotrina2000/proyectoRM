import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remember_medi/pantallas/agregar_nueva_medicina/agregarNuevaMedicina.dart';
import 'package:remember_medi/pantallas/bienvenida/bienvenida.dart';
import 'package:remember_medi/pantallas/inicio/inicio.dart';

void main() {
  runApp(MedicinaApp());
}

class MedicinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Popins",
          primaryColor: Colors.lightBlue,
          textTheme: TextTheme(
              headline1: ThemeData.light().textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 38.0,
                    fontFamily: "Popins",
                  ),
              headline5: ThemeData.light().textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.0,
                    fontFamily: "Popins",
                  ),
              headline3: ThemeData.light().textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    fontFamily: "Popins",
                  ))),
      routes: {
        "/": (context) => Bienvenida(),
        "/inicio": (context) => Inicio(),
        "/agregar_nueva_medicina": (context) => AgregarNuevaMedicina(),
      },
      initialRoute: "/",
    );
  }
  
}
