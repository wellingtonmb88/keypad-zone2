import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/internationalization/app_localizations.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_receiver_screen.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:automation/widgets/textField.dart';
import 'package:automation/widgets/title.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  final Keypad keypad;

  ConfigScreen([this.keypad]);

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
  String _originalZoneName = 'ZONE1';

  @override
  void initState() {
    super.initState();

    if (widget.keypad != null) {
      _keypad = widget.keypad.name;
      _zoneName = widget.keypad.zone.name;
      for (var index = 0; index < 8; index++) {
        _buttonsName[index] = widget.keypad.zone.buttons[index].name;
      }
    }

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
              title: Text('Keypads'),
              content:
                  Text(AppLocalizations.of(context).translate('config_error')),
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
      if (widget.keypad != null) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Keypads'),
                content: Text(
                    AppLocalizations.of(context).translate('change_keypad')),
                actions: <Widget>[
                  FlatButton(
                    child: Text(AppLocalizations.of(context).translate('yes')),
                    onPressed: () {
                      _goToBonjour(keypad, id);
                    },
                  ),
                  FlatButton(
                    child: Text(AppLocalizations.of(context).translate('not_now')),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ],
              );
            });
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Keypads'),
                content: Text(
                    AppLocalizations.of(context).translate('confirm_config')),
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
            'MainZone/index.put.asp?${_commands[button.key].command}&ZoneName=$_originalZoneName',
          ));
        }).toList();

        Keypad newKeypad = new Keypad(
            0,
            _keypad,
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

        if (widget.keypad != null) {
          newKeypad.id = widget.keypad.id;
          newKeypad.keypadIp = widget.keypad.keypadIp;
          newKeypad.receiverIp = widget.keypad.receiverIp;
          newKeypad.keypadMdns = widget.keypad.keypadMdns;
          newKeypad.receiverMdns = widget.keypad.receiverMdns;
          _bloc.changeKeypad(newKeypad);
          _shouldGoToBonjour(newKeypad, newKeypad.id);
        } else {
          int id = await _bloc.addKeyPad(newKeypad);
          newKeypad.id = id;
          _shouldGoToBonjour(newKeypad, id);
        }
      } else {
        _errorAlert();
      }
    }

    void _saveZone(Zones newZone) {
      if (newZone.name == 'MAIN') {
        setState(() {
          _zone = newZone;
          _originalZoneName = 'ZONE1';
        });
      } else {
        setState(() {
          _zone = newZone;
          _originalZoneName = newZone.name;
        });
      }
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
                    border: InputBorder.none,
                    hintText: widget.keypad != null
                        ? _buttonsName[button.key]
                        : AppLocalizations.of(context)
                            .translate('button_input')),
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
          title: Text('Config Keypad'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              title(AppLocalizations.of(context).translate('keypad_name')),
              Container(
                child: textField(
                    widget.keypad != null
                        ? _keypad
                        : AppLocalizations.of(context)
                            .translate('keypad_input'),
                    _saveKeypadName),
                margin: EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              title(AppLocalizations.of(context).translate('zone_name')),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: textField(
                          widget.keypad != null
                              ? _zoneName
                              : AppLocalizations.of(context)
                                  .translate('zone_input'),
                          _saveZoneName),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _zone,
                          onChanged: (value) => _saveZone(value),
                          items:
                              _bloc.zones.map<DropdownMenuItem>((Zones zone) {
                            return DropdownMenuItem(
                              value: zone,
                              child: Text(zone.name),
                            );
                          }).toList(),
                        ),
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
              title(AppLocalizations.of(context).translate('button_name')),
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
                child: StreamBuilder(
                  stream: _bloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: primaryButton(
                    AppLocalizations.of(context).translate('save_config'),
                    _saveKeyPad,
                    false),
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              )
            ],
          ),
        ));
  }
}
