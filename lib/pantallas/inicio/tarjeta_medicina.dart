import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:remember_medi/bdd/repositorio.dart';
import 'package:remember_medi/modelos/medicina.dart';
import 'package:remember_medi/notificaciones/notificaciones.dart';
import 'package:remember_medi/funcion_color_hex/hexadecimal.dart';


class MedicineCard extends StatelessWidget {

  final Medicina medicine;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  MedicineCard(this.medicine,this.setData,this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    /*Verificar si el tiempo de medicina es menor que el actual*/
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicine.tiempo!;

    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Colors.white,
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onLongPress: () =>
                _showDeleteDialog(context, medicine.nombre!, medicine.id!, medicine.notiId!),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              medicine.nombre!,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${medicine.cantidad} ${medicine.unidad} - ${medicine.formaMedicina}",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicine.tiempo!)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(
                      medicine.image
                    )),
              ),
            )));
  }


  /*Mostrar cuadro de diálogo de eliminar medicina*/

  void _showDeleteDialog(BuildContext context, String nombreMedicina, int idMedicina, int notiId) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Eliminar ?"),
              content: Text("Estás seguro de eliminar la medicina $nombreMedicina ?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                ElevatedButton(
                  style: (ElevatedButton.styleFrom(primary: '#85C1E9'.toColor(),)),
                  //splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: '#FFFFFF'.toColor()),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: (ElevatedButton.styleFrom(primary: '#85C1E9'.toColor(),)),
                  //splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text("Eliminar",
                      style: TextStyle(color: '#FFFFFF'.toColor())),
                  onPressed: () async {
                    await Repositorio().deleteData("Medicina", idMedicina);
                    await Notificaciones().eliminarNotificacion(notiId, flutterLocalNotificationsPlugin);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }


}