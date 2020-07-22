import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Container secondaryButton(String text, String ip, String command, double width,
    BuildContext context) {
  return Container(
    child: RaisedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      onPressed: () => _callReceiver(context, ip, command),
    ),
    width: width * 0.4,
  );
}

Future<void> _callReceiver(
    BuildContext context, String ip, String command) async {
  try {
    await http.get('http://$ip/$command');
  } catch (e) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Ops! Something went wrong!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(top: 5),
                  ),
                  Container(
                    child: Text('Check your internet connection'),
                    margin: EdgeInsets.only(top: 10),
                  ),
                  Text('and Keypad/Receiver IP.')
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
