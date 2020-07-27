import 'package:automation/internationalization/app_localizations.dart';
import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/config/config_screen.dart';
import 'package:automation/screens/keypad/keypad_screen.dart';
import 'package:automation/widgets/dropDown.dart';
import 'package:automation/widgets/primaryButton.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../../bloc/app_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) => _bloc.fetchKeypads());

    void _goToConfig() => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConfigScreen()));

    void _goToKeypad(Keypad keypad) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => KeypadScreen(keypad)));

    return StreamBuilder(
      stream: _bloc.outKeypads,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.data.length > 0) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('title_home')),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _goToConfig();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        AppLocalizations.of(context).translate('select_keypad'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Container(
                      child: dropDown(snapshot.data, _goToKeypad),
                    )
                  ],
                ),
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.topCenter,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('title_home')),
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(AppLocalizations.of(context)
                          .translate('keypads_home')),
                    ),
                    Container(
                      child: Text(AppLocalizations.of(context)
                          .translate('click_button_home')),
                    ),
                    Container(
                      child: ButtonTheme(
                          minWidth: 150,
                          child: primaryButton('Add Keypad', _goToConfig)),
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 100),
                alignment: Alignment.topCenter,
              ),
            ),
          );
        }
      },
    );
  }
}
