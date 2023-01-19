import 'package:flutter/material.dart';
import '../../modelos/calendario_dia_modelo.dart';
import '../../pantallas/inicio/calendario_dia.dart';

class Calendario extends StatefulWidget {
  final Function chooseDay;
  final List<CalendarioDiaModelo> _daysList;
  Calendario(this.chooseDay,this._daysList);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendario> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: deviceHeight * 0.11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [...widget._daysList.map((day) => CalendarDay(day, widget.chooseDay))],
      ),
    );
  }

}
