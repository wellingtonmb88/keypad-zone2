import 'package:flutter/material.dart';

Row informationRow(String title, String information) {
  return Row(
    children: <Widget>[
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Container(
        child: Text(
          information,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        margin: EdgeInsets.only(left: 10.0),
      )
    ],
  );
}
