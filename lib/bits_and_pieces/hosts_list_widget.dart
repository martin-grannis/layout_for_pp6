import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp6_layout/blocs/available_hosts.dart/available_hosts_bloc.dart';
import 'package:pp6_layout/dialogs/get_host_dialog_form.dart';

import 'package:pp6_layout/dialogs/manual_connection_dialog.dart';

import '../models/host.dart';

//import 'package:web_socket_demo/flutterflow/flutter_flow_theme.dart';

class hosts_list_widget extends StatelessWidget {
  hosts_list_widget({
    Key? key,
    //required this.hosts,
  }) : super(key: key);

  //final List<Host> hosts;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<AvailableHostsBloc, AvailableHostsState>(
        builder: (context, state) {
      if (state is AvailableHostsInitial)
        return Center(child: CircularProgressIndicator());
      else if (state is AvailableHostsLoaded) {
        return Column(
          children: [
            Expanded(
              flex: 0,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    state.known_hosts.isNotEmpty ? state.known_hosts.length : 0,
                //itemCount: 0,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context1, int index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //print("Row tapped");
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Stack(children: [
                              const IgnorePointer(
                                child: Scaffold(
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SafeArea(
                                child: Container(
                                  width: size.width * .6,
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // makes dialog shrink to fit contents
                                    children: [
                                      SizedBox(height: 150),
                                      Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        //elevation: 16,
                                        // TODO
                                         child: GetHostDialogForm(
                                             thisHost: state.known_hosts[index]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]);
                          }).then((_) {
                        //setState(() {});
                      });
                    },
                    child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 1),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 135, 192, 242),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Spacer(flex: 7),
                              Expanded(
                                flex: 9,
                                child: 
                                  Text(
                                   "${state.known_hosts[index].name} ${state.known_hosts[index].favourite ? '*' : ''}",
                                   style: Theme.of(context)
                                       .textTheme
                                       .bodyText1
                                       ?.copyWith(fontSize: size.width * .013),
                                 ),
                              ),
                              Expanded(
                                flex: 3,
                                
                                child: state.known_hosts[index].known
                                    ? Icon(Icons.check_box_outlined,
                                        color: Colors.black,
                                        size: 24 * size.width * .001)
                                    : Icon(Icons.check_box_outline_blank_outlined,
                                        color: Colors.black,
                                        size: 24 * size.width * .001),
                              ),
                              Spacer(),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
              child: Container(
                color: Color.fromARGB(255, 135, 192, 242),
                height: 40,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(flex: 7),
                      Expanded(
                        flex: 9,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // Show manual connection form
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Stack(
                                        // centre the dialog box
                                        alignment: Alignment.center,
                                        children: [
                                          const IgnorePointer(
                                            child: Scaffold(
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                          SafeArea(
                                            child: Column(
                                              mainAxisSize: MainAxisSize
                                                  .min, // makes dialog shrink to fit contents
                                              children: [
                                                SizedBox(height: 0),
                                                Dialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  //elevation: 16,
                                                  child: get_manual_connection_details_dialog(
                                                      //thisHost: state.known_hosts[index]),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]);
                                  });
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft,
                                primary: Colors.white),
                            child: Text(" -- Manually setup connection-- ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontSize: size.width * .013)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(),
                      ),
                      Spacer()
                    ]),
              ),
            )
          ],
        );
      }
      throw ("State error");
    });
  }
}
