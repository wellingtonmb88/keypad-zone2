import 'package:automation/objects/keypad.dart';
import 'package:automation/widgets/zones.dart';
import 'package:flutter/material.dart';

class ZonesScreen extends StatefulWidget {
  final List<Zones> zones;

  ZonesScreen({this.zones});

  @override
  _ZonesScreenState createState() => _ZonesScreenState();
}

class _ZonesScreenState extends State<ZonesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Config Zones'),
      ),
      body: ZonesWidget(zones: widget.zones),
    );
  }
}
