import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BddMedicina{
  setBDD() async{
    /*Obtener la ubicación por medio de getDatabasesPath()*/
    String path  = join(await getDatabasesPath() ,"medicina_db.db");
    /*Abrir la base de datos con openDatabase*/
    Database database = await openDatabase(path ,version: 1,
      onCreate: (Database db,int version)async{
        /*Crear la tabla Medicina*/  
        await db.execute(
          "CREATE TABLE Medicina (id INTEGER PRIMARY KEY, nombre TEXT, cantidad TEXT, unidad TEXT, semanas INTEGER, cadaNHoras TEXT, formaMedicina TEXT, tiempo INTEGER, notiId INTEGER)"
        );
      }
    );
    return database;
  }
} 