import 'package:flutter/material.dart';

DropdownButton dropDown(items, Function function) {
  return DropdownButton(
    value: items[0],
    onChanged: (value) => function(value),
    items: items.map<DropdownMenuItem>((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(item.name),
      );
    }).toList(),
  );
}
