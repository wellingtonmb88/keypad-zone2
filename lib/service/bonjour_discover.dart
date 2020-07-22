import 'dart:async';
import 'dart:io';
import 'package:automation/bloc/app_bloc.dart';
import 'package:automation/models/real_keypad_model.dart';
import 'package:automation/models/receiver_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mdns_plugin/mdns_plugin.dart';

void bonjour() async {
  MDNSPlugin mdns = new MDNSPlugin(Delegate());
  await mdns.startDiscovery("_http._tcp", enableUpdating: true);
  sleep(mdns);
}

Future sleep(mdns) {
  return new Future.delayed(
      const Duration(seconds: 5), () async => await mdns.stopDiscovery());
}

class Delegate implements MDNSPluginDelegate {
  final AppBloc _bloc = BlocProvider.getBloc<AppBloc>();

  void onDiscoveryStarted() {
    _bloc.setLoading(true);
    print("Discovery started");
  }

  void onDiscoveryStopped() {
    _bloc.setLoading(false);
    print("Discovery stopped");
  }

  bool onServiceFound(MDNSService service) {
    print("Found: $service");
    return true;
  }

  void onServiceResolved(MDNSService service) {
    print("Resolved: $service");

    if (service.name.contains('DENON')) {
      Receiver receiver = new Receiver(service.name,
          Platform.isIOS ? service.addresses[0] : service.hostName);
      _bloc.setReceiver(receiver);
    }

    if (service.name.contains('KEYPAD')) {
      RealKeypad keypad = new RealKeypad(service.name, service.addresses[0]);
      _bloc.setRealKeypad(keypad);
    }
  }

  void onServiceUpdated(MDNSService service) {
    print("Updated: $service");
  }

  void onServiceRemoved(MDNSService service) {
    print("Removed: $service");
  }
}
