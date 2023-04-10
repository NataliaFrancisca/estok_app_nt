import 'package:estok_app_natalia_francisca/repository/local/historic_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InitDB {

  static Future<Database> initDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'historic_db');

    return openDatabase(path, version: 1,
      onCreate: (Database database, int version) async{
        await database.execute(
          'CREATE TABLE ${HistoricRepository.tableName} ('
            '${HistoricRepository.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, '
            '${HistoricRepository.nameColumn} TEXT, '
            '${HistoricRepository.dateColumn} TEXT, '
            '${HistoricRepository.typeColumn} TEXT, '
            '${HistoricRepository.actionColumn} TEXT '
          ')'
        );
      }
    );
  }
}