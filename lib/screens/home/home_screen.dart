import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/config/config_screen.dart';
import 'package:flutter/material.dart';
import 'home_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  List<Keypad> keypads = [];
  Keypad keypad;
  Zones zone;
  Sources source;

  @override
  void initState() {
    super.initState();

    keypads.addAll(bloc.keypads);
    keypad = keypads.length > 0 ? keypads[0] : null;
    zone = keypad != null && keypad.zones.length > 0 ? keypad.zones[0] : null;
    source = zone != null && zone.sources.length > 0 ? zone.sources[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          'Add KeyPad',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    ButtonTheme(
                        minWidth: 150,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ConfigScreen(keypads)));
                          },
                          child: Text(
                            'Config KeyPad',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        ))
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 8.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: keypads.length > 0
                              ? Text('Select a KeyPad')
                              : Text('No KeyPads added.'),
                          alignment: Alignment.center,
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
                                  items: keypads.map<DropdownMenuItem<Keypad>>(
                                      (Keypad keypad) {
                                    return DropdownMenuItem<Keypad>(
                                      value: keypad,
                                      child: Text(keypad.name),
                                    );
                                  }).toList(),
                                )
                              : Text('Add one KeyPad first.'),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: keypad != null && keypad.zones.length > 0
                              ? Text('Select a Zone')
                              : Text('No Zones added.'),
                          alignment: Alignment.center,
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
                                        .map<DropdownMenuItem<Zones>>(
                                            (Zones zone) {
                                      return DropdownMenuItem<Zones>(
                                        value: zone,
                                        child: Text(zone.zoneName),
                                      );
                                    }).toList(),
                                  )
                                : Text('Add one Zone first.'))
                      ],
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                margin: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: zone != null && zone.sources.length > 0
                    ? Column(
                        children: zone.sources.map((Sources source) {
                          return ButtonTheme(
                            minWidth: double.infinity,
                            child: RaisedButton(
                              child: Text(
                                source.sourceName,
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                              onPressed: () {
                                bloc.buttonPressed(keypad, zone, source);
                              },
                            ),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: <Widget>[
                          Text('No Sources added.'),
                          Text('Add one Source first.')
                        ],
                      ),
                margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              )
            ],
          )),
        ));
  }
}
