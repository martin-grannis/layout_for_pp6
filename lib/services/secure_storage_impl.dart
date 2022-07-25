//import 'package:web_socket_demo/services/secure_storage.dart';

import 'dart:convert';

import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/models/remembered_hosts.dart';
import 'package:pp6_layout/services/secure_storage.dart';

class handle_secure_storage {
  final SecureStorage secureStorage = SecureStorage();

  late List<Host> remembered_hosts;
  late List<Host> saved_hosts;

  // Future<List<Remembered_Hosts>> DummySetupStorage() async {
  //   String? remembered_hosts =
  //       await secureStorage.readSecureData('remembered-hosts.json');
  //   // ignore: unnecessary_null_comparison
  //   if (remembered_hosts == null) {
  //     remembered_hosts = '[]';
  //   }
  //   return Remembered_Hosts.Remembered_HostsFromJson(remembered_hosts);
  // }

  void setDefaultHost(Host h) {
    secureStorage.writeSecureData('defaultHost', h.name);
  }

  Future<String> getDefaultHost() async {
    var s = await secureStorage.readSecureData('defaultHost');
    return s ?? "";
  }

  Future<List<Host>> retrieve_remembered_hosts() async {
    String? remembered_hosts =
        await secureStorage.readSecureData('remembered-hosts.json');
    // ignore: unnecessary_null_comparison
    remembered_hosts ??= '[]';
    return Remembered_Hosts.Remembered_HostsFromJson(remembered_hosts);
  }

  List<Remembered_Hosts> save_remembered_hosts() {
    return [
      //Remembered_Hosts("Martin's mac  1", "192.168.1.99", "56445", "albert"),
      Remembered_Hosts(
          Host("Sue's PC", " 192.168.1.68", "61223", false, "highway", false)),
      //Remembered_Hosts("Propresenter host 1 ", "192.168.1.47", "18667", "Woven"),
    ];
  }

  Future<List<Host>> retrieve_saved_hosts() async {
    String sh;
    try {
      sh = await secureStorage.readSecureData('saved-hosts.json');
    } catch (e) {
      sh = "";
    }

    var tagObjsJson = jsonDecode(sh) as List;
    List<Host> obj = tagObjsJson.map((h)=> Host.fromJson(h)).toList();

    return obj;
  }

  Future<void> save_saved_hosts(List<Host> lh) async {
     //convert lh to fson string 
     String jsonHosts = jsonEncode(lh);
     await secureStorage.writeSecureData('saved-hosts.json', jsonHosts);
  }
}
