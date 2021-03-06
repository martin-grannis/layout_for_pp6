//import 'dart:ffi';
import 'dart:io';

import 'package:multicast_dns/multicast_dns.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/models/remembered_hosts.dart';
import 'package:pp6_layout/services/secure_storage_impl.dart';



var factory =
    (dynamic host, int port, {bool? reuseAddress, bool? reusePort, int? ttl}) {
  return RawDatagramSocket.bind(host, port,
      reuseAddress: true, reusePort: false, ttl: 10);
  };

Future<List<Host>> getMDNS(List<Remembered_Hosts> known_hosts_details) async {
  const String name = '_pro6proremote._tcp.local';

  //final MDnsClient client = MDnsClient(rawDatagramSocketFactory: factory);
  final MDnsClient client = MDnsClient();

  List<Host> tempHosts = [];

  var factoryI = (myInterfaces) async {
    var interf = await client.allInterfacesFactory(myInterfaces);
    var iList = interf.toList();
    iList.removeWhere(
        (item) => item.addresses[0].address.startsWith('169.254.'));
    return iList;
  };

  await client.start(interfacesFactory: factoryI);

  // Get the PTR record for the service.
  await for (final PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      await for (final IPAddressResourceRecord ip
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(srv.target))) {
        String Hostname = srv.target.replaceAll('.local', '');
        String password = areWeKnown(Hostname, known_hosts_details);

        // get favourite if one is set
        handle_secure_storage hss = handle_secure_storage();
        String fave = await hss.getDefaultHost();

        //String fave = "Martins-MacBook-Air";

        tempHosts.add(
          Host(Hostname, ip.address.address, srv.port.toString(),
              password != "", password, fave == Hostname),
        ); // last arg is "known"
      }

      //print(srv.target);
    }
  }
  client.stop();
  return tempHosts;
}

String areWeKnown(String hostname, List<Remembered_Hosts> khd) {
  String hName = "";
  bool found = false;
  khd.forEach((element) {
    if (!found) {
      if (element.name == hostname) {
        hName = element.password;
        found = true;
      }
    }
  });
  return hName;
}
