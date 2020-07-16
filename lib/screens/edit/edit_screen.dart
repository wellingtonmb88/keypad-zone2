import 'package:automation/models/keypad_model.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  Keypad keypad;

  EditScreen(this.keypad);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
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
                      'IP:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.ip,
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
                      'SSID:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.ssid,
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
                      'Password:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Text(
                        widget.keypad.password,
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
              child: widget.keypad.ip.trim().length > 0
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
                onPressed: () {},
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
