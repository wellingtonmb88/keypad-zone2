import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  Keypad keypad;

  EditScreen(this.keypad);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();
  String _ssid;
  String _password;

  @override
  void initState() {
    super.initState();

    _ssid = widget.keypad.ssid;
    _password = widget.keypad.password;
  }

  void _saveKeypad() {
    Keypad keypad = widget.keypad;
    Keypad newKeypad = new Keypad(
        keypad.id,
        keypad.name,
        keypad.keypadIp,
        keypad.receiverIp,
        keypad.mdns,
        this._password,
        this._ssid,
        new Zones(
            keypad.zone.zoneId,
            keypad.zone.name,
            List.generate(keypad.zone.buttons.length, (index) {
              return Buttons(
                  keypad.zone.buttons[index].buttonId,
                  keypad.zone.buttons[index].name,
                  keypad.zone.buttons[index].command);
            })));

    _bloc.changeKeypad(newKeypad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit KeyPads'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    'Name:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Text(
                      widget.keypad.name,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 10.0),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
            ),
            Divider(color: Colors.grey, height: 1),
            Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'KeypadIP:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.keypadIp,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
            Divider(color: Colors.grey, height: 1),
            Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'MDns Name:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.mdns,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
            Divider(color: Colors.grey, height: 1),
            Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      'ReceiverIP:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.receiverIp,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
            Divider(color: Colors.grey, height: 1),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      'SSID:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(right: 10.0),
                  ),
                  Container(
                    child: Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                this._ssid.trim().length > 0 ? this._ssid : 'Enter SSID'),
                        onChanged: (value) {
                          setState(() {
                            this._ssid = value;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey, height: 1),
            Container(
                child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    'Password:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.only(right: 10.0),
                ),
                Container(
                  child: Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: this._password.trim().length > 0
                              ? this._password
                              : 'Enter Password'),
                      onChanged: (value) {
                        setState(() {
                          this._password = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            )),
            Divider(color: Colors.grey, height: 1),
            Container(
              child: RaisedButton(
                child: Text(
                  'Save Keypad',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  this._saveKeypad();
                },
              ),
              width: double.infinity,
              margin: EdgeInsets.only(top: 50.0),
            ),
            Container(
              child: widget.keypad.keypadIp.trim().length > 0
                  ? Container()
                  : Text(
                      'This Keypad has not yet been configured on a real Keypad. '
                      'Click the button below to configure.'),
              margin: EdgeInsets.only(top: 50.0),
            ),
            Container(
              child: RaisedButton(
                child: Text(
                  'Send Keypad',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BonjourScreen()));
                },
              ),
              width: double.infinity,
              margin: EdgeInsets.only(top: 50.0),
            )
          ],
        ),
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
