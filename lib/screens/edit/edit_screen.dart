import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  EditScreen();

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit KeyPads'),
      ),
      body: Container(
        child: Center(
          child: Text('Screen to edit KeyPads'),
        ),
      ),
    );
  }
}
