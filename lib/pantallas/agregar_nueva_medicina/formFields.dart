import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remember_medi/pantallas/agregar_nueva_medicina/slider.dart';


class FormFields extends StatelessWidget {
  final List<String> valoresUnidades = ["pildoras", "ml", "mg"];
  final int semanas;
  final String unidadSeleccionada;
  final Function onPopUpMenuChanged, onSliderChanged;
  final TextEditingController nombreController;
  final TextEditingController cantidadController;
  final TextEditingController numeroHorasController;
  FormFields(this.semanas,this.unidadSeleccionada,this.onPopUpMenuChanged,this.onSliderChanged,this.nombreController,this.cantidadController, this.numeroHorasController);

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return LayoutBuilder(
      builder:(context,constrains)=> Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: constrains.maxHeight * 0.19,  
            width: constrains.maxWidth * 1,
            child: TextField(
              textInputAction: TextInputAction.next,
              controller: nombreController,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  labelText: "Nombre medicina",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      BorderSide(width: 0.5, color: Colors.black))),
              onSubmitted: (val)=>focus.nextFocus(),
            ),
          ),
          SizedBox(
              height: constrains.maxHeight * 0.07,
          ),
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  height: constrains.maxHeight * 0.19,
                  width: constrains.maxWidth * 0.7,
                  child: TextField(
                    controller: cantidadController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        labelText: "Cantidad de medicinas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.grey))),
                    onSubmitted: (val)=>focus.unfocus(),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: constrains.maxHeight * 0.19,
                  width: constrains.maxWidth * 0.35,
                  child: DropdownButtonFormField(
                    onTap: ()=>focus.unfocus(),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        labelText: "Tipo",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.4, color: Colors.grey))),
                    items: valoresUnidades
                        .map((weight) => DropdownMenuItem(
                      child: Text(weight),
                      value: weight,
                    ))
                        .toList(),
                    onChanged: (value) => this.onPopUpMenuChanged(value),
                    value: unidadSeleccionada,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
          Container(
            height: constrains.maxHeight * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: FittedBox(
                child: Text(
                  "Duración semanas",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Container(
            height: constrains.maxHeight * 0.08,
            child: UserSlider(this.onSliderChanged,this.semanas)
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FittedBox(child: Text('$semanas semanas')),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.07,
          ),
          Row(
            children: [
              Text("Tomar cada"),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: constrains.maxHeight * 0.15,
                  width: constrains.maxWidth * 0.7,
                  child: TextField(
                    controller: numeroHorasController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        labelText: "Número horas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 0.5, color: Colors.grey))),
                    onSubmitted: (val)=>focus.unfocus(),               
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("horas!"),
            ],
          ),
        ],
      ),
    );
  }
}