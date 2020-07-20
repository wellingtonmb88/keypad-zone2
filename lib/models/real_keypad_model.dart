class RealKeypad {
  final String name;
  final String ip;

  RealKeypad(this.name, this.ip);

  Map<String, dynamic> toJson() {
    return {
      'mdnsName': name,
      'ip': ip,
    };
  }
}
