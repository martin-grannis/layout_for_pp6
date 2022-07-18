part of 'PP6_connection_bloc.dart';

// sets initial as unknown with empty host
class PP6_ConnectionState extends Equatable {
  

  const PP6_ConnectionState({
    this.status = PP6_ConnectionStatus.unknown,
    this.host_server = Host.empty,
  });

// STATE

  final PP6_ConnectionStatus status;
  final Host host_server;

// make this class uninstantiatable
  const PP6_ConnectionState.unknown() : this();

  // set connected state to the host
  const PP6_ConnectionState.connected(Host server)
      : this(
          status: PP6_ConnectionStatus.connected,
          host_server: server,
        );

  const PP6_ConnectionState.disconnected()
      : this(status: PP6_ConnectionStatus.disconnected,
        host_server: Host.empty) ;
        

  @override
  List<Object> get props => [status, host_server];

  // PP6_ConnectionState copyWith({ConnectionStatus? status, Host? host}) {
  //   return PP6_ConnectionState(
  //     status: status ?? this.status,
  //     host_server: host ?? this.host_server,
  //   );
  // }
}
