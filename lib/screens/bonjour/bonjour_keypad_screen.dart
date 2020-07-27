import 'dart:convert';

import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/internationalization/app_localizations.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/models/real_keypad_model.dart';
import 'package:automation/service/bonjour_discover.dart';
import 'package:automation/widgets/dropDown.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BonjourKeypad extends StatefulWidget {
  final Keypad keypad;
  final int id;

  BonjourKeypad(this.keypad, this.id);

  @override
  _BonjourKeypadState createState() => _BonjourKeypadState();
}

class _BonjourKeypadState extends State<BonjourKeypad> {
  String _keypadMdns;
  String _keypadIp;

  @override
  void initState() {
    super.initState();

    _keypadMdns = '';
    _keypadIp = '';
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

    Future<void> _sendToKeyPad(Keypad keypad) async {
      try {
        await http.post('http://${keypad.keypadIp}/save/config',
            body: jsonEncode(keypad));
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context).translate('error')),
                content: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('something_wrong'),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        child: Text(AppLocalizations.of(context)
                            .translate('check_connection')),
                        margin: EdgeInsets.only(top: 10),
                      ),
                      Text(AppLocalizations.of(context).translate('check_ip'))
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

    void _saveMdnsAndIp(RealKeypad keypad) {
      setState(() {
        _keypadMdns = keypad.name;
        _keypadIp = keypad.ip;
      });
    }

    void _saveKeypad() {
      Keypad keypad = widget.keypad;
      Keypad newKeypad = new Keypad(
          keypad.id == 0 ? widget.id : keypad.id,
          keypad.name,
          _keypadIp,
          keypad.receiverIp,
          _keypadMdns,
          keypad.receiverMdns,
          keypad.password,
          keypad.ssid,
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
      _sendToKeyPad(newKeypad);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('title_bonjour')),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    child: Text(
                      AppLocalizations.of(context).translate('search_keypad'),
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      bonjour();
                    },
                  ),
                  margin: EdgeInsets.only(top: 10.0),
                ),
                Container(
                  child: StreamBuilder(
                    stream: _bloc.outRealKeypads,
                    initialData: [],
                    builder: (context, snapshot) {
                      if (snapshot.data.length > 0) {
                        return Column(
                          children: <Widget>[
                            Container(
                              child: Text(AppLocalizations.of(context)
                                  .translate('select_keypad')),
                              alignment: Alignment.center,
                            ),
                            Container(
                                child: dropDown(snapshot.data, _saveMdnsAndIp)),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            Text(AppLocalizations.of(context)
                                .translate('keypad_not_founded')),
                          ],
                        );
                      }
                    },
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                ),
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
                  child: primaryButton(
                      AppLocalizations.of(context).translate('title_bonjour'),
                      _saveKeypad),
                  margin: EdgeInsets.only(top: 30.0),
                  width: double.infinity,
                ),
              ],
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 50.0),
          ),
        ));
  }
}
