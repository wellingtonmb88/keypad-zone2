import 'dart:async';
import 'package:mdns_plugin/mdns_plugin.dart';

void bonjour() async {
  MDNSPlugin mdns = new MDNSPlugin(Delegate());
  await mdns.startDiscovery("_http._tcp", enableUpdating: true);
  sleep(mdns);
}

Future sleep(mdns) {
  return new Future.delayed(const Duration(seconds: 30), () async => await mdns.stopDiscovery());
}

class Delegate implements MDNSPluginDelegate {
  void onDiscoveryStarted() {
    print("Discovery started");
  }

  void onDiscoveryStopped() {
    print("Discovery stopped");
  }

  bool onServiceFound(MDNSService service) {
    print("Found: $service");
    return true;
  }

  void onServiceResolved(MDNSService service) {
    print("Resolved: $service");
  }

  void onServiceUpdated(MDNSService service) {
    print("Updated: $service");
  }

  void onServiceRemoved(MDNSService service) {
    print("Removed: $service");
  }
}
