import 'package:sqflite/sqflite.dart';

class Dbhelper{
  static Database? _db;
  static final int _version =1;
  static final String _tableName = "appointments";

  static Future<void> initDb() async{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'appointments.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db,version){
          print("New Database");
          return db.execute(
             " CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING, name STRING, date STRING, "
                "startTime STRING, endTime STRING,"
                "remind INTEGER, color INTEGER,"
                "isCompleted INTEGER)",
              );
        },
      );
    } catch(e){
      print(e);
    }
  }


// static Future<int> insert(Appointment? appointment) async{
//   print("Insert Function");
//   return await _db?.insert(_tableName, appointment!.toJson())??1;
// }

static Future<List<Map<String, dynamic>>> query() async{
  print("Query Called");
  return await _db!.query(_tableName);
}

// static delete(Appointment appointment) async{
//  return await _db!.delete(_tableName, where:'id', whereArgs: [appointment.id]);
// }

static update(int id) async{
  return await _db!.rawUpdate('''
        UPDATE appointments 
        SET isCompleted = ?
        WHERE id = ?

  ''',[1,id]);
}

}