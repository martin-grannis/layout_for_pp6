part of 'presentation_bloc.dart';

abstract class PresentationEvent extends Equatable {
  const PresentationEvent();

  @override
  List<Object> get props => [];
}

class PresentationEventLoadSong extends PresentationEvent {
  final String this_presentation;
  final List<Presentation>? nextTwoSongs;
  final bool RequestFromLibrary;

  PresentationEventLoadSong(
      this.this_presentation, this.nextTwoSongs, this.RequestFromLibrary);
}

class PresentationEventShowSong extends PresentationEvent {
  final String this_presentation_name;
  final int this_index;

  PresentationEventShowSong(this.this_presentation_name, this.this_index);
}
