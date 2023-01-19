import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remember_medi/bdd/repositorio.dart';
import 'package:remember_medi/funcion_color_hex/hexadecimal.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
// ignore: unused_import
import 'package:remember_medi/modelos/calendario_dia_modelo.dart';
import 'package:remember_medi/modelos/medicina.dart';
import 'package:remember_medi/notificaciones/notificaciones.dart';
import 'package:remember_medi/pantallas/inicio/calendario.dart';
import 'package:remember_medi/pantallas/inicio/lista_medicinas.dart';
//import 'package:remember_medi/pantallas/inicio/calendario.dart';

class Inicio extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Inicio> {

  /*Notificaciones de flutter*/
  final Notificaciones _notifications = Notificaciones();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /*Lista de medicinas de la base de datos*/
  List<Medicina> listaMedicinas = [];
  final Repositorio _repository = Repositorio();
  List<Medicina> medicinasDiarias = [];

  /*Dias calendario*/
  final CalendarioDiaModelo _dias = CalendarioDiaModelo(); 
  late List<CalendarioDiaModelo> _listaDias;

  /*Manejar el último índice de día elegido en el calendario*/
  int _ultimoDiaElegido = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    _listaDias = _dias.obtenerDiaActual();
  }

  //init notifications
  Future initNotifies() async => flutterLocalNotificationsPlugin = await _notifications.inicializarNotificaciones(context);

  /*Obtener todos los datos de la base*/
  Future setData() async {
    listaMedicinas.clear();
    (await _repository.obtenerDatos("Medicina"))!.forEach((medicinaMap) {
      listaMedicinas.add(Medicina().medicinaMapToObject(medicinaMap));
    });
    chooseDay(_listaDias[_ultimoDiaElegido]);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        //refresh the pills from database
        await Navigator.pushNamed(context, "/agregar_nueva_medicina")
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: '#85C1E9'.toColor(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Agenda",
                          style: Theme.of(context)
                              .textTheme
                              .headline1?.copyWith(color: Colors.black),
                        ),
                        /*ShakeWidget(
                          duration: Duration(milliseconds: 2000),
                          //shakeConstant: Rotation.deg(z: 30),
                          enableWebMouseHover: true,
                          shakeConstant: shakeConstant,
                          child: Icon(
                            Icons.notifications_none_sharp,
                            size: 42.0,
                          ),
                        )*/
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.5),
                  child: Calendario(chooseDay,_listaDias),
                ),
                SizedBox(height: deviceHeight * 0.03),
                medicinasDiarias.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: AnimatedTextKit(
                          animatedTexts:[
                            TypewriterAnimatedText(
                              "Aún no tienes medicinas registradas para el día de hoy",
                              textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                              speed: Duration(milliseconds: 50),
                              
                            ),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      )
                      : ListaMedicina(medicinasDiarias,setData,flutterLocalNotificationsPlugin)
              ],
            ),
          ),
        ),
      ),
    );
  }

void chooseDay(CalendarioDiaModelo diaClick){
    setState(() {
      _ultimoDiaElegido = _listaDias.indexOf(diaClick);
      _listaDias.forEach((day) => day.isChecked = false );
      CalendarioDiaModelo chooseDay = _listaDias[_listaDias.indexOf(diaClick)];
      chooseDay.isChecked = true;
      medicinasDiarias.clear();
      listaMedicinas.forEach((medicina) {
        DateTime pillDate = DateTime.fromMicrosecondsSinceEpoch(medicina.tiempo! * 1000);
        if(chooseDay.diaNumero == pillDate.day && chooseDay.mes == pillDate.month && chooseDay.year == pillDate.year){
          medicinasDiarias.add(medicina);
        }
      });
      medicinasDiarias.sort((medi1,medi2) => medi1.tiempo!.compareTo(medi2.tiempo!));
    });
  }
}