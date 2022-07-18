part of 'presentation_bloc.dart';

abstract class PresentationState extends Equatable {
  final List<PresentationCacheItem> PresentationCache = [];
    int presentationSlideIndexCurrentlyOnScreen = -1;

  @override
  List<Object> get props => [];

  get currentPresentation => this.currentPresentation;
}

// int currentSong = -1;
// int maxSongs = 10;
//int currentSlideIndex = -1;

class PresentationInitialState extends PresentationState {}

class PresentationLoadingState extends PresentationState {}

class PresentationLoadedState extends PresentationState {
  final Presentation currentPresentation;
  

  PresentationLoadedState(
      {required this.currentPresentation}) {
    
  }

  @override
  List<Object> get props =>
      [currentPresentation, PresentationCache];
}

class PresentationSlideSelectedState extends PresentationState {
  PresentationSlideSelectedState(int slideRequested) {
    //currentSlideIndex = slideRequested;
  }
  List<Object> get props => [];
}
