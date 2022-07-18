import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pp6_layout/blocs/PP6_connection/PP6_connection_bloc.dart';
import 'package:pp6_layout/pages/connected_to_server_page.dart';
import 'package:pp6_layout/pages/find_server_page.dart';
import 'package:pp6_layout/pages/splash_page.dart';
import 'package:pp6_layout/repositories/connnection_repository.dart';
import 'package:pp6_layout/sample_home_page.dart';
import 'package:pp6_layout/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.connectionRepository,
  }) : super(key: key);


  final ConnectionRepository connectionRepository;

   @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: connectionRepository,
      child: BlocProvider(
        create: (_) => PP6_ConnectionBloc(
            connectionRepository: connectionRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {


  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // ignore: unused_field
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<PP6_ConnectionBloc, PP6_ConnectionState>(
          listener: (context, state) {
            //print("1. ${state}");
            switch (state.status) {
              case PP6_ConnectionStatus.connected:
                _navigator!.pushAndRemoveUntil<void>(
                    ConnectToServerPage.route(), (route) => false);
                break;
              case PP6_ConnectionStatus.disconnected:
                _navigator!.pushAndRemoveUntil<void>(
                    FindServerPage.route(), (route) => false);
                //MyHomePage.route(),(route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,

//        platform: TargetPlatform.iOS,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: AppDarkTheme.textTheme,
      ),
      title: 'proPresenter6',
      //home: Scaffold(
      //  appBar: CustomAppBar(),
      //body: AuthService(),
      //  body: HomePage(),
      //body: WebSocketDemo(),
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

