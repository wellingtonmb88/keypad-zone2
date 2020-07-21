class Keypad {
  final int id;
  final String name;
  final String keypadIp;
  final String receiverIp;
  final String keypadMdns;
  final String receiverMdns;
  final String password;
  final String ssid;
  final Zones zone;

  Keypad(this.id, this.name, this.keypadIp, this.receiverIp, this.keypadMdns,
      this.receiverMdns, this.password, this.ssid, this.zone);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'keypadIp': keypadIp,
      'receiverIp': receiverIp,
      'keypadMdns': keypadMdns,
      'receiverMdns': receiverMdns,
      'password': password,
      'ssid': ssid,
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

    return {'zoneId': zoneId, 'name': name, 'buttons': buttons};
  }
}

class Buttons {
  final String buttonId;
  final String name;
  final String command;

  Buttons(this.buttonId, this.name, this.command);

  toJson() {
    return {'buttonId': buttonId, 'name': name, 'command': command};
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
