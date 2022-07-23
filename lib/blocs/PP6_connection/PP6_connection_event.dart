part of 'PP6_connection_bloc.dart';

@immutable
abstract class PP6_ConnectionEvent extends Equatable {
  const PP6_ConnectionEvent();

  @override
  List<Object> get props => [];
}



class PP6_ConnectionStatusChanged extends PP6_ConnectionEvent {
  const PP6_ConnectionStatusChanged(this.status, this.host);
  final PP6_ConnectionStatus status;
  final Host host;

  @override
  List<Object> get props => [status, host];
}

class PP6_ConnectionDisconnectRequested extends PP6_ConnectionEvent {}

// used as we need to use listener for main screen and that works onl.y after initial state changes
class PP6_Initialise extends PP6_ConnectionEvent {}
