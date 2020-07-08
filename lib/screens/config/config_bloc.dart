import 'dart:async';

import 'package:automation/models/keypad_model.dart';

class ConfigBloc {
  final StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void addZone(Keypad keypad, String zoneName) {
    // Add zone to keypad
    print('Zone $zoneName added to KeyPad ${keypad.name}');
  }

  void addSource(Keypad keypad, Zones zone, String sourceName) {
    // Add source to zone
    print(
        'Source $sourceName added to Zone ${zone.zoneName} on KeyPad ${keypad.name}');
  }

  void addCommand(
      Keypad keypad, Zones zone, Sources source, String commandName) {
    // Add command to source
    print(
        'Command $commandName added to Source ${source.sourceName} on Zone ${zone.zoneName} on KeyPad ${keypad.name}');
  }
}
