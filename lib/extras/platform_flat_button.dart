import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformFlatButton extends StatelessWidget {
  final VoidCallback handler;
  final Widget botonHijo;
  final Color color;

  PlatformFlatButton({required this.botonHijo, required this.color, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: this.botonHijo,
            color: this.color,
            onPressed: this.handler,
            borderRadius: BorderRadius.circular(15.0),
          )
        : MaterialButton (
            color: this.color,
            child: this.botonHijo,
            onPressed: this.handler,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
  }
}