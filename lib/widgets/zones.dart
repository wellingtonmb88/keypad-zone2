import 'package:automation/objects/keypad.dart';
import 'package:flutter/material.dart';

class ZonesWidget extends StatefulWidget {
  final List<Zones> zones;

  ZonesWidget({this.zones});

  @override
  _ZonesWidgetState createState() => _ZonesWidgetState();
}

class _ZonesWidgetState extends State<ZonesWidget> {
  String _zone;

  @override
  void initState() {
    _zone = widget.zones[0].zoneName;

    super.initState();
  }

  List<Widget> _getSources() {
    List<Widget> items = [];

    widget.zones
        .map((zone) => {
              if (zone.zoneName == _zone)
                {
                  zone.sources
                      .map((source) => {
                            items.add(Card(
                              child: Container(
                                child: Text(
                                  source.sourceName,
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
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 5.0)),
                hintText: 'Enter zone name'),
          ),
          Container(
            child: DropdownButton(
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              iconEnabledColor: Colors.blue,
              iconSize: 35,
              value: _zone,
              items: widget.zones.map((zone) {
                return DropdownMenuItem(
                  value: zone.zoneName,
                  child: Text(zone.zoneName),
                  onTap: () {
                    setState(() {
                      _zone = (zone.zoneName);
                    });
                  },
                );
              }).toList(),
              onChanged: (value) => null,
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          Container(
            child: Column(
              children: _getSources(),
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(12),
    );
  }
}
