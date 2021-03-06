class Keypad {
  int id;
  String name;
  Zones zone;
  String keypadIp;
  String receiverIp;
  String keypadMdns;
  String receiverMdns;

  Keypad(this.id, this.name, this.keypadIp, this.receiverIp, this.keypadMdns,
      this.receiverMdns, this.zone);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'keypad_ip': keypadIp,
      'receiver_ip': receiverIp,
      'keypad_mdns': keypadMdns,
      'receiver_mdns': receiverMdns,
      'zones': zone
    };
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

    return {'zone_id': zoneId, 'name': name, 'buttons': buttons};
  }
}

class Buttons {
  final String buttonId;
  final String name;
  final String command;

  Buttons(this.buttonId, this.name, this.command);

  toJson() {
    return {'button_id': buttonId, 'name': name, 'command': command};
  }
}

class Commands {
  final String name;
  final String command;

  Commands(this.name, this.command);

  toJson() {
    return {'name': name, 'command': command};
  }
}
