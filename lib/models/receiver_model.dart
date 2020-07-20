class Receiver {
  final name;
  final ip;

  Receiver(this.name, this.ip);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ip': ip,
    };
  }
}
