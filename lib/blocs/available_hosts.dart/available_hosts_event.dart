part of 'available_hosts_bloc.dart';

abstract class AvailableHostsEvent extends Equatable {
  const AvailableHostsEvent();

  @override
  List<Object> get props => [];
}

class RequestHostsLoad extends AvailableHostsEvent {}

class UpdateKnownHostStatus extends AvailableHostsEvent {
final Host host;

  const UpdateKnownHostStatus(this.host);
}

class   RemoveSavedHost extends AvailableHostsEvent {
final Host host;

  const RemoveSavedHost(this.host);
}

  
