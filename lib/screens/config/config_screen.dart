import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_receiver_screen.dart';
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
  List<String> _buttonsName = new List(8);
  List<Commands> _commands = new List(8);
  Zones _zone;

  @override
  void initState() {
    super.initState();

    _zone = _bloc.zones[0];
    for (var index = 0; index < 8; index++) {
      _commands[index] = _bloc.commands[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    void _goToBonjour(Keypad keypad, int id) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BonjourReceiver(keypad, id)));
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

    void _shouldGoToBonjour(Keypad keypad, int id) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('KeyPads'),
              content:
                  Text('Your Keypad was saved! Now connect to a Receiver.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    _goToBonjour(keypad, id);
                  },
                ),
              ],
            );
          });
    }

    Future<void> _saveKeyPad() async {
      if (_keypad != null && _keypad.trim().length > 0) {
        List<Buttons> buttons = [];
        _buttonsName.asMap().entries.map((button) {
          buttons.add(new Buttons(
            button.key.toString(),
            button.value != null && button.value.trim().length > 0
                ? button.value
                : _bloc.buttons[button.key].name,
            'MainZone/index.put.asp?${_commands[button.key].command}&ZoneName=ZONE1',
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
            '',
            new Zones(
                _zone.zoneId,
                _zoneName != null && _zoneName.trim().length > 0
                    ? _zoneName
                    : _zone.name,
                buttons));
        int id = await _bloc.addKeyPad(newKeypad);
        _shouldGoToBonjour(newKeypad, id);
      } else {
        _errorAlert();
      }
    }

    void _saveZone(Zones newZone) {
      setState(() {
        _zone = newZone;
      });
    }

    void _saveCommand(index, Commands command) {
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
                child: DropdownButton<Commands>(
                  value: _commands[button.key],
                  onChanged: (Commands newCommand) {
                    _saveCommand(button.key, newCommand);
                  },
                  items: _bloc.commands
                      .map<DropdownMenuItem<Commands>>((Commands command) {
                    return DropdownMenuItem<Commands>(
                      value: command,
                      child: Text(command.name),
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
