import 'package:basic_app/database/app_database.dart';
import 'package:basic_app/models/project.dart';
import 'package:basic_app/screens/projects/add.dart';
import 'package:flutter/material.dart';

const _titlePage = 'Projects Ideas';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(_titlePage),
        ),
        body: FutureBuilder<List<Project>>(
          initialData: const [],
          future: Future.delayed(const Duration(milliseconds: 200))
              .then((value) => findAllProjects()),
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
                      return _ProjectItem(project);
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
            title: Text(project.title),
            subtitle: Text(project.description),
          ),
        ],
      ),
    );
  }
}
