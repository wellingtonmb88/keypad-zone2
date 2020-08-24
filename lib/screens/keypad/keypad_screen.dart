import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/edit/edit_screen.dart';
import 'package:automation/screens/config/config_screen.dart';
import 'package:automation/widgets/secondaryButton.dart';
import 'package:flutter/material.dart';

import '../../internationalization/app_localizations.dart';
import '../config/config_screen.dart';

class KeypadScreen extends StatefulWidget {
  final Keypad keypad;

  KeypadScreen(this.keypad);

  @override
  _KeypadScreenState createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    final keypadIp = widget.keypad.keypadIp.trim();
    final keypadMdns = widget.keypad.keypadMdns.trim();
    if (keypadIp.length > 5 && keypadMdns.length > 3) {
      _isButtonDisabled = false;
    } else {
      Future.delayed(Duration.zero, () => _showErrorMessage());
    }
  }

  void _showErrorMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).translate('not_configured_title')),
            content: Text(AppLocalizations.of(context).translate('not_configured_message')),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }

  void _goToEdit(Keypad keypad) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditScreen(keypad)));

  void _goToConfig(Keypad keypad) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => ConfigScreen(keypad)));

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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[0].name,
                          _keypad.receiverIp,
                          _buttons[0].command,
                          _width,
                          context),
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[1].name,
                          _keypad.receiverIp,
                          _buttons[1].command,
                          _width,
                          context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[2].name,
                          _keypad.receiverIp,
                          _buttons[2].command,
                          _width,
                          context),
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[3].name,
                          _keypad.receiverIp,
                          _buttons[3].command,
                          _width,
                          context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[4].name,
                          _keypad.receiverIp,
                          _buttons[4].command,
                          _width,
                          context),
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[5].name,
                          _keypad.receiverIp,
                          _buttons[5].command,
                          _width,
                          context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[6].name,
                          _keypad.receiverIp,
                          _buttons[6].command,
                          _width,
                          context),
                      secondaryButton(
                          _isButtonDisabled,
                          _buttons[7].name,
                          _keypad.receiverIp,
                          _buttons[7].command,
                          _width,
                          context),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  margin: EdgeInsets.only(top: 30),
                ),
                Container(
                  child: RaisedButton(
                    child: Text(
                      "Editar Keypad",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () => _goToConfig(widget.keypad),
                  ),
                  margin: EdgeInsets.only(top: 50),
                ),
              ],
            ),
            margin: EdgeInsets.only(top: _height * 0.2, right: 20, left: 20),
          ),
        ),
      ),
    );
  }
}
