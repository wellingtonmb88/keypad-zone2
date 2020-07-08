class Keypad {
  final String id;
  final String name;
  final String ip;
  final String mDns;
  final List<Zones> zones;

  Keypad(this.id, this.name, this.ip, this.mDns, this.zones);
}

class Zones {
  final String zoneId;
  final String zoneName;
  final List<Sources> sources;

  Zones(this.zoneId, this.zoneName, this.sources);
}

class Sources {
  final String sourceId;
  final String sourceName;
  final List<Commands> commands;

  Sources(this.sourceId, this.sourceName, this.commands);
}

class Commands {
  final String command;

  Commands(this.command);
}
