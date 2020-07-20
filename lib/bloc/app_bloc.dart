import 'dart:async' show Stream, StreamController;
import 'dart:convert';
import 'package:automation/models/real_keypad_model.dart';
import 'package:automation/models/receiver_model.dart';
import 'package:automation/service/data_base.dart';
import 'package:automation/models/keypad_model.dart';

class AppBloc {
  List<Keypad> _keypads = [];
  List<Receiver> _receivers = [];
  List<RealKeypad> _realKeypads = [];
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
    new Buttons('8', 'Button 8', ''),
  ];
  List<String> commands = [
    'Turn On',
    'Turn Off',
  ];

  StreamController<List<Keypad>> _keypadsController =
      StreamController<List<Keypad>>.broadcast();
  Stream<List<Keypad>> get outKeypads => _keypadsController.stream;
  Sink<List<Keypad>> get inKeypads => _keypadsController.sink;

  StreamController<List<Receiver>> _receiverController =
      StreamController<List<Receiver>>.broadcast();
  Stream<List<Receiver>> get outReceivers => _receiverController.stream;
  Sink<List<Receiver>> get inReceivers => _receiverController.sink;

  StreamController<List<RealKeypad>> _realKeypadsController =
      StreamController<List<RealKeypad>>.broadcast();
  Stream<List<RealKeypad>> get outRealKeypads => _realKeypadsController.stream;
  Sink<List<RealKeypad>> get inRealKeypads => _realKeypadsController.sink;

  void fetchKeypads() async {
    // await delete();
    List<Keypad> keypads = await getKeypads();
    keypads.map((keypad) => _keypads.add(keypad)).toList();
    inKeypads.add(_keypads);
  }

  Future<int> addKeyPad(Keypad keypad) async {
    List<int> response = utf8.encode(json.encode(keypad.toJson()));
    int id = await insertKeypad(response);

    _keypads.add(keypad);
    inKeypads.add(_keypads);

    return id;
  }

  void changeKeypad(Keypad keypad) async {
    List<int> response = utf8.encode(json.encode(keypad.toJson()));
    updateKeypad(response, keypad.id);
    _keypads = [];
    fetchKeypads();
  }

  void setReceiver(Receiver receiver) {
    _receivers = [];
    _receivers.add(receiver);
    inReceivers.add(_receivers);
  }

  void setRealKeypad(RealKeypad keypad) {
    _realKeypads = [];
    _realKeypads.add(keypad);
    inRealKeypads.add(_realKeypads);
  }
}
