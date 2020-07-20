import 'dart:convert';
import 'dart:io';
import 'package:automation/models/keypad_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Future<String> _getPath() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = documentsDirectory.path + '/automation.db';

  return path;
}

Future<Database> _createConnection() async {
  String path = await _getPath();

  Database dataBase = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE Keypad (id integer primary key autoincrement, keypad TEXT)');
    },
  );

  return dataBase;
}

Future<List<Keypad>> getKeypads() async {
  Database dataBase = await _createConnection();
  final List<Map<String, dynamic>> keypads = await dataBase.query('Keypad');
  dataBase.close();

  if (keypads.length > 0) {
    return List.generate(keypads.length, (index) {
      var newKeypad = json.decode(utf8.decode(keypads[index]['keypad']));
      return Keypad(
          keypads[index]['id'],
          newKeypad['name'],
          newKeypad['keypadIp'],
          newKeypad['receiverIp'],
          newKeypad['mdns'],
          newKeypad['password'],
          newKeypad['ssid'],
          Zones(
              newKeypad['zones']['zoneId'],
              newKeypad['zones']['name'],
              List.generate(newKeypad['zones']['buttons'].length, (index) {
                return Buttons(
                    newKeypad['zones']['buttons'][index]['buttonId'],
                    newKeypad['zones']['buttons'][index]['name'],
                    newKeypad['zones']['buttons'][index]['command']);
              })));
    });
  } else {
    return [];
  }
}

Future<int> insertKeypad(List<int> keypad) async {
  Database dataBase = await _createConnection();

  int id = await dataBase.rawInsert('INSERT INTO Keypad (keypad) VALUES (?)', [keypad]);

  dataBase.close();

  return id;
}

void updateKeypad(List<int> keypad, int id) async {
  Database dataBase = await _createConnection();

  await dataBase.update('Keypad', {'keypad': keypad},
      where: "id = ?", whereArgs: [id]);

  dataBase.close();
}

Future<void> delete() async {
  Database db = await _createConnection();
  await db.delete('Keypad', where: 'id > 0');
}
