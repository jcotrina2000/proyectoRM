import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:remember_medi/extras/platform_flat_button.dart';
import 'package:remember_medi/bdd/repositorio.dart';
import 'package:remember_medi/extras/snack_bar.dart';
import 'package:remember_medi/modelos/medicina.dart';
import 'package:remember_medi/modelos/tipo_medicina.dart';
import 'package:remember_medi/notificaciones/notificaciones.dart';
import 'package:remember_medi/funcion_color_hex/hexadecimal.dart';
import 'package:remember_medi/pantallas/agregar_nueva_medicina/carta_tipo_medicina.dart';
import 'package:remember_medi/pantallas/agregar_nueva_medicina/formFields.dart';
import 'package:remember_medi/pantallas/agregar_nueva_medicina/funcion_formula.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AgregarNuevaMedicina extends StatefulWidget{
  @override
  _AgregarNuevaMedicinaState createState() => _AgregarNuevaMedicinaState();
  }

  class _AgregarNuevaMedicinaState extends State<AgregarNuevaMedicina> {
    late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

    final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
    final Snackbar snackbar = Snackbar();

    /*Unidades de la medicina*/
    final List<String> valoresUnidades = ["pildoras", "ml", "mg"];

    /*Valores ComboBox horas-días-semanas*/
    final List<String> valoresTiempos = ["horas", "días", "semanas"];

    /*Lista de objetos de formas de medicina*/
    final List<TipoMedicina> medicineTypes = [
      TipoMedicina("Jarabe", Image.asset("assets/images/jarabe.png"), true),
      TipoMedicina(
          "Pildora", Image.asset("assets/images/pildora.png"), false),
      TipoMedicina(
          "Jeringuilla", Image.asset("assets/images/jeringuilla.png"), false),
      TipoMedicina(
          "Tableta", Image.asset("assets/images/tableta.png"), false),
    ]; 

    /*Objeto medicina*/
    int cantidadSemanas = 1;
    late String unidadSeleccionada;
    DateTime setDate = DateTime.now();
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController cantidadController = TextEditingController();
    final TextEditingController numeroHorasController = TextEditingController();

    /*Base de datos y notificaciones*/
    final Repositorio _repositorio = Repositorio();
    final Notificaciones _notifications = Notificaciones();

    @override
    void initState() {
      super.initState();
      unidadSeleccionada = valoresUnidades[0];
      initNotifies();
    }

    //init notifications
    Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notifications.inicializarNotificaciones(context);


    @override
    Widget build(BuildContext context) {
      final deviceHeight = MediaQuery.of(context).size.height - 60.0;
      return Scaffold(  
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: '#85C1E9'.toColor(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: deviceHeight * 0.04,
                  child: FittedBox(
                    child: InkWell(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0),
                  height: deviceHeight * 0.04,
                  child: FittedBox(
                      child: Text(
                    "Agregar medicina",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.black),
                  )),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Container(
                height: deviceHeight * 0.36,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FormFields(
                        cantidadSemanas,
                        unidadSeleccionada,
                        popUpMenuItemChanged,
                        sliderChanged,
                        nombreController,
                        cantidadController,
                        numeroHorasController,)),
                ),
                SizedBox(
                height: deviceHeight * 0.05,
                ),
                Container(
                height: deviceHeight * 0.03,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FittedBox(
                    child: Text(
                      "Forma Medicina",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...medicineTypes.map(
                        (type) => CardTipoMedicina(type, medicineTypeClick))
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                width: double.infinity,
                height: deviceHeight * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openTimePicker(),
                          botonHijo: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat.Hm().format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.access_time,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openDatePicker(),
                          botonHijo: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat("dd.MM").format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.event,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Spacer(),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                height: deviceHeight * 0.08,
                width: double.infinity,
                child: PlatformFlatButton(
                  handler: () async => guardarMedicina(),
                  color: Theme.of(context).primaryColor,
                  botonHijo: Text(
                    "Hecho",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  ),
                ),
              )
              ]
            ),
          ),
        ),

        
      );
      
    }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => this.cantidadSemanas = value.round());

  //Elegir popum menu item
  void popUpMenuItemChanged(String value) =>
    setState(() => this.unidadSeleccionada = value);

  /*Cambiar el tiempo de la medicina*/

  Future<void> openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Elegir tiempo")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }

  /*Guardar medicina en la base de datos*/

  Future guardarMedicina() async {
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      snackbar.showSnack(
          "Revisa la hora de tu medicina y la fecha", _scaffoldKey, null);
    } else {
      //create pill object
      Medicina medicina = Medicina(
          cantidad: cantidadController.text,
          semanas: cantidadSemanas,
          cadaNHoras: numeroHorasController.text,
          formaMedicina: medicineTypes[medicineTypes.indexWhere((element) => element.esElegido == true)].nombre,
          nombre: nombreController.text,
          tiempo: setDate.millisecondsSinceEpoch,
          unidad: unidadSeleccionada,
          notiId: Random().nextInt(10000000));

      //---------------------| Save as many medicines as many user checks |----------------------
      int func_formula = numeroVecesMedicina(int.parse(medicina.cadaNHoras!));
      int veces = cantidadSemanas * 7 * func_formula;
      int cifraEnMilisegundos = int.parse(medicina.cadaNHoras!) * 3600000;
      for (int i = 0; i < veces; i++) {
        dynamic result =
            await _repositorio.insertar("Medicina", medicina.medicinaToMap());
        if (result == null) {
          snackbar.showSnack("Algo va mal", _scaffoldKey, null);
          return;
        } else {
          //set the notification schneudele
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('America/Detroit'));
          await _notifications.mostrarNotificacion(medicina.nombre! , medicina.formaMedicina! + " - " + medicina.cantidad!+ " " + medicina.unidad! + " " + "(cada" + medicina.cadaNHoras! + "horas)" , time,
              medicina.notiId!,
              flutterLocalNotificationsPlugin);
          setDate = setDate.add(Duration(milliseconds: cifraEnMilisegundos));
          medicina.tiempo = setDate.millisecondsSinceEpoch;
          List<int> numberList=[];
          int aleatorio = Random().nextInt(10000000);
          if (!numberList.contains(aleatorio)){
            numberList.add(aleatorio);
            medicina.notiId = aleatorio;
          }
        }
      }
      //---------------------------------------------------------------------------------------



      //snackbar.showSnack("Guardado", _scaffoldKey, null);




      Navigator.pop(context);
    }
  }


  /*Mostrar selector de fecha y cambiar elegir fecha actual*/
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

    /*Click en el contenedor Forma Medicina*/
  void medicineTypeClick(TipoMedicina medicina) {
    setState(() {
      medicineTypes.forEach((medicineType) => medicineType.esElegido = false);
      medicineTypes[medicineTypes.indexOf(medicina)].esElegido = true;
    });
  }

   //obtener diferencia de tiempo
  int get time =>
    setDate.millisecondsSinceEpoch -
    tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;

  }
