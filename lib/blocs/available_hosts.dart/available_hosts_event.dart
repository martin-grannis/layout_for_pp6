part of 'available_hosts_bloc.dart';

abstract class AvailableHostsEvent extends Equatable {
  const AvailableHostsEvent();

  @override
  List<Object> get props => [];
}

class RequestHostsLoad extends AvailableHostsEvent {}