import 'package:automation/models/keypad_model.dart';
import 'package:flutter/material.dart';
import 'config_bloc.dart';

class ConfigScreen extends StatefulWidget {
  List<Keypad> keypads;

  ConfigScreen(this.keypads);

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  ConfigBloc bloc = ConfigBloc();
  List<Keypad> keypads;
  Keypad keypad;
  Zones zone;
  Sources source;
  String zoneName;
  String sourceName;
  String commandName;

  @override
  void initState() {
    super.initState();

    keypads = widget.keypads;
    keypad = keypads.length > 0 ? keypads[0] : null;
    zone = keypad != null && keypad.zones.length > 0 ? keypad.zones[0] : null;
    source = zone != null && zone.sources.length > 0 ? zone.sources[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Config KeyPad'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: keypads.length > 0
                    ? Text('Select a KeyPad')
                    : Text('No KeyPads added.'),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                  child: keypads.length > 0
                      ? DropdownButton<Keypad>(
                          value: keypad,
                          onChanged: (Keypad newKeypad) {
                            setState(() {
                              keypad = newKeypad;
                              zone = newKeypad.zones.length > 0
                                  ? newKeypad.zones[0]
                                  : null;
                            });
                          },
                          items: keypads
                              .map<DropdownMenuItem<Keypad>>((Keypad keypad) {
                            return DropdownMenuItem<Keypad>(
                              value: keypad,
                              child: Text(keypad.name),
                            );
                          }).toList(),
                        )
                      : Text('Add one KeyPad first.')),
              Container(
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Zone Name'),
                    onChanged: (value) {
                      setState(() {
                        zoneName = value;
                      });
                    },
                  ),
                ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: RaisedButton(
                  child: Text(
                    'Add Zone',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    bloc.addZone(keypad, zoneName);
                  },
                ),
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                width: double.infinity,
              ),
              Container(
                child: keypad != null && keypad.zones.length > 0
                    ? Text('Select a Zone')
                    : Text('No Zones added.'),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40.0),
              ),
              Container(
                  child: keypad != null && keypad.zones.length > 0
                      ? DropdownButton<Zones>(
                          value: zone,
                          onChanged: (Zones newZone) {
                            setState(() {
                              zone = newZone;
                            });
                          },
                          items: keypad.zones
                              .map<DropdownMenuItem<Zones>>((Zones zone) {
                            return DropdownMenuItem<Zones>(
                              value: zone,
                              child: Text(zone.zoneName),
                            );
                          }).toList(),
                        )
                      : Text('Add one Zone first.')),
              Container(
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Enter Source Name'),
                    onChanged: (value) {
                      setState(() {
                        sourceName = value;
                      });
                    },
                  ),
                ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    bloc.addSource(keypad, zone, sourceName);
                  },
                  child: Text(
                    'Add Source',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                width: double.infinity,
              ),
              Container(
                child: zone != null && zone.sources.length > 0
                    ? Text('Select a Source')
                    : Text('No Sources added.'),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40.0),
              ),
              Container(
                  child: zone != null && zone.sources.length > 0
                      ? DropdownButton<Sources>(
                          value: source,
                          onChanged: (Sources newSource) {
                            setState(() {
                              source = newSource;
                            });
                          },
                          items: zone.sources
                              .map<DropdownMenuItem<Sources>>((Sources source) {
                            return DropdownMenuItem<Sources>(
                              value: source,
                              child: Text(source.sourceName),
                            );
                          }).toList(),
                        )
                      : Text('Add one Source first.')),
              Container(
                child: Center(
                  child: TextField(
                    decoration:
                        InputDecoration(labelText: 'Enter Command Name'),
                    onChanged: (value) {
                      setState(() {
                        commandName = value;
                      });
                    },
                  ),
                ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: RaisedButton(
                  child: Text(
                    'Add Command',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    bloc.addCommand(keypad, zone, source, commandName);
                  },
                ),
                margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                width: double.infinity,
              ),
            ],
          ),
        ));
  }
}
