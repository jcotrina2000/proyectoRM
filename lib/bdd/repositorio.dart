import 'package:remember_medi/bdd/bdd_medicina.dart';
import 'package:sqflite/sqflite.dart';

class Repositorio{
  BddMedicina _bddMedicina = BddMedicina();
  static Database? _database;
  
  /*Inicializar base de datos*/
  Future<Database> get database async =>
    _database??=await _bddMedicina.setBDD();
  
  /*Insertar en la base*/
  Future<int?> insertar(String nombreTabla, Map<String,dynamic> datos) async{
    Database db = await database;
    try{
      return await db.insert(nombreTabla, datos);
    }catch(e){
      return null;
    }
  }

  /*Obtener todos los datos de la base*/
  Future<List<Map<String,dynamic>>?> obtenerDatos(String nombreTabla) async{
    Database db = await database;
    try{
      return db.query(nombreTabla);
    }catch(e){
      return null;
    }
  }

  /*Eliminar datos de la base*/
  Future<int?> deleteData(String nombreTabla,int id) async{
    Database db = await database;
    try{
      return await db.delete(nombreTabla, where: "id = ?", whereArgs: [id]);
    }catch(e){
      return null;
    }
  }

}