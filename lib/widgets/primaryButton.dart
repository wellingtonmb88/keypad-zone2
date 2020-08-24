import 'package:flutter/material.dart';

RaisedButton primaryButton(text, Function function, bool disable) {
  return RaisedButton(
    onPressed: disable ? null : () => function(),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
    color: Colors.blue,
  );
}
