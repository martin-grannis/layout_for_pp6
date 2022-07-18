
//import 'package:web_socket_demo/services/secure_storage.dart';

import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/models/remembered_hosts.dart';
import 'package:pp6_layout/services/secure_storage.dart';

class handle_secure_storage {
  final SecureStorage secureStorage = SecureStorage();
//List<Remembered_Hosts> remembered_hosts;

  Future<List<Remembered_Hosts>> DummySetupStorage() async {
    //String json = jsonEncode(find_available_hosts_dummy().map((i) => i.toJson()).toList()).toString();
    //secureStorage.writeSecureData('hosts.json', json);

// // ignore: dead_code
// if (false){ // set to false to run this routine
//   String json =
//       jsonEncode(retrieve_remembered_hosts().map((i) => i.toJson()).toList())
//           .toString();
// // sample write
//   secureStorage.writeSecureData('remembered-hosts.json', json);
// // sample delete
//   secureStorage.deleteSecureData('remembered-hosts.json');
// }

    String? remembered_hosts =
        await secureStorage.readSecureData('remembered-hosts.json');
    // ignore: unnecessary_null_comparison
    if (remembered_hosts == null) {
      remembered_hosts = '[]';
    }
    return Remembered_Hosts.Remembered_HostsFromJson(remembered_hosts);
  }

  void setDefaultHost(Host h) {
    secureStorage.writeSecureData('defaultHost', h.name);
  }

  Future<String> getDefaultHost() async {
    var s = await secureStorage.readSecureData('defaultHost');
    return s ?? "";
  }

  List<Remembered_Hosts> retrieve_remembered_hosts() {
    return [
      //Remembered_Hosts("Martin's mac  1", "192.168.1.99", "56445", "albert"),
      Remembered_Hosts("Sue's PC", " 192.168.1.68", "61223", "highway"),
      //Remembered_Hosts("Propresenter host 1 ", "192.168.1.47", "18667", "Woven"),
      Remembered_Hosts("LinuxHost", "192.168.1.19", "35446", "sunshine")
    ];
  }

// Map<String, dynamic> toJson(){
//   return {
//     "name": this.name,
//     "imagePath": this.imagePath,
//     "totalGames": this.totalGames,
//     "points": this.points
//   };
// }
}
