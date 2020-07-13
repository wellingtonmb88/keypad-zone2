class Keypad {
  final String id;
  final String name;
  final List<Zones> zones;

  Keypad(this.id, this.name, this.zones);

  toJson() {
    List zones = this.zones != null
        ? this.zones.map((zone) => zone.toJson()).toList()
        : null;

    return {'id': id, 'name': name, 'zones': zones};
  }
}

class Zones {
  final String zoneId;
  final String name;
  final List<Buttons> buttons;

  Zones(this.zoneId, this.name, this.buttons);

  toJson() {
    List buttons = this.buttons != null
        ? this.buttons.map((button) => button.toJson()).toList()
        : null;

    return {'zoneId': zoneId, 'name': name, 'buttons': buttons};
  }
}

class Buttons {
  final String buttonId;
  final String name;
  final List<Commands> commands;

  Buttons(this.buttonId, this.name, this.commands);

  toJson() {
    List commands = this.commands != null
        ? this.commands.map((command) => command.toJson()).toList()
        : null;

    return {'buttonId': buttonId, 'name': name, 'commands': commands};
  }
}

class Commands {
  final String name;

  Commands(this.name);

  toJson() {
    return {'name': name};
  }
}
