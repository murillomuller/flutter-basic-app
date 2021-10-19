import 'package:basic_app/models/project.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'projects.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE projects('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'description TEXT)');
    }, version: 1);
  });
}

Future<int> saveProject(Project project) {
  return createDatabase().then((db) {
    final Map<String, dynamic> projectMap = {};
    projectMap['title'] = project.title;
    projectMap['description'] = project.description;
    return db.insert('projects', projectMap);
  });
}

Future<List<Project>> findAllProjects() {
  return createDatabase().then((db) {
    return db.query('projects').then((maps) {
      final List<Project> projects = [];
      for (Map<String, dynamic> map in maps) {
        final Project project = Project(
          id: map['id'],
          title: map['title'],
          description: map['description'],
        );
        projects.add(project);
      }
      return projects;
    });
  });
}
