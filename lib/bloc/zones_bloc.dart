import 'dart:async';

import 'package:automation/objects/keypad.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'zones_event.dart';
part 'zones_state.dart';

class ZonesBloc extends Bloc<ZonesEvent, ZonesState> {
  @override
  ZonesState get initialState => ZonesInitial();

  @override
  Stream<ZonesState> mapEventToState(
    ZonesEvent event,
  ) async* {
    if (event is SourcesEvent) {
      try {
        yield StartGetKeypad();

        final keypad = await getSources(event.zone);

        if (keypad == null) {
          yield ErrorGetKeypad(message: 'Zone not found.');
        } else {
          yield SuccessGetKeypad(keypad: keypad);
        }
      } catch (e) {
        yield ErrorGetKeypad(message: 'Ops! Something went wrong!');
        print(e);
      }
    }
  }

  KeyPad getSources(String zone) {
    // return Future.delayed(Duration(seconds: 1), () {
      if (zone == 'Main') {
        return KeyPad(
          keypadId: 1,
          keypadName: 'KeyPad 1',
          ip: '192.168.0.1',
          mDNS: '147.156.89-109',
          zones: [
            Zones(
              zoneId: 1,
              zoneName: 'Main',
              sources: [
                Sources(
                  sourceId: 1,
                  sourceName: 'Cinema',
                  commands: [
                    Commands(command: 'Command 1'),
                    Commands(command: 'Command 2')
                  ]
                )
              ]
            ),
            Zones(
              zoneId: 2,
              zoneName: 'Quarto 1',
              sources: [
                Sources(
                  sourceId: 1,
                  sourceName: 'Música',
                  commands: [
                    Commands(command: 'Command 1'),
                    Commands(command: 'Command 2')
                  ]
                )
              ]
            ),
          ],
        );
      }

      if (zone == 'Quarto 1') {
        return KeyPad(
          keypadId: 1,
          keypadName: 'KeyPad 2',
          ip: '192.168.0.2',
          mDNS: '147.156.89-110',
          zones: [
            Zones(
              zoneId: 1,
              zoneName: 'Quarto 1',
              sources: [
                Sources(
                  sourceId: 1,
                  sourceName: 'Música',
                  commands: [
                    Commands(command: 'Command 1'),
                    Commands(command: 'Command 2')
                  ]
                )
              ]
            ),
          ],
        );
      }

      return null;
    // });
  }
}
