import 'package:flutter/material.dart';
import 'package:pp6_layout/dialogs/get_host_dialog_form.dart';

import '../models/host.dart';

//import 'package:web_socket_demo/flutterflow/flutter_flow_theme.dart';

class hosts_list_widget extends StatelessWidget {
  hosts_list_widget({
    Key? key,
    required this.hosts,
  }) : super(key: key);

  final List<Host> hosts;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          flex: 0,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: hosts.isNotEmpty ? hosts.length : 0,
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
                            child: Column(
                              mainAxisSize: MainAxisSize
                                  .min, // makes dialog shrink to fit contents
                              children: [
                                SizedBox(height: 150),
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  //elevation: 16,
                                  child: get_host_dialog_widget(
                                      this_host: hosts[index]),
                                ),
                              ],
                            ),
                          ),
                        ]);
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
                            child: Text(
                              "${hosts[index].name} ${hosts[index].favourite ? '*' : ''}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: size.width * .013),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: hosts[index].known
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
                        onPressed: () {},
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
        ),
      ],
    );
  }
}
