import 'package:flutter/material.dart';

RaisedButton primaryButton(text, Function function) {
  return RaisedButton(
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.blue,
  );
}
