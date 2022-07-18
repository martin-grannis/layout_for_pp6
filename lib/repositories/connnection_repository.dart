import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
//import 'dart:ui';

//Import 'package:image/image.dart' as Image;

//import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:pp6_layout/models/host.dart';
import 'package:pp6_layout/models/presentation.dart';
import 'package:pp6_layout/repositories/websockets_repository.dart';


enum PP6_ConnectionStatus { unknown, connected, disconnected }

class ConnectionRepository {
  //late final WebsocketService _wss;
  final _controller = StreamController<PP6_ConnectionStatus>();

  final _controller2 = StreamController<SinkMessage>.broadcast();

  final WebsocketService _wss = WebsocketService();

  Stream<PP6_ConnectionStatus> get statusREPO async* {
    yield PP6_ConnectionStatus.disconnected;
    yield* _controller.stream;
  }

  Stream<SinkMessage> get Updates async* {
    yield* _controller2.stream;
  }

  ///caching
  ///

  List<PresentationCacheItem> songCache = [];

  int maxSongs = 25;

  ///

  Future<dynamic> getLibrary() async {
    try {
      String result = await _wss.getLibrary();

      return result;
    } catch (e) {
      throw Exception('Failed'); // value ignored - but indicates error
    }
  }

  Future<dynamic> getPlaylists() async {
    try {
      String result = await _wss.getPlaylists();
      return result;
      // var scanData_decoded = jsonDecode(result);
      // var playlistsRequestAll = PlaylistRequestAll.fromJson(scanData_decoded);
      // return playlistsRequestAll.playlistAll;
    } catch (e) {
      throw Exception('Failed'); // value ignored - but indicates error
    }
  }

  Future<String> logIn({
    //required String username,
    required Host host,
    required String hostPassword,
  }) async {
    //await _wss.disconnectWS();
    String result =
        await _wss.authenticateWS(host.ip_address, host.port, hostPassword);
    if (result == "OK") return result;
    throw Exception('Failed'); // value ignored - but indicates error
  }

  void logOut() {
    _controller.add(PP6_ConnectionStatus.disconnected);
  }

  void dropConnection() {
    _wss.dropConnection();
  }

  void dispose() => _controller.close();

  Future<Presentation?> getPresentation(String this_song) async {
    // is it in the cache?
    // yes - return the presentation from cache
    int pos = songCache.indexWhere(
        (element) => element.presentation!.presentationName == this_song);
    if (pos >= 0) {
      return songCache[pos].presentation;
      // inform pp6 that we have switched songs
      //
    }
    // no - load it - add to cache
    String song_request_response = await _wss.presentationRequest(this_song);
    // String result = await _wss.getPlaylists();
    Map<String, dynamic> scan_decoded =
        jsonDecode(song_request_response)['presentation'];
    Presentation this_presentation = Presentation.fromJson(scan_decoded);
    this_presentation.presentationName = this_song;

// find decoding images and add to GroupSlidesObject

    // List<MySlideGroup> lsg = [];
    // List<MySlide> ls = [];
    int slideCounter = 0;
    // MySlide ms = MySlide();
    // MySlideGroup msg = MySlideGroup();

    this_presentation.presentationSlideGroups!.forEach(
      (slideGroupElement) {
        // for each Slide Group
        // make a list of mySlides
        slideGroupElement.groupSlides!.forEach((slideElement) {
          Uint8List my_bytes = base64Decode(slideElement.slideImage!);
          MemoryImage this_slide_image = MemoryImage(my_bytes);
          //ms.mySlideImage = this_slide_image;
          slideElement.SlideImageUsable = this_slide_image;
          //ls.add(ms);
          slideCounter++;
        });
        //msg.myDecodedSlides = ls;
        //ls = []; // reset the slide list
        //lsg.add(msg);
        //msg = MySlideGroup();
      },
    );

    this_presentation.setupLinearSlideArray();
    //this_presentation.presentationDecodedSlideGroups = lsg;
    this_presentation.slideCount = slideCounter;

// end decoding image

// add to cache
    PresentationCacheItem pci =
        PresentationCacheItem(this_presentation, DateTime.now());
    songCache.add(pci);
    _controller2.sink.add(SinkMessage(
        "CU", "", CacheUpdate(pci.presentation!.presentationName!, true)));
    // cu.added = false;
    // cu.presentation_name = "";

    if (songCache.length > maxSongs) {
      songCache.sort((a, b) => b.date_time!.compareTo(a.date_time!));
      PresentationCacheItem nm = songCache.last;
      songCache.removeLast();

      _controller2.sink
          //.add(CacheUpdate(nm.presentation!.presentationName!, false));
          .add(SinkMessage("CU", "",
              CacheUpdate(nm.presentation!.presentationName!, false)));
    }

    String presentationSlideIndex = await _wss.presentationSlideIndex();

    return this_presentation;
  }

  showPresentationByIndex(this_song, slideNo) async {
    String song_show_request_response =
        await _wss.presentationShowRequest(this_song, slideNo);
  }
}
