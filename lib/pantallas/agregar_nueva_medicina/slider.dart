
import 'package:flutter/material.dart';
import 'package:remember_medi/extras/slider_Plataforma.dart';

class UserSlider extends StatelessWidget {
  final Function handler;
  final int semanas;
  UserSlider(this.handler,this.semanas);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: SliderPlataforma(
              divisiones: 11,
              min: 1,
              max: 12,
              valor: semanas,
              color: Theme.of(context).primaryColor,
              handler:  this.handler,)),
      ],
    );
  }
}