import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/layout/layout_bloc.dart';
import 'package:pp6_layout/pages/connected_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          TextButton(
            child: const Text("left tabbed Left", style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context).add(
                  LayoutEventChangeLayout(newLayout: 0));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left tabbed right", style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context).add(
                  LayoutEventChangeLayout(newLayout: 1));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left listing", style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context).add(
                  LayoutEventChangeLayout(newLayout: 2));

              // handle the press
            },
          ),
          TextButton(
            child: const Text("left playlist", style: TextStyle(color: Colors.white)),
            onPressed: () {
              BlocProvider.of<LayoutBloc>(context).add(
                  LayoutEventChangeLayout(newLayout: 3));

              // handle the press
            },
          ),
        ],
      ),
      body: const ConnectedPage(),
        
      
    );
  }
}
