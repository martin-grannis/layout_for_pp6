import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';

//import 'package:web_socket_demo/constants/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    //MediaQueryData sizeInfo = MediaQuery.of(context);
    return AppBar(
        title: Container(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      //flex: 1,
                      child: Column(
                        children: [
                          Text(
                            'MrB PP6 remote\nthingy',
                            style: TextStyle(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child:
                          BlocBuilder<PP6_ConnectionBloc, PP6_ConnectionState>(
                        builder: (context, state) {
                          final server_details = state
                                  .host_server.name.isNotEmpty
                              ? '${state.host_server.name} on port ${state.host_server.port}'
                              : '<nothing>';
                          return Text(
                            'Connected to: ${server_details}',
                            style: TextStyle(fontSize: 14),
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Text(
                    //     'Hello World3',
                    //     style: TextStyle(fontSize: 14),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.orange),
            onPressed: () {
              // //pretend login
              // streamController.add(ConnectedState(
              //     "server", "192.168.4.56", "4433", "vikings", true)); //
              // test set bloc onnected stated eto connected
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 0));
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.purple),
            onPressed: () {
              // //pretend login
              // streamController.add(ConnectedState(
              //     "server", "192.168.4.56", "4433", "vikings", true)); //
              // test set bloc onnected stated eto connected
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 1));
            },
          ),
          IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.green),
            onPressed: () {
              // //pretend login
              // streamController.add(ConnectedState(
              //     "server", "192.168.4.56", "4433", "vikings", true)); //
              // test set bloc onnected stated eto connected
              context.read<PP6_ConnectionBloc>().add(
                  const PP6_ConnectionStatusChanged(
                      PP6_ConnectionStatus.disconnected, Host.empty));

              context.read<PP6_ConnectionBloc>().add(
                  const PP6_ConnectionStatusChanged(
                      PP6_ConnectionStatus.connected, Host.sampler));
            },
          ),
          IconButton(
            icon: Icon(Icons.stop, color: Color.fromARGB(255, 255, 0, 17)),
            onPressed: () {
              //   streamController.add(ConnectedState(
              //       "", "", "", "", false)); //
              context.read<PP6_ConnectionBloc>().add(
                  const PP6_ConnectionStatusChanged(
                      PP6_ConnectionStatus.disconnected, Host.empty));
            },
          ),
        ]);
  }
}
