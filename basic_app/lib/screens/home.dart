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
  final List<Project> _entries = [
    Project(
      title: 'Receitinha',
      description: 'Projeto de Receitas',
    ),
    Project(
        title: 'Cartão Fidelidade',
        description: 'Projeto de Cartão Fidelidade'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(_titlePage),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final entry = _entries[index];
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(entry.title),
                    subtitle: Text(entry.description),
                  ),
                ],
              ),
            );
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
            ).then((newProject) => debugPrint(newProject.toString()));
          },
        ),
      ),
    );
  }
}
