import 'dart:async' show Stream, StreamController;
import 'dart:convert';
import 'package:automation/database/data_base.dart';
import 'package:automation/models/keypad_model.dart';

class AppBloc {
  List<Keypad> _keypads = [];
  List<Zones> zones = [
    new Zones('1', 'Main', []),
    new Zones('2', 'Zone 1', []),
    new Zones('3', 'Zone 2', []),
    new Zones('4', 'Zone 3', []),
  ];
  List<Buttons> buttons = [
    new Buttons('1', 'Button 1', ''),
    new Buttons('2', 'Button 2', ''),
    new Buttons('3', 'Button 3', ''),
    new Buttons('4', 'Button 4', ''),
    new Buttons('5', 'Button 5', ''),
    new Buttons('6', 'Button 6', ''),
    new Buttons('7', 'Button 7', ''),
  ];
  List<String> commands = [
    'Turn On',
    'Turn Off',
  ];

  StreamController<List<Keypad>> _keypadsController =
      StreamController<List<Keypad>>();
  Stream<List<Keypad>> get outKeypads => _keypadsController.stream;
  Sink<List<Keypad>> get inKeypads => _keypadsController.sink;

  void fetchKeypads() async {
    // await delete();
    List<Keypad> keypads = await getKeypads();
    keypads.map((keypad) => _keypads.add(keypad)).toList();
    inKeypads.add(_keypads);
  }

  void addKeyPad(Keypad keypad) async {
    List<int> response = utf8.encode(json.encode(keypad.toJson()));
    insertKeypad(response);
    _keypads.add(keypad);
    inKeypads.add(_keypads);
  }
}
