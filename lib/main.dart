import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/blocs/network/network_bloc.dart';
import 'package:pp6_layout/dialogs/network_down.dart';
import 'package:pp6_layout/pages/connected_page.dart';
import 'package:pp6_layout/pages/network_failure_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NetworkBloc()..add(ListenConnection()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PP6 layout with network sensor',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;

 /// var _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    // StreamSubscription<ConnectivityResult> _connectivitySubscription;
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // int h = 9;
  }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   setState(() {
  //     connectivityResult = result;
  //     print(result.name);
  //     int i = 9;
  //   });
  // }

  // @override
  // dispose() {
  //   super.dispose();

  //   _connectivitySubscription.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            child: const Text("left tabbed Left",
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 0));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left tabbed right",
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 1));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left listing",
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 2));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left playlist",
                style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context)
                  .add(LayoutEventChangeLayout(newLayout: 3));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("network down",
                style: TextStyle(color: Colors.white)),
            onPressed: () => isInternet(context),
          ),
        ],
      ),
      body: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure) {
            return NetworkFailurePage();
          }
          return ConnectedPage();
        },
      ),
    );
  }
}

isInternet(context) async {
  {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      print("Internet connection is from Mobile data");
    } else if (result == ConnectivityResult.wifi) {
      print("internet connection is from wifi");
    } else if (result == ConnectivityResult.ethernet) {
      print("internet connection is from wired cable");
    } else if (result == ConnectivityResult.bluetooth) {
      print("internet connection is from bluethooth threatening");
    } else if (result == ConnectivityResult.none) {
      print("No internet connection");
    }
  }
  showMyDialog(context);
}
