import 'package:basic_app/database/dao/project_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'projects.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute(ProjectDAO.tableSql);
  }, version: 1);
}
