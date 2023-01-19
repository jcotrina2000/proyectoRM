import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificaciones{
  late BuildContext _context;

  Future<FlutterLocalNotificationsPlugin> inicializarNotificaciones(BuildContext context) async{
    this._context = context;
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    return flutterLocalNotificationsPlugin;
    
  }

  /*Mostrar la notificación en un momento específico*/

  Future mostrarNotificacion(String title, String description, int time, int id, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.toInt(),
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: time)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'id_medicina', 
                'medicina', 
                channelDescription: 'canal_notificacion_medicina',
                importance: Importance.high,
                priority: Priority.high,
                enableVibration: true,
                playSound: true,
                color: Colors.cyanAccent,
                //sound: RawResourceAndroidNotificationSound('spidy') //const UriAndroidNotificationSound("assets/tunes/spidy.mp3"),
                //icon: '@mipmap/ic_launcher'
            )
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  /*Cancelar una notificación*/
  Future eliminarNotificacion(int notifyId, FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    try{
      return await flutterLocalNotificationsPlugin.cancel(notifyId);
    }catch(e){
      return null;
    }
  }

  /*Funcion para inicializar notificación*/

  Future onSelectNotification(String? payload) async {
    showDialog(
      context: _context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}
