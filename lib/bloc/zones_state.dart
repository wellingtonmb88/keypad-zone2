part of 'zones_bloc.dart';

abstract class ZonesState extends Equatable {
  const ZonesState();
}

class ZonesInitial extends ZonesState {
  @override
  List<Object> get props => [];
}

class StartGetKeypad extends ZonesState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SuccessGetKeypad extends ZonesState {
  final KeyPad keypad;

  SuccessGetKeypad({this.keypad});

  @override
  List<Object> get props => [keypad];
}

class ErrorGetKeypad extends ZonesState {
  final String message;

  ErrorGetKeypad({this.message});

  @override
  List<Object> get props => [message];
}
