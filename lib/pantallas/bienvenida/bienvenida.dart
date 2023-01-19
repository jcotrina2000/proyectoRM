import 'package:flutter/material.dart';
import 'package:remember_medi/funcion_color_hex/hexadecimal.dart';
import 'package:remember_medi/pantallas/bienvenida/mensajes.dart';

class Bienvenida extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    void goToHomeScreen() => Navigator.pushReplacementNamed(context, "/inicio");
    
    return Scaffold(
      backgroundColor: '#85C1E9'.toColor(),
      body: SafeArea(
        //padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.08,
            ),
            Text(
              "RememberMedi",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 64, 
                fontFamily: "Angel",
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.01,
            ),
            Image.asset('assets/images/img_bienvenida.png',
              width: double.infinity, height: deviceHeight * 0.4),
            SizedBox(
              height: deviceHeight * 0.01,
            ),
            Mensaje(deviceHeight),
            Container(
              height: deviceHeight * 0.07,
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: '52BE80'.toColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        "Empezamos",
                        style: Theme.of(context)
                            .textTheme
                            .headline3?.copyWith(color: Colors.white),
                      ),
                    ), onPressed: goToHomeScreen,
                  )),
            ),
          ],
        )
      )
    );
    
  }

}