// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/foundation.dart'; // for debugPrint

//import 'package:formz/formz.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

part 'PP6_connection_event.dart';
part 'PP6_connection_state.dart';

class PP6_ConnectionBloc
    extends Bloc<PP6_ConnectionEvent, PP6_ConnectionState> {
  PP6_ConnectionBloc({
    required ConnectionRepository connectionRepository,
    //required HostRepository hostRepository,
  })  : _connectionRepository = connectionRepository,
        //  _hostRepository = hostRepository,

        // for testing
        super(PP6_ConnectionState.disconnected()) {
//        super(const PP6_ConnectionState.connected(Host.sampler)) {
    on<PP6_Initialise>(_onPP6_Initialise);
    on<PP6_ConnectionStatusChanged>(_onPP6_ConnectionStatusChanged);
    on<PP6_ConnectionDisconnectRequested>(_onPP6_ConnectionDisconnectRequested);

    //gets repo stream and adds the default statusREPO
    // _PP6_ConnectionStatusSubscription = _connectionRepository.statusREPO.listen(
    //     //(status) => add(PP6_ConnectionStatusChanged(status, Host.empty)),
    //     (status) {
    //   String s = "stopMe";
    //   //catchMe();
    //   // if (status.stat == PP6_ConnectionStatus.disconnected) {
    //   //   add(PP6_ConnectionStatusChanged(
    //   //       //PP6_ConnectionStatus.connected, Host.sampler));
    //   //       PP6_ConnectionStatus.disconnected,
    //   //       Host.empty));
    //   // } else {
    //   // add(PP6_ConnectionStatusChanged(
    //   //         PP6_ConnectionStatus.connected, Host.sampler)
    //       // PP6_ConnectionStatus.connected, status.host));
    //       //);
    // });
  }

  get connectionRepositoryInstance => _connectionRepository;

  //get _connectionRepositoryInstance => null;

  // void catchMe() {
  //   print("here");
  // }

  final ConnectionRepository _connectionRepository;
  //final HostRepository _hostRepository;
  // StreamSubscription<PP6_ConnectionStatusMessage>?
  //     _PP6_ConnectionStatusSubscription;

  @override
  Future<void> close() {
    _connectionRepository.dispose();
    return super.close();
  }

  void _onPP6_ConnectionStatusChanged(
    PP6_ConnectionStatusChanged event,
    Emitter<PP6_ConnectionState> emit,
  ) async {
    switch (event.status) {
      case PP6_ConnectionStatus.disconnected:
        _connectionRepository.dropConnection();
        return emit(PP6_ConnectionState.disconnected());
      case PP6_ConnectionStatus.connected:
        //final host = await _tryGetHost();
        return emit(PP6_ConnectionState.connected(event.props[1] as Host));

      default:
        return emit(const PP6_ConnectionState.unknown());
    }
  }

  void _onPP6_Initialise(
    PP6_ConnectionEvent event,
    Emitter<PP6_ConnectionState> emit,
  ) {
    emit(PP6_ConnectionState.disconnected());
  }

  void _onPP6_ConnectionDisconnectRequested(
    PP6_ConnectionDisconnectRequested event,
    Emitter<PP6_ConnectionState> emit,
  ) {
    _connectionRepository.logOut();
  }

  @override
  void onTransition(
      Transition<PP6_ConnectionEvent, PP6_ConnectionState> transition) {
    super.onTransition(transition);
    debugPrint(transition.currentState.toString() +
        "\n" +
        transition.nextState.toString() +
        "\n\n");
  }

  @override
  void onChange(Change<PP6_ConnectionState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint(error.toString());
  }

  @override
  void onEvent(PP6_ConnectionEvent event) {
    super.onEvent(event);
    debugPrint(event.toString());
  }
}
