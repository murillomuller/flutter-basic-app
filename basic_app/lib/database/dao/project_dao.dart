import 'package:basic_app/database/app_database.dart';
import 'package:basic_app/models/project.dart';
import 'package:sqflite/sqlite_api.dart';

class ProjectDAO {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_title TEXT, '
      '$_description TEXT)';

  static const String _tableName = 'projects';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _description = 'description';

  Future<int> saveProject(Project project) async {
    final Database db = await createDatabase();
    Map<String, dynamic> projectMap = _toMap(project);
    return db.insert(_tableName, projectMap);
  }

  Future<List<Project>> findAllProjects() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    List<Project> projects = _toList(result);
    return projects;
  }

  Map<String, dynamic> _toMap(Project project) {
    final Map<String, dynamic> projectMap = {};

    projectMap[_title] = project.title;
    projectMap[_description] = project.description;
    return projectMap;
  }

  List<Project> _toList(List<Map<String, dynamic>> result) {
    final List<Project> projects = [];
    for (Map<String, dynamic> row in result) {
      final Project project = Project(
        id: row[_id],
        title: row[_title],
        description: row[_description],
      );
      projects.add(project);
    }
    return projects;
  }
}
