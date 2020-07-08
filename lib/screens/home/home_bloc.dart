import 'dart:async';

import 'package:automation/models/keypad_model.dart';

class HomeBloc {
  List<Keypad> keypads = [];

  final StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void getKeyPads() {
    // Fetch KeyPads on backend.
  }

  void buttonPressed(Keypad keypad, Zones zone, Sources source) {
    // Trigger action of button.
    print(
        'Source ${source.sourceName} of Zone ${zone.zoneName} of KeyPad ${keypad.name} was pressed');
  }
}
