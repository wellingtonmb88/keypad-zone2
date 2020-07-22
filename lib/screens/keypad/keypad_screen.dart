import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/edit/edit_screen.dart';
import 'package:automation/widgets/secondaryButton.dart';
import 'package:flutter/material.dart';
class KeypadScreen extends StatefulWidget {
  final Keypad keypad;

  KeypadScreen(this.keypad);

  @override
  _KeypadScreenState createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
  void _goToEdit(Keypad keypad) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditScreen(keypad)));

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Keypad _keypad = widget.keypad;
    List<Buttons> _buttons = widget.keypad.zone.buttons;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keypad.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _goToEdit(widget.keypad))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    secondaryButton(_buttons[0].name, _keypad.receiverIp, _buttons[0].command, _width, context),
                    secondaryButton(_buttons[1].name, _keypad.receiverIp, _buttons[1].command, _width, context),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    secondaryButton(_buttons[2].name, _keypad.receiverIp, _buttons[2].command, _width, context),
                    secondaryButton(_buttons[3].name, _keypad.receiverIp, _buttons[3].command, _width, context),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    secondaryButton(_buttons[4].name, _keypad.receiverIp, _buttons[4].command, _width, context),
                    secondaryButton(_buttons[5].name, _keypad.receiverIp, _buttons[5].command, _width, context),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    secondaryButton(_buttons[6].name, _keypad.receiverIp, _buttons[6].command, _width, context),
                    secondaryButton(_buttons[7].name, _keypad.receiverIp, _buttons[7].command, _width, context),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: _height * 0.2, right: 20, left: 20),
        ),
      ),
    );
  }
}
