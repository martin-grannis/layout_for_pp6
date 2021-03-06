import 'package:flutter/material.dart';
import 'package:pp6_layout/bits_and_pieces/custom_app_bar.dart';
import 'package:pp6_layout/bits_and_pieces/hosts_list_widget.dart';
import 'package:pp6_layout/bits_and_pieces/looking_for_servers_bouncing.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/models/remembered_hosts.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';

//import 'package:secure_repository/secure_repository.dart';


class FindServerPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const FindServerPage());
  }

  const FindServerPage({Key? key}) : super(key: key);

  @override
   State<FindServerPage> createState() => _FindServerPageState();
}

class _FindServerPageState extends State<FindServerPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

// state
  List<Remembered_Hosts> remembered_hosts = [];
  List<Host> available_hosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getRememberedHosts();
  }

  handle_secure_storage hss = handle_secure_storage();

  Future<void> _getRememberedHosts() async {
    final List<Remembered_Hosts> rh = await hss.DummySetupStorage();
    final List<Host> foundHosts = await Host.find_available_hosts(rh);
    if (mounted) {
      setState(() {
        remembered_hosts = rh.toList(growable: false);
        available_hosts = foundHosts;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //backgroundColor: Colors.red,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              color: const Color(0x00EEEEEE),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: Image.asset(
                  //'assets/images/page_mrb_software_transparent.png',
                  //'assets/images/page_pp6_logo_transparent.png',
                  'assets/images/page_blank_transparent.png',
                ).image,
              ),
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (Theme.of(context).brightness == Brightness.dark)
                            Image.asset(
                              'assets/images/topLogo_dark.png',
                              width: 200,
                              height: 230,
                              fit: BoxFit.fitWidth,
                            ),
                          if (!(Theme.of(context).brightness ==
                              Brightness.dark))
                            Image.asset(
                              'assets/images/topLogo_light.png',
                              width: 200,
                              height: 230,
                              fit: BoxFit.fitWidth,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Available Connections',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(flex: 7),
                        Expanded(
                          flex: 9,
                          child: Text(
                            "Computer",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        //SizedBox(width: 9),
                        Expanded(
                          flex: 3,
                          child: Text("known",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                // decoration: BoxDecoration(
                                //   color: Color.fromARGB(214, 145, 30, 212),
                                // ),
                                child: _isLoading
                                    ? const looking_for_servers_bouncing()
                                    : hosts_list_widget(
                                        hosts: available_hosts)),
                            //remembered_hosts: null),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
