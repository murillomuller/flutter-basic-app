import 'package:basic_app/models/project.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'projects.db');

  return openDatabase(path, onCreate: (db, version) {
    db.execute('CREATE TABLE projects('
        'id INTEGER PRIMARY KEY, '
        'title TEXT, '
        'description TEXT)');
  }, version: 1);
}

Future<int> saveProject(Project project) async {
  final Database db = await createDatabase();
  final Map<String, dynamic> projectMap = {};

  projectMap['title'] = project.title;
  projectMap['description'] = project.description;
  return db.insert('projects', projectMap);
}

Future<List<Project>> findAllProjects() async {
  final Database db = await createDatabase();
  final List<Map<String, dynamic>> result = await db.query('projects');

  final List<Project> projects = [];
  for (Map<String, dynamic> row in result) {
    final Project project = Project(
      id: row['id'],
      title: row['title'],
      description: row['description'],
    );
    projects.add(project);
  }
  return projects;
}
