import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';

part 'available_hosts_event.dart';
part 'available_hosts_state.dart';

class AvailableHostsBloc extends Bloc<AvailableHostsEvent, AvailableHostsState> {
  AvailableHostsBloc() : super(AvailableHostsInitial()) {

handle_secure_storage hss = handle_secure_storage();
    
    on<RequestHostsLoad>((event, emit) async {
    List<Host> availableHosts = [];
    final List<Host> rh = await hss.retrieve_known_hosts();
    availableHosts = await Host.find_available_hosts(rh);
    final List<Host> sh = await hss.retrieve_saved_hosts();
   
    emit(AvailableHostsLoaded(availableHosts, sh));

    });
  }
}
