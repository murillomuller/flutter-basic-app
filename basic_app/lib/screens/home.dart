import 'package:basic_app/screens/form_add.dart';
import 'package:flutter/material.dart';

const _titlePage = 'Home Page';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _entries = ['10:00', '13:00', '18:00', '22:00'];

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
                    leading: Icon(Icons.access_alarms_rounded),
                    title: Text(entry),
                    subtitle: Text('Acordar.'),
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
                return const FormAddPage(
                  title: 'Add Timer',
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
