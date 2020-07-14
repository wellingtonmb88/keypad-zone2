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

  Database dataBase = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) {
    db.execute(
        'CREATE TABLE Keypad (id integer primary key autoincrement, name TEXT, ip TEXT, mdns TEXT, password TEXT, ssid TEXT)');
    db.execute(
        'CREATE TABLE Zone (id integer primary key autoincrement, keypadId integer, name TEXT)');
    db.execute(
        'CREATE TABLE Button (id integer primary key autoincrement, zoneId integer, name TEXT, command TEXT)');
  });

  return dataBase;
}

Future<List<Keypad>> getKeypads() async {
  Database dataBase = await _createConnection();
  final List<Map<String, dynamic>> keypads = await dataBase.query('Keypad');

  dataBase.close();

  if (keypads.length > 0) {
    return List.generate(keypads.length, (index) {
      return Keypad(
          keypads[index]['id'],
          keypads[index]['name'],
          keypads[index]['ip'],
          keypads[index]['mdns'],
          keypads[index]['password'],
          keypads[index]['ssid'],
          keypads[index]['zone']);
    });
  } else {
    return [];
  }
}

void insertKeypad(Keypad keypad) async {
  Database dataBase = await _createConnection();

  await dataBase.transaction((txn) async {
    int keypadId = await txn.rawInsert(
        'INSERT INTO Keypad (name, ip, mdns, password, ssid) VALUES (?,?,?,?,?)',
        [keypad.name, keypad.ip, keypad.mdns, keypad.password, keypad.ssid]);

    int zoneId = await txn.rawInsert(
        'INSERT INTO Zone (keypadId, name) VALUES (?,?)',
        [keypadId, keypad.zone.name]);

    keypad.zone.buttons.map((button) async {
      int buttonId = await txn.rawInsert(
          'INSERT INTO Button (zoneId, name, command) VALUES (?,?,?)',
          [zoneId, button.name, button.command]);
      print(buttonId);
    }).toList();
  });

  dataBase.close();
}

// Future<void> delete() async {
//   Database db = await _createConnection();
//   await db.delete('Keypad', where: 'name = ?', whereArgs: ['Test']);
// }
