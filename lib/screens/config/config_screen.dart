import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_screen.dart';
import 'package:automation/widgets/dropDown.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:automation/widgets/textField.dart';
import 'package:automation/widgets/title.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen();

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();
  String _keypad;
  String _zoneName;
  List<String> _buttonsName = new List(7);
  List<String> _commands = new List(7);
  Zones _zone;

  @override
  void initState() {
    super.initState();

    _zone = _bloc.zones[0];
    for (var index = 0; index < 7; index++) {
      _commands[index] = _bloc.commands[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    void _goToBonjour() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BonjourScreen()));
    }

    void _errorAlert() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('KeyPads'),
              content: Text('You must to edit the KeyPad name.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK.'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    void _shouldGoToBonjour() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('KeyPads'),
              content: Text(
                  'Do you want to send this configuration to a real KeyPad?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Not now.'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                FlatButton(
                  child: Text('Yes!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToBonjour();
                  },
                ),
              ],
            );
          });
    }

    void _saveKeyPad() {
      if (_keypad != null && _keypad.trim().length > 0) {
        List<Buttons> buttons = [];
        _buttonsName.asMap().entries.map((button) {
          buttons.add(new Buttons(
            button.key.toString(),
            button.value != null && button.value.trim().length > 0
                ? button.value
                : _bloc.buttons[button.key].name,
            _commands[button.key],
          ));
        }).toList();

        Keypad newKeypad = new Keypad(
            0,
            _keypad,
            '',
            '',
            '',
            '',
            '',
            new Zones(
                _zone.zoneId,
                _zoneName != null && _zoneName.trim().length > 0
                    ? _zoneName
                    : _zone.name,
                buttons));
        _bloc.addKeyPad(newKeypad);
        _shouldGoToBonjour();
      } else {
        _errorAlert();
      }
    }

    void _saveZone(Zones newZone) {
      setState(() {
        _zone = newZone;
      });
    }

    void _saveCommand(index, String command) {
      setState(() {
        _commands[index] = command;
      });
    }

    void _saveKeypadName(String name) {
      setState(() {
        _keypad = name;
      });
    }

    void _saveZoneName(String name) {
      setState(() {
        _zoneName = name;
      });
    }

    List<Row> renderButtons() {
      List<Row> rows = [];
      _bloc.buttons.asMap().entries.map((button) {
        rows.add(Row(
          children: <Widget>[
            Container(
              child: Text(
                '${button.value.name}:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 15.0, right: 5.0),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter Button Name'),
                onChanged: (value) {
                  setState(() {
                    _buttonsName[button.key] = value;
                  });
                },
              ),
            ),
            Container(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _commands[button.key],
                  onChanged: (String newCommand) {
                    _saveCommand(button.key, newCommand);
                  },
                  items: _bloc.commands
                      .map<DropdownMenuItem<String>>((String command) {
                    return DropdownMenuItem<String>(
                      value: command,
                      child: Text(command),
                    );
                  }).toList(),
                ),
              ),
              margin: EdgeInsets.only(left: 5.0),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
        ));
      }).toList();
      return rows;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Config KeyPad'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              title('KeyPad Name'),
              Container(
                child: textField('Enter KeyPad Name', _saveKeypadName),
                margin: EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              title('Zone Name'),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: textField('Enter Zone Name', _saveZoneName),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: dropDown(_bloc.zones, _saveZone),
                      ),
                      margin: EdgeInsets.only(left: 20.0),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                margin: EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              title('Buttons'),
              Container(
                child: Column(
                  children: renderButtons(),
                ),
                margin: EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              Container(
                child: primaryButton(context, 'Save', _saveKeyPad),
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              )
            ],
          ),
        ));
  }
}
