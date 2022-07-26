part of 'available_hosts_bloc.dart';

abstract class AvailableHostsState extends Equatable {
  AvailableHostsState();

final List<Host> known_hosts =[];
  final List<Host> saved_hosts =[];
    @override
  List<Object> get props => [known_hosts, saved_hosts];
 
}

class AvailableHostsInitial extends AvailableHostsState {

}

class AvailableHostsLoaded extends AvailableHostsState {
  final List<Host> known_hosts;
  final List<Host> saved_hosts;

  AvailableHostsLoaded(this.known_hosts, this.saved_hosts);
  @override
  List<Object> get props => [known_hosts, saved_hosts];
}
