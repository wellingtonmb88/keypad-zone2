import 'package:automation/models/keypad_model.dart';
import 'package:automation/screens/config/config_screen.dart';
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
    final AppBloc bloc = BlocProvider.getBloc<AppBloc>();

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
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfigScreen()));
                      },
                      child: Text(
                        'Add KeyPad',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    )),
                width: double.infinity,
                margin: EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
              ),
              Container(
                child: StreamBuilder(
                  stream: bloc.outKeypads,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.data.length > 0) {
                      return Column(
                        children: <Widget>[
                          Container(
                            child: Text('Select a KeyPad'),
                            alignment: Alignment.center,
                          ),
                          Container(
                              child: DropdownButton<Keypad>(
                            value: snapshot.data[0],
                            onChanged: (Keypad newKeypad) {
                              setState(() {});
                            },
                            items: snapshot.data
                                .map<DropdownMenuItem<Keypad>>((Keypad keypad) {
                              print(snapshot.data);
                              return DropdownMenuItem<Keypad>(
                                value: keypad,
                                child: Text(keypad.name),
                              );
                            }).toList(),
                          ))
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
                child: RaisedButton(
                    child: Text(
                      'Send KeyPad',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {}),
                width: double.infinity,
                margin: EdgeInsets.only(top: 50, right: 20.0, left: 20.0),
              )
            ],
          )),
        ));
  }
}
