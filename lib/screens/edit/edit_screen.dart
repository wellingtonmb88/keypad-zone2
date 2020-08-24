import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/internationalization/app_localizations.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_keypad_screen.dart';
import 'package:automation/widgets/informationRow.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  final Keypad keypad;

  EditScreen(this.keypad);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool _disable;

  @override
  void initState() {
    super.initState();
    _disable = widget.keypad.keypadIp.trim().length > 0 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

    void _errorAlert() {
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

    void _showConfirmReset() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Keypads'),
              content:
                  Text(AppLocalizations.of(context).translate('confirm_reset')),
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

    void _showConfirmDelete() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Keypads'),
              content: Text(
                  AppLocalizations.of(context).translate('confirm_delete')),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            );
          });
    }

    void _goToBonjour() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BonjourKeypad(widget.keypad, widget.keypad.id, true)));
    }

    Future<void> _resetKeypad() async {
      _bloc.setLoading(true);

      try {
        final response =
            await http.post('http://${widget.keypad.keypadIp}/reset');
        _bloc.setLoading(false);
        if (response.statusCode == 200) {
          _showConfirmReset();
        } else {
          _errorAlert();
        }
      } catch (e) {
        _bloc.setLoading(false);
        print(e);
        _errorAlert();
      }
    }

    void _assuranceResetKeypad() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Keypads'),
              content: Text(
                  AppLocalizations.of(context).translate('assurance_reset')),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('yes')),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetKeypad();
                  },
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('no')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    void _deleteKeypad() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Keypads'),
              content: Text(
                  AppLocalizations.of(context).translate('assurance_delete')),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('yes')),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _bloc.deleteKeypad(widget.keypad.id);
                    _showConfirmDelete();
                  },
                ),
                FlatButton(
                  child: Text(AppLocalizations.of(context).translate('no')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
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
                  AppLocalizations.of(context).translate('keypad_information'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: 20),
              ),
              Container(
                  child: informationRow(
                      AppLocalizations.of(context).translate('keypad_ip'),
                      widget.keypad.keypadIp),
                  margin: EdgeInsets.only(bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                  child: informationRow(
                      AppLocalizations.of(context).translate('mdns_name'),
                      widget.keypad.keypadMdns),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('receiver_information'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(top: 40),
              ),
              Container(
                  child: informationRow(
                      AppLocalizations.of(context).translate('receiver_ip'),
                      widget.keypad.receiverIp),
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                  child: informationRow(
                      AppLocalizations.of(context).translate('mdns_name'),
                      widget.keypad.receiverMdns),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
              Divider(color: Colors.grey, height: 1),
              Container(
                child: primaryButton(
                    AppLocalizations.of(context).translate('reset_keypad'),
                    _assuranceResetKeypad,
                    _disable),
                width: double.infinity,
                margin: EdgeInsets.only(top: 50.0),
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
                    AppLocalizations.of(context).translate('delete_keypad'),
                    _deleteKeypad,
                    false),
                width: double.infinity,
                margin: EdgeInsets.only(top: 50.0),
              ),
              Container(
                child: widget.keypad.keypadIp.trim().length > 0
                    ? Container()
                    : Text(
                        '${AppLocalizations.of(context).translate('real_keypad')} '
                        '${AppLocalizations.of(context).translate('click_button_edit')}'),
                margin: EdgeInsets.only(top: 50.0),
              ),
              Container(
                child: primaryButton(
                    AppLocalizations.of(context).translate('send_keypad'),
                    _goToBonjour,
                    false),
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
