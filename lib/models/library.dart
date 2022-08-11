
import 'package:pp6_layout/models/presentation.dart';

class LibraryRequest {
  String? action;
  List<String>? library;

  LibraryRequest({this.action, this.library});

  LibraryRequest.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    library = json['library'].cast<String>();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['action'] = this.action;
  //   data['library'] = this.library;
  //   return data;
  // }
}

class Library {
  List<LibraryItems> lib;
  Library({required this.lib});

  @override
  String toString() => 'LBloc length ${this.lib.length}';

  Library copyWithForCacheUpdate({required library, CacheUpdate? cu}) {
    //Library l = Library(lib: []);
    
    final List<LibraryItems> newLib = List<LibraryItems>.from(library.lib);

    int tmp = -1;
    try {
      // print(this.library.length);
      tmp = newLib.indexWhere((e) => e.itemName == cu!.presentation_name);
    } catch (e) {
      print(e.toString());
    }
    if (tmp != -1) {
      newLib[tmp].inCache = cu!.added;


    }

    print(library.lib == newLib);
    return Library(lib: newLib);
  }


}

class LibraryItems {
  String? itemName;
  bool inCache = false;

  LibraryItems({this.itemName, bool? inCache});

  factory LibraryItems.fromJson(Map<String, List> json) {
    //var library = json['library'].cast<List>();
    var library = json['library'] as LibraryItems;
    return library;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['library'] = this.itemName;
  //   data['inCache'] = false;
  //   return data;
  // }

  @override
  String toString() {
    var tStr = 'LBloc libItems';
    if (this.itemName!.trim().startsWith('A')) {
      tStr = '$tStr ${this.itemName} ${this.inCache}\n';
      return tStr;
    }
    return '';
  }

}
