import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/bonjour/bonjour_screen.dart';
import 'package:automation/screens/config/config_screen.dart';
import 'package:automation/screens/edit/edit_screen.dart';
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

    void _goToConfig() => Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConfigScreen()));

    void _goToBonjour() => Navigator.push(
        context, MaterialPageRoute(builder: (context) => BonjourScreen()));

    void _goToEdit(Keypad keypad) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditScreen()));

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                child: ButtonTheme(
                    minWidth: 150,
                    child: primaryButton(context, 'Add KeyPad', _goToConfig)),
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: StreamBuilder(
                  stream: _bloc.outKeypads,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.data.length > 0) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Text('Select a KeyPad'),
                            alignment: Alignment.center,
                          ),
                          Container(child: dropDown(snapshot.data, _goToEdit)),
                        ],
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          Text('No KeyPads added.'),
                          Text('Add one KeyPad first'),
                        ],
                      );
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: primaryButton(context, 'Send KeyPad', _goToBonjour),
                width: double.infinity,
                margin: EdgeInsets.only(top: 50, right: 20.0, left: 20.0),
              ),
            ],
          )),
        ));
  }
}
