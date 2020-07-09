class Keypad {
  final String id;
  final String name;
  final List<Zones> zones;

  Keypad(this.id, this.name, this.zones);
}

class Zones {
  final String zoneId;
  final String zoneName;
  final List<Buttons> buttons;

  Zones(this.zoneId, this.zoneName, this.buttons);
}

class Buttons {
  final String buttonId;
  final String buttonName;
  final List<Commands> commands;

  Buttons(this.buttonId, this.buttonName, this.commands);
}

class Commands {
  final String command;

  Commands(this.command);
}
