import 'package:equatable/equatable.dart';

class PlaylistRequestAll {
  String? action;
  List<Playlist>? playlistAll;

  PlaylistRequestAll({this.action, required this.playlistAll});

  PlaylistRequestAll.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    if (json['playlistAll'] != null) {
      playlistAll = <Playlist>[];
      json['playlistAll'].forEach((v) {
        playlistAll!.add(Playlist.fromJson(v));
      });
    }
  }
}

class PlaylistAll {
  List<Playlist>? playlist;
  String? playlistType;
  String? playlistName;
  String? playlistLocation;

  PlaylistAll(
      {this.playlist,
      this.playlistType,
      this.playlistName,
      this.playlistLocation});

  PlaylistAll.fromJson(Map<String, dynamic> json) {
    if (json['playlist'] != null) {
      playlist = <Playlist>[];
      json['playlist'].forEach((v) {
        playlist!.add(new Playlist.fromJson(v));
      });
    }
    playlistType = json['playlistType'];
    playlistName = json['playlistName'];
    playlistLocation = json['playlistLocation'];
  }
}

// class PlaylistCollection {
//   const PlaylistCollection({
//     required List<Playlist> thisPlaylistCollection,
//   });
// }

class Playlist {
  String? playlistName;
  String? playlistLocation;
  String? playlistType;
  //List<PlaylistFolderOrItem>? playlist;

  /// experimental
  String? playlistItemType;
  String? playlistItemName;
  String? playlistItemLocation;
  /////

  List<Playlist>? playlist;

  Playlist({
    this.playlistName,
    this.playlistLocation,
    this.playlistType,
    this.playlist,

    ///////
    this.playlistItemName,
    this.playlistItemLocation,
    this.playlistItemType,

    ///

    ///
  });

  Playlist.fromJson(Map<String, dynamic> json) {
    if (json['playlist'] != null) {
      playlist = <Playlist>[];
      json['playlist'].forEach((v) {
        playlist!.add(new Playlist.fromJson(v));
      });
    }

    playlistType = json['playlistType'];
    playlistName = json['playlistName'];
    playlistLocation = json['playlistLocation'];

/////////
    playlistItemType = json['playlistItemType'];
    playlistItemName = json['playlistItemName'];
    playlistItemLocation = json['playlistItemLocation'];
////////

    //playlist = json['playlist'];
  }
}

// class PlaylistFolderOrItem extends Equatable {
//   String? playlistItemType;
//   String? playlistItemName;
//   String? playlistItemLocation;
//   String? playlistType;
//   String? playlistName;
//   String? playlistLocation;
//   List<Playlist>? playlist;

//   PlaylistFolderOrItem(
//       this.playlistItemType,
//       this.playlistItemName,
//       this.playlistItemLocation,
//       this.playlistType,
//       this.playlistName,
//       this.playlistLocation,
//       this.playlist);

//   PlaylistFolderOrItem.fromJson(Map<String, dynamic> json) {
//     playlistType = json['playlistType'];
//     playlistName = json['playlistName'];
//     playlistLocation = json['playlistItemLocation'];
//     playlistItemType = json['playlistItemType'];
//     playlistItemName = json['playlistItemName'];
//     playlistItemLocation = json['playlistItemLocation'];
//     if (json['playlist'] != null) {
//       playlist = <Playlist>[];
//       json['playlist'].forEach((v) {
//         playlist!.add(Playlist.fromJson(v));
//       });
//     }
//   }

//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }
