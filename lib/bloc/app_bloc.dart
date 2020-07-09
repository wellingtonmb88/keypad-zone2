import 'dart:async';

import 'package:automation/models/keypad_model.dart';

class AppBloc {
  List<Keypad> _keypads = [];
  List<Zones> zones = [
    new Zones('1', 'Kitchen', []),
    new Zones('2', 'Bedroom', []),
  ];
  List<Buttons> buttons = [
    new Buttons('1', 'Button 1', []),
    new Buttons('2', 'Button 2', []),
  ];
  List<Commands> commands = [
    new Commands('Turn On'),
    new Commands('Turn Off'),
  ];

  StreamController<List<Keypad>> _keypadsController =
      StreamController<List<Keypad>>();
  Stream<List<Keypad>> get outKeypads => _keypadsController.stream;
  Sink<List<Keypad>> get inKeypads => _keypadsController.sink;

  void addKeyPad(Keypad keypad) {
    _keypads.add(keypad);
    inKeypads.add(_keypads);
  }
}
