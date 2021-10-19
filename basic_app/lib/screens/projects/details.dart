import 'package:flutter/material.dart';

const _titlePage = 'Detail Project';

class ProjectDetailsPage extends StatefulWidget {
  final int id;

  const ProjectDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titlePage),
      ),
      body: SingleChildScrollView(
        child: Text('Teste ${widget.id}'),
      ),
    );
  }
}
