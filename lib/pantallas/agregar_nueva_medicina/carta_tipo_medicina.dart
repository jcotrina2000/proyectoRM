import 'package:flutter/material.dart';
import 'package:remember_medi/modelos/tipo_medicina.dart';


class CardTipoMedicina extends StatelessWidget {
  final TipoMedicina tipoMedi;
  final Function handler;
  CardTipoMedicina(this.tipoMedi,this.handler);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handler(tipoMedi),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            color: tipoMedi.esElegido ? Color.fromRGBO(7, 190, 200, 1) :Colors.white,
            ),
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.0,),
                Container(width:40,height: 50.0,child: tipoMedi.imagen),
                SizedBox(height: 7.0,),
                Container(child: Text(tipoMedi.nombre,style: TextStyle(
                  color:tipoMedi.esElegido ? Colors.white : Colors.black,fontWeight: FontWeight.w500
                ),)),
              ],
            ),

          ),
        ),
        SizedBox(width: 15.0,)
      ],
    );
  }
}