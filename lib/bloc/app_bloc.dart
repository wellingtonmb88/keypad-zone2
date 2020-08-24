import 'dart:async' show Stream, StreamController;
import 'dart:convert';
import 'package:automation/models/real_keypad_model.dart';
import 'package:automation/models/receiver_model.dart';
import 'package:automation/service/data_base.dart';
import 'package:automation/models/keypad_model.dart';

class AppBloc {
  bool loading = false;
  List<Keypad> _keypads = [];
  List<Receiver> _receivers = [];
  List<RealKeypad> _realKeypads = [];
  List<Zones> zones = [
    new Zones('1', 'MAIN', []),
    new Zones('2', 'ZONE2', []),
    new Zones('3', 'ZONE3', []),
    new Zones('4', 'ZONE4', []),
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
  List<Commands> commands = [
    new Commands('Turn On', 'cmd0=PutZone_OnOff%2FON'),
    new Commands('Turn Off', 'cmd0=PutZone_OnOff%2FOFF'),
    new Commands('Volume Up', 'cmd0=PutMasterVolumeBtn/>'),
    new Commands('Volume Down', 'cmd0=PutMasterVolumeBtn/<'),
    new Commands('Mute On', 'cmd0=PutVolumeMute/on'),
    new Commands('Mute Off', 'cmd0=PutVolumeMute/off'),
    new Commands('SAT', 'cmd0=PutZone_InputFunction%2FSAT%2FCBL'),
    new Commands('DVD', 'cmd0=PutZone_InputFunction%2FDVD'),
    new Commands('MPLAY', 'cmd0=PutZone_InputFunction%2FMPLAY'),
    new Commands('Phono', 'cmd0=PutZone_InputFunction%2FPHONO'),
    new Commands('Aux', 'cmd0=PutZone_InputFunction%2FAUX1'),
    new Commands('CD', 'cmd0=PutZone_InputFunction%2FCD'),
    new Commands('Game', 'cmd0=PutZone_InputFunction%2FGAME'),
    new Commands('Tv', 'cmd0=PutZone_InputFunction%2FTV'),
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

  StreamController<bool> _loadingController =
      StreamController<bool>.broadcast();
  Stream<bool> get outLoading => _loadingController.stream;
  Sink<bool> get inLoading => _loadingController.sink;

  void setLoading(bool showLoading) {
    loading = showLoading;
    inLoading.add(loading);
  }

  void fetchKeypads() async {
    List<Keypad> keypads = await getKeypads();
    keypads.map((keypad) => _keypads.add(keypad)).toList();
    inKeypads.add(_keypads);
  }

  Future<int> addKeyPad(Keypad keypad) async {
    loading = true;
    inLoading.add(loading);
    List<int> response = utf8.encode(json.encode(keypad.toJson()));
    int id = await insertKeypad(response);

    _keypads.add(keypad);
    inKeypads.add(_keypads);

    loading = false;
    inLoading.add(loading);

    return id;
  }

  void changeKeypad(Keypad keypad) async {
    loading = true;
    inLoading.add(loading);

    List<int> response = utf8.encode(json.encode(keypad.toJson()));
    updateKeypad(response, keypad.id);
    _keypads = [];
    fetchKeypads();

    loading = false;
    inLoading.add(loading);
  }

  void deleteKeypad(int id) async {
    await delete(id);
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

  void dispose() {
    _keypadsController.close();
    _realKeypadsController.close();
    _receiverController.close();
    _loadingController.close();
  }
}
