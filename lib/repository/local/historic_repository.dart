


import 'dart:async';

import 'package:estok_app_natalia_francisca/entities/historic.dart';
import 'package:estok_app_natalia_francisca/repository/local/database/init_bd.dart';
import 'package:sqflite/sqflite.dart';

class HistoricRepository{

  static final String tableName = "historic_tb";
  static final String idColumn = "id";
  static final String nameColumn = "name";
  static final String dateColumn = "date";
  static final String typeColumn = "type";
  static final String actionColumn = "action";

  static final HistoricRepository instance = HistoricRepository._();
  HistoricRepository._();

  Database _database;

  Future<Database> get database async{
    if(_database == null){
      _database = await InitDB.initDatabase();
    }

    return _database;
  }

  Future<Historic> save(Historic historic) async{
    Database db = await database;
    historic.id = await db.insert(tableName, historic.toJson());
    return historic;
  }

  Future<void> delete() async{
    Database db = await database;
    await db.delete(tableName);
  }

  Future<List<Historic>> list() async{
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM $tableName');
    List<Historic> historic = maps?.map((element){
      return Historic.fromJson(element);
    })?.toList();

    return historic;
  }

  Future<int> length() async{
    Database db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  Future<void> close() async{
    Database db = await database;
    db.close();
  }

}