import 'package:flutter/material.dart';

RaisedButton primaryButton(context, text, Function function) {
  return RaisedButton(
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.blue,
  );
}
