part of 'zones_bloc.dart';

abstract class ZonesEvent extends Equatable {
  const ZonesEvent();
}

class SourcesEvent extends ZonesEvent {
  final String zone;

  SourcesEvent({this.zone});

  @override
  List<Object> get props => [zone];
}
