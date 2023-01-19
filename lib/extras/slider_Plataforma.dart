import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SliderPlataforma extends StatelessWidget {
  final int min, max, divisiones, valor;
  final Function handler;
  final Color color;

  SliderPlataforma(
      {required this.valor,
      required this.handler,
      required this.color,
      required this.max,
      required this.min,
      required this.divisiones});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSlider(
            onChanged: (value) => this.handler(value),
            max: this.max.toDouble(),
            min: this.min.toDouble(),
            divisions: this.divisiones,
            activeColor: Theme.of(context).primaryColor,
            value: this.valor.toDouble(),
          )
        : Slider(
            value: this.valor.toDouble(),
            onChanged: (value) => this.handler(value),
            max: this.max.toDouble(),
            min: this.min.toDouble(),
            divisions: this.divisiones,
            activeColor: this.color,
          );
  }
}
