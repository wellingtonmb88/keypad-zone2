import 'package:flutter/material.dart';

class BonjourScreen extends StatefulWidget {
  BonjourScreen();

  @override
  _BonjourScreenState createState() => _BonjourScreenState();
}

class _BonjourScreenState extends State<BonjourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search KeyPads'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text(
              'Search Keypads',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () {},
          ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
