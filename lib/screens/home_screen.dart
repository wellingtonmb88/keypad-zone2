import 'package:automation/objects/keypad.dart';
import 'package:flutter/material.dart';
import 'package:automation/widgets/home.dart';

class HomeScreen extends StatefulWidget {
  final KeyPad keypad;
  final String errorMessage;

  HomeScreen({this.keypad, this.errorMessage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: HomeWidget(keypad: widget.keypad, errorMessage: widget.errorMessage));
  }
}
