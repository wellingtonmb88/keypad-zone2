import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/edit/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KeypadScreen extends StatefulWidget {
  final Keypad keypad;

  KeypadScreen(this.keypad);

  @override
  _KeypadScreenState createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
  void _goToEdit(Keypad keypad) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => EditScreen(keypad)));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keypad.name),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _goToEdit(widget.keypad))
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[0].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[0].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[1].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[1].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[2].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[2].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[3].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[3].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[4].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[4].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[5].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[5].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[6].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[6].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                    Container(
                      child: RaisedButton(
                        child: Text(
                          widget.keypad.zone.buttons[7].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () async {
                          await http.get(
                              'http://${widget.keypad.receiverIp}/${widget.keypad.zone.buttons[7].command}');
                        },
                      ),
                      width: width * 0.4,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                margin: EdgeInsets.only(top: 30),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: height * 0.2, right: 20, left: 20),
        ),
      ),
    );
  }
}
