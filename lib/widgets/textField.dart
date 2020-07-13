import 'package:flutter/material.dart';

TextField textField(String hintText, Function function) {
  return TextField(
    decoration: InputDecoration(
        border: InputBorder.none, hintText: hintText),
    onChanged: (value) => function(value),
  );
}
