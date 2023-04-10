


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

  // static final String isFavoriteColumn = "is_favorite";

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

  Future<Historic> update(Historic historic) async{
    Database db = await database;
    historic.id = await db.update(tableName,
      historic.toJson(),
      where: "$idColumn = ?",
      whereArgs: [historic.id]
    );
    return historic;
  }

  Future<int> delete(int id) async{
    Database db = await database;
    int idDeleted = await db.delete(tableName, where: "$idColumn = ?", whereArgs: [id]);
    return idDeleted;
  }

  Future<List<Historic>> list() async{
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery('SELECT * FROM $tableName');
    List<Historic> historic = maps?.map((element){
      return Historic.fromJson(element);
    })?.toList();

    return historic;
  }

  Future<Historic> findById(int id) async{
    Database db = await database;
    List<Map> maps = await db.query(tableName, 
      columns: [idColumn, nameColumn, dateColumn, typeColumn, actionColumn],
      where: '$idColumn = ?',
      whereArgs: [id]
    );

    if(maps.length > 0){
      return Historic.fromJson(maps.first);
    }else{
      return null;
    }
  }

  Future<void> close() async{
    Database db = await database;
    db.close();
  }



}