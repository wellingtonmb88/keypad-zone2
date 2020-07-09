import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen();

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String keypad;
  Zones zone;
  Buttons button;
  Commands command;

  @override
  void initState() {
    super.initState();

    keypad = null;
    zone = null;
    button = null;
    command = null;
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc bloc = BlocProvider.getBloc<AppBloc>();

    return Scaffold(
        appBar: AppBar(
          title: Text('Config KeyPad'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: Text(
                    'KeyPad Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 50.0)),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Enter KeyPad Name'),
                  onChanged: (value) {
                    setState(() {
                      keypad = value;
                    });
                  },
                ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: Text('Zone Name',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Zone Name'),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Zones>(
                          value: bloc.zones[0],
                          onChanged: (Zones newZone) {
                            setState(() {
                              zone = newZone;
                            });
                          },
                          items: bloc.zones
                              .map<DropdownMenuItem<Zones>>((Zones zone) {
                            return DropdownMenuItem<Zones>(
                              value: zone,
                              child: Text(zone.zoneName),
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
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: Text('Button Name',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Button Name'),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Buttons>(
                          value: bloc.buttons[0],
                          onChanged: (Buttons newButton) {
                            setState(() {
                              button = newButton;
                            });
                          },
                          items: bloc.buttons
                              .map<DropdownMenuItem<Buttons>>((Buttons button) {
                            return DropdownMenuItem<Buttons>(
                              value: button,
                              child: Text(button.buttonName),
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
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: Text('Select Command to Button',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 60.0),
              ),
              Container(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Commands>(
                    value: bloc.commands[0],
                    onChanged: (Commands newCommand) {
                      setState(() {
                        command = newCommand;
                      });
                    },
                    items: bloc.commands
                        .map<DropdownMenuItem<Commands>>((Commands command) {
                      return DropdownMenuItem<Commands>(
                        value: command,
                        child: Text(command.command),
                      );
                    }).toList(),
                  ),
                ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: RaisedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Keypad test = new Keypad('1', keypad, [
                      new Zones(zone.zoneId, zone.zoneName, [
                        new Buttons(button.buttonId, button.buttonName,
                            [new Commands(command.command)])
                      ])
                    ]);
                    bloc.addKeyPad(test);
                  },
                ),
                width: double.infinity,
                margin: EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
              )
            ],
          ),
        ));
  }
}
