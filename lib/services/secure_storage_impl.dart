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

  Future<List<Host>> retrieve_known_hosts() async {
    String sh;
    try {
      sh = await secureStorage.readSecureData('known-hosts.json');
    } catch (e) {
      sh = "[]";
    }
    //var test = jsonEncode([]);

    var tagObjsJson = jsonDecode(sh) as List;
    List<Host> obj = tagObjsJson.map((h) => Host.fromJson(h)).toList();

    return obj;
  }

  Future<void> save_known_hosts(List<Host> lh) async {
    //convert lh to fson string
    String jsonHosts = jsonEncode(lh);
    await secureStorage.writeSecureData('known-hosts.json', jsonHosts);
  }

  Future<List<Host>> retrieve_saved_hosts() async {
    String sh;
    try {
      sh = await secureStorage.readSecureData('saved-hosts.json');
    } catch (e) {
      sh = "[]";
    }

    var tagObjsJson = jsonDecode(sh) as List;
    List<Host> obj = tagObjsJson.map((h) => Host.fromJson(h)).toList();

    return obj;
  }

  Future forgetPassword(Host h) async {
    var kh = await retrieve_known_hosts();
    int l = kh.indexWhere((item) => item.name == h.name);

    if (l != -1) {
      // remove it
      kh.removeAt(l);
    }
    await save_known_hosts(kh);

    var sh = await retrieve_saved_hosts();
    l = sh.indexWhere((item) => item.name == h.name);

    if (l != -1) {
      // remove it
      sh.removeAt(l);
    }
    await save_saved_hosts(sh);
  }

  Future<void> save_saved_hosts(List<Host> lh) async {
    //convert lh to fson string
    String jsonHosts = jsonEncode(lh);
    await secureStorage.writeSecureData('saved-hosts.json', jsonHosts);
  }
}
