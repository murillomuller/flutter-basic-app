import 'package:basic_app/database/app_database.dart';
import 'package:basic_app/models/project.dart';
import 'package:flutter/material.dart';

const _titlePage = 'Add Project';

class FormAddPage extends StatefulWidget {
  const FormAddPage({Key? key}) : super(key: key);

  @override
  State<FormAddPage> createState() => _FormAddPageState();
}

class _FormAddPageState extends State<FormAddPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(_titlePage),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(height: 10),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                Container(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                Container(height: 10),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final String title = _titleController.text;
                      final String description = _descriptionController.text;
                      final Project newProject =
                          Project(title: title, description: description);
                      saveProject(newProject)
                          .then((id) => Navigator.pop(context));
                    },
                    child: const Text('Add Project'),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
