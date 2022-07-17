import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'network_event.dart';
part 'network_state.dart';

// class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
//   NetworkBloc({this.subscription}) : super(ConnectionInitial());

//   StreamSubscription? subscription;

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription? subscription;

  NetworkBloc({this.subscription}) : super(ConnectionInitial()) {
    on<ListenConnection>((event, emit) {
      subscription =
          InternetConnectionCheckerPlus().onStatusChange.listen((status) {
        add(ConnectionChanged(status == InternetConnectionStatus.disconnected
            ? ConnectionFailure()
            : ConnectionSuccess()));
      });
    });

    on<ConnectionChanged>((event, emit) {
      emit(event.connection);
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
