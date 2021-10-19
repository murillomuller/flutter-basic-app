import 'package:flutter/material.dart';

class FormAddPage extends StatefulWidget {
  const FormAddPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FormAddPage> createState() => _FormAddPageState();
}

class _FormAddPageState extends State<FormAddPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Timer',
              ),
            )
          ],
        ),
      ),
    );
  }
}
