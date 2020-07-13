import 'package:flutter/material.dart';

Container title(String title) {
  return Container(
    child: Text(title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 30.0),
  );
}
