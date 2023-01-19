
//import 'package:intl/intl.dart';


import 'package:intl/intl.dart';
import 'package:remember_medi/pantallas/inicio/funcion_formateo_dia.dart';

class CalendarioDiaModelo {
  String? diaLetra;
  int? diaNumero;
  int? mes;
  int? year;
  bool? isChecked;

  CalendarioDiaModelo({this.diaLetra, this.diaNumero, this.year, this.mes, this.isChecked});

  /*Obtener 7 días actuales*/
  List<CalendarioDiaModelo> obtenerDiaActual() {
    final List<CalendarioDiaModelo> daysList = [];
    DateTime tiempoActual = DateTime.now();
    for (int i = 0; i < 7; i++) {
      String diaIngles = DateFormat.EEEE().format(tiempoActual).toString();
      daysList.add(CalendarioDiaModelo(
          diaLetra: diaEspaniolFormateado(diaIngles),
          diaNumero: tiempoActual.day,
          mes:tiempoActual.month,
          year: tiempoActual.year,
          isChecked: false));
      tiempoActual = tiempoActual.add(Duration(days: 1));
    }
    daysList[0].isChecked = true;
    return daysList;
  }
  

}
