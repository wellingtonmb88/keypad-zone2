import 'package:equatable/equatable.dart';

class KeyPad extends Equatable {
  final int keypadId;
  final String keypadName;
  final String ip;
  final String mDNS;
  final List<Zones> zones;

  KeyPad({this.keypadId, this.keypadName, this.ip, this.mDNS, this.zones});

  Map toJson() {
    List<Map> zones = this.zones != null
        ? this.zones.map((zone) => zone.toJson()).toList()
        : null;

    return {
        'keypadId': keypadId,
        'keypadName': keypadName,
        'ip': ip,
        'mDNS': mDNS,
        'zones': zones
      };
  }

  @override
  List<Object> get props => [keypadId, keypadName, ip, mDNS, zones];
}

class Zones extends Equatable {
  final int zoneId;
  final String zoneName;
  final List<Sources> sources;

  Zones({this.zoneId, this.zoneName, this.sources});

  Map toJson() {
    List<Map> sources = this.sources != null
        ? this.sources.map((source) => source.toJson()).toList()
        : null;

    return {'zoneId': zoneId, 'zoneName': zoneName, 'sources': sources};
  }

  @override
  List<Object> get props => [zoneId, zoneName, sources];
}

class Sources extends Equatable {
  final int sourceId;
  final String sourceName;
  final List<Commands> commands;

  Sources({this.sourceId, this.sourceName, this.commands});

  Map toJson() {
    List<Map> commands = this.commands != null
        ? this.commands.map((command) => command.toJson()).toList()
        : null;

    return {
      'sourceId': sourceId,
      'sourceName': sourceName,
      'commands': commands
    };
  }

  @override
  List<Object> get props => [sourceId, sourceName, commands];
}

class Commands extends Equatable {
  final String command;

  Commands({this.command});

  Map toJson() => {'command': command};

  @override
  List<Object> get props => [command];
}
