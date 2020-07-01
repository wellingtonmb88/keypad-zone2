import 'package:automation/bloc/zones_bloc.dart';
import 'package:automation/objects/keypad.dart';
import 'package:automation/screens/zones_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  final KeyPad keypad;
  final String errorMessage;

  HomeWidget({this.keypad, this.errorMessage});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _zone;

  @override
  void initState() {
    _zone = 'Select a zone';

    super.initState();
  }

  List<Widget> _getCards() {
    List<Zones> zones = [];
    List<Widget> items = [];

    if (widget.keypad != null) {
      widget.keypad.zones.map((zone) => zones.add(zone)).toList();
    }

    zones
        .map((zone) => {
              if (zone.zoneName == _zone)
                {
                  items.add(Card(
                    child: Container(
                      child: Text(
                        'Zone: ' + zone.zoneName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                    color: Colors.blue,
                  )),
                  zone.sources
                      .map((source) => {
                            items.add(RaisedButton(
                              onPressed: () {},
                              child: Text(source.sourceName),
                              color: Colors.blue,
                              textColor: Colors.white,
                            ))
                          })
                      .toList()
                }
            })
        .toList();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<ZonesBloc>(context);

    void _getZones() {
      final sourcesEvent = SourcesEvent(zone: _zone);
      bloc.add(sourcesEvent);
    }

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ZonesScreen(zones: widget.keypad.zones)));
              },
              child: Text('CONFIG'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            alignment: Alignment.topRight,
          ),
          DropdownButton(
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            iconEnabledColor: Colors.blue,
            iconSize: 35,
            value: _zone,
            items: <String>['Select a zone', 'Main', 'Quarto 1', 'Quarto 2']
                .map((String zone) {
              return DropdownMenuItem(
                value: zone,
                child: Text(zone),
                onTap: () {
                  setState(() {
                    _zone = zone;
                  });
                  if (zone != 'Select a zone') _getZones();
                },
              );
            }).toList(),
            onChanged: (value) => null,
          ),
          widget.errorMessage == null ? Text('') : Text(widget.errorMessage),
          Container(
            child: Column(
              children: _getCards(),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  color: Colors.blue,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  color: Colors.blue,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 50, right: 50),
          )
        ],
      ),
      padding: const EdgeInsets.all(12),
    );
  }
}
