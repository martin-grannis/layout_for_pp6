import 'dart:async';
import 'dart:convert';

import 'package:chalkdart/chalk.dart';
import 'package:web_socket_channel/io.dart';

late IOWebSocketChannel channel;
bool channel_initialised = false;
var streamController = StreamController.broadcast();

//final IP = "192.168.1.10";

class WebsocketService {
  Future<String> authenticateWS(
      String hostIP, String hostPORT, String enteredPassword) async {
    makeConnection(hostIP, hostPORT);

    try {
      sendData(channel,
          '{"action": "authenticate","protocol": "600","password": "$enteredPassword"}');
      // channel.sink.add(
      //     '{"action": "authenticate","protocol": "600","password": "${enteredPassword}"}');
    } catch (e) {
      return (e.toString());
    }

    final scanData = await waitForReply(channel);
    Map scanData_decoded = jsonDecode(scanData);

    if (scanData_decoded['action'] == "authenticate" &&
        scanData_decoded['authenticated'] == 1) {
      return "OK";
    }
    return "FAILED";
  }

  Future<dynamic> getLibrary() async {
// KLUDGE
// for debugging we need to ensure channel has been initilaised
    if (!channel_initialised) {
      makeConnection("192.168.1.10", "49442");
      channel_initialised = true;
      sendData(channel,
          '{"action": "authenticate","protocol": "600","password": "sunshine"}');

      final scanData = await streamController.stream.first;
      //final String scanData_decoded = await waitForReply(channel);
      print(scanData);
    }

    try {
      sendData(channel, '{"action": "libraryRequest"}');
    } catch (e) {
      throw ("error 1 loading library");
    }

    final scanData = await waitForReply(channel);

    // TODO check it was a library request we received
    // Map scanData_decoded = jsonDecode(scanData);
    // if (scanData_decoded['action'] == "libraryRequest") {
    //scanData_decoded;
    return scanData;
    //}
    // TODO do exception
    throw ("error 2 loading library");
  }

  Future<dynamic> getPlaylists() async {
// KLUDGE
// for debugging we need to ensure channel has been initilaised
    // if (!channel_initialised) {
    //   makeConnection("192.168.1.10", "49442");
    //   channel_initialised = true;
    //   sendData(channel,
    //       '{"action": "authenticate","protocol": "600","password": "sunshine"}');
    //   // throw away response for now
    //   await waitForReply(channel);
    // }

    try {
      sendData(channel, '{"action": "playlistRequestAll"}');
    } catch (e) {
      throw ("error 1 loading library");
    }

    final scanData = await waitForReply(channel);

    // TODO check it was a library request we received
    // Map scanData_decoded = jsonDecode(scanData);
    // if (scanData_decoded['action'] == "libraryRequest") {
    //scanData_decoded;
    return scanData;
    //}
    // TODO do exception
    throw ("error 2 loading library");
  }

  void makeConnection(String hostIP, String hostPORT) {
    //streamController.close();
    channel =
        //IOWebSocketChannel.connect(Uri.parse('ws://192.168.1.28:49442/remote'));
        IOWebSocketChannel.connect(
      Uri.parse('ws://$hostIP:$hostPORT/remote'),
      //pingInterval: Duration(seconds: 120)
    );

    streamController = StreamController.broadcast();

    streamController.addStream(channel.stream);
    channel_initialised = true; // this makes it BROADCAST
  }

  void dropConnection() {
    if (channel_initialised) {
      channel.sink.close();
      channel_initialised = false;
    }
  }

  Future<String> presentationRequest(String this_song) async {
    try {
      // escape the slashes
      sendData(channel,
          '{"action": "presentationRequest", "presentationName" : "${this_song.replaceAll('/', '\\/')}","presentationPath": "${this_song.replaceAll('/', '\\/')}", "presentationQuality" : "200"}');
      //'{"action": "presentationRequest", "presentationPath": "${this_song.replaceAll('/', '\\/')}", "presentationQuality" : "200"}');
    } catch (e) {
      throw ("error 1 loading presentation");
    }

// immediately send a presentationSlideIndex request

// try {
//       // escape the slashes
//       sendData(channel,
//           '{"action": "presentationSlideIndex"');
//     } catch (e) {
//       throw ("error 1 loading presentation");
//     }

    final scanData = await waitForReply(channel);
    // final scanData2 = await waitForReply(channel);

    return scanData;
  }

  presentationShowRequest(this_song, slideNo) async {
    try {
      sendData(channel,
          '{"slideIndex" : "$slideNo", "action": "presentationTriggerIndex", "presentationPath": "${this_song.replaceAll('/', '\\/')}" }');
    } catch (e) {
      throw ("error 1 showing loading presentation");
    }

    final scanData = await waitForReply(channel);

    return scanData;
  }

  presentationSlideIndex() async {
    try {
      // escape the slashes
      sendData(channel, '{"action": "presentationSlideIndex"}');
    } catch (e) {
      throw ("error 1 loading presentation slideIndex");
    }

    final scanData = await waitForReply(channel);
    // this should just be the return confirmation

    return scanData;
  }
}

void sendData(IOWebSocketChannel channel, String s) {
  if (s.isNotEmpty) channel.sink.add(s);
  print(chalk.red("sending:  $s"));
}

dynamic waitForReply(IOWebSocketChannel channel) async {
  final scanData = await streamController.stream.first;

  var o = jsonDecode(scanData);

  // for (int i = 0; i < o.length; i++) {
  //   var obj = o[i] as Map();
  //   var x = "stopMe";

  switch (o['action']) {
    case 'presentationCurrent':
      print(chalk.blue.bold(
          "reply: gotPresentationCurrent - presentationName = ${o['presentation']['presentationName']}, presentationCurrentLocation = ${o['presentation']['presentationCurrentLocation']}"));
      break;
    case 'libraryRequest':
      print(chalk.blue.bold("reply: gotLibrary"));
      break;
    case 'playlistRequestAll':
      print(chalk.blue.bold("reply: gotPlaylistsAll"));
      break;
    case 'presentationSlideindex':
      print(chalk.blue.bold("reply: $o"));
      break;
    default:
      print(chalk.green.bold("reply UNEXPECTED: $o"));
      break;
  }

  // if (o['action'] == "presentationCurrent") {
  //   print(
  //       "reply: gotPresentationCurrent - presentationName = ${o['presentation']['presentationName']}  \n\n");
  // }

  // if (o['action'] == "presentationCurrent") {
  //   print(
  //       "reply: gotPresentationCurrent - presentationName = ${o['presentation']['presentationName']}  \n\n");
  // }

  //print("reply: ${o}  \n\n");
  return scanData;
}
