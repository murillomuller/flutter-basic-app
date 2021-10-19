import 'package:basic_app/database/dao/project_dao.dart';
import 'package:basic_app/models/project.dart';
import 'package:basic_app/screens/projects/add.dart';
import 'package:basic_app/screens/projects/details.dart';
import 'package:flutter/material.dart';

const _titlePage = 'Projects Ideas';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ProjectDAO _projectDAO = ProjectDAO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titlePage),
      ),
      body: FutureBuilder<List<Project>>(
        initialData: const [],
        future: _projectDAO.findAllProjects(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Project> projects = snapshot.data as List<Project>;
              if (projects.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Dismissible(
                      key: Key(project.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {});
                        _projectDAO
                            .deleteProject(project.id)
                            .then((id) => null);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Project "${project.title}" deleted successfully!')));
                      },
                      background: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const <Widget>[
                            Text(
                              'Delete Project',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      child: _ProjectItem(project),
                    );
                  },
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      'No projects found!\nPlease add at least one project.',
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 2),
                    ),
                  ],
                ),
              );
          }
          return const Text('Error: Unknown');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const FormAddPage();
            }),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}

class _ProjectItem extends StatelessWidget {
  final Project project;
  const _ProjectItem(this.project);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: () {
              _showProjectDetails(context, project.id);
            },
            title: Text(project.title),
            subtitle: Text(project.description),
          ),
        ],
      ),
    );
  }
}

void _showProjectDetails(BuildContext context, int id) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ProjectDetailsPage(id: id),
    ),
  );
}
