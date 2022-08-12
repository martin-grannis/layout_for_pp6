part of 'cache_bloc_bloc.dart';

abstract class CacheBlocState extends Equatable {
  const CacheBlocState();

  @override
  List<Object> get props => [];
}

//class CacheBlocInitial extends CacheBlocState {}

class CacheBloc extends CacheBlocState {
  final String currentSong;
  final List<String> itemNames;
  const CacheBloc({
    required this.currentSong,
    required this.itemNames,
  });

  CacheBloc copyWith({
    String? currentSong,
    List<String>? itemNames,
  }) {
    return CacheBloc(
      currentSong: currentSong ?? this.currentSong,
      itemNames: itemNames ?? this.itemNames,
    );
  }

  bool inCache(String str) {
    var tmp = this.itemNames.indexWhere((element) => element == str);
    return tmp != -1; // -1 means not there
  }

  String getCurrentSong() {
    return currentSong;
  }
}
