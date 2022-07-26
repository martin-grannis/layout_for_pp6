part of 'available_hosts_bloc.dart';

abstract class AvailableHostsState extends Equatable {
  const AvailableHostsState();

  @override
  List<Object> get props => [];
}

class AvailableHostsInitial extends AvailableHostsState {
  final List<Host> known_hosts =[];
  final List<Host> saved_hosts = [];
}

class AvailableHostsLoaded extends AvailableHostsState {
  final List<Host> known_hosts;
  final List<Host> saved_hosts;

  AvailableHostsLoaded(this.known_hosts, this.saved_hosts);
}
