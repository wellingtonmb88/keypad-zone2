import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/internationalization/app_localizations.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/models/receiver_model.dart';
import 'package:automation/screens/bonjour/bonjour_keypad_screen.dart';
import 'package:automation/service/bonjour_discover.dart';
import 'package:automation/widgets/dropDown.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class BonjourReceiver extends StatefulWidget {
  final Keypad keypad;
  final int id;

  BonjourReceiver(this.keypad, this.id);

  @override
  _BonjourReceiverState createState() => _BonjourReceiverState();
}

class _BonjourReceiverState extends State<BonjourReceiver> {
  String _receiverMdns;
  String _receiverIp;

  @override
  void initState() {
    super.initState();

    _receiverMdns = '';
    _receiverIp = '';
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

    void _goToBonjour(Keypad keypad, int id) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BonjourKeypad(keypad, id)));
    }

    void _saveReceiver(Receiver receiver) {
      setState(() {
        _receiverMdns = receiver.name;
        _receiverIp = receiver.ip;
      });
    }

    void _saveKeypad() {
      if (_receiverIp.trim().length < 1) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Keypads'),
                content: Text(
                    AppLocalizations.of(context).translate('error_receiver')),
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
      } else {
        Keypad keypad = widget.keypad;
        keypad.receiverIp = _receiverIp;
        keypad.receiverMdns = _receiverMdns;
        _bloc.changeKeypad(keypad);
        _goToBonjour(keypad, keypad.id);
      }
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
                    AppLocalizations.of(context).translate('search_receiver'),
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
                  stream: _bloc.outReceivers,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.data.length > 0) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Text(AppLocalizations.of(context)
                                .translate('select_receiver')),
                            alignment: Alignment.center,
                          ),
                          Container(
                              child: dropDown(snapshot.data, _saveReceiver)),
                        ],
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Text(AppLocalizations.of(context)
                              .translate('receiver_not_founded')),
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
      ),
    );
  }
}
