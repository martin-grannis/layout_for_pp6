import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/blocs/network/network_bloc.dart';
import 'package:pp6_layout/dialogs/network_down.dart';
import 'package:pp6_layout/myApp.dart';
import 'package:pp6_layout/pages/connected_to_server_page.dart';
import 'package:pp6_layout/pages/network_failure_page.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => NetworkBloc()..add(ListenConnection()),
        child: MyApp(
          connectionRepository: ConnectionRepository(),
        ),
      ),
    );
