import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_keypad_screen.dart';
import 'package:automation/widgets/informationRow.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EditScreen extends StatefulWidget {
  final Keypad keypad;

  EditScreen(this.keypad);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String _ssid;
  String _password;

  @override
  void initState() {
    super.initState();

    _ssid = widget.keypad.ssid;
    _password = widget.keypad.password;
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

    void _showConfirmMessage() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('KeyPads'),
              content: Text('Your keypad was saved!'),
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

    void _saveKeypad(String password) {
      Keypad keypad = widget.keypad;
      Keypad newKeypad = new Keypad(
          keypad.id,
          keypad.name,
          keypad.keypadIp,
          keypad.receiverIp,
          keypad.keypadMdns,
          keypad.receiverMdns,
          password,
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
      _showConfirmMessage();
    }

    Future<void> _cryptoPassword() async {
      if (_password.trim().length > 0) {
        final plainText = _password;
        final key = encrypt.Key.fromUtf8(DotEnv().env['KEY']);
        final iv = IV.fromLength(8);

        final encrypter = Encrypter(Salsa20(key));

        final encrypted = encrypter.encrypt(plainText, iv: iv);

        _saveKeypad(encrypted.base64);
      } else {
        _saveKeypad('');
      }
    }

    void _goToBonjour() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BonjourKeypad(widget.keypad, widget.keypad.id)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.keypad.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Physical Keypad Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),
              Container(
                  child: informationRow('Keypad IP:', widget.keypad.keypadIp),
                  margin: EdgeInsets.only(bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                  child: informationRow('MDns Name:', widget.keypad.keypadMdns),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'SSID:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                    ),
                    Container(
                      child: Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: this._ssid.trim().length > 0
                                  ? this._ssid
                                  : 'Change SSID',
                              hintStyle: this._ssid.trim().length > 0
                                  ? TextStyle(color: Colors.black)
                                  : TextStyle()),
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
                            hintText: 'Change Password'),
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
                child: Text(
                  'Receiver Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(top: 40),
              ),
              Container(
                  child:
                      informationRow('Receiver IP:', widget.keypad.receiverIp),
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                  child:
                      informationRow('MDns Name:', widget.keypad.receiverMdns),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                child: StreamBuilder(
                  stream: _bloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              Container(
                child: primaryButton('Save Changes', _cryptoPassword),
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
                child: primaryButton('Send Keypad', _goToBonjour),
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0),
              )
            ],
          ),
          padding: EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}
