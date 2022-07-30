part of 'layout_bloc.dart';

@immutable
abstract class LayoutEvent extends Equatable {
  @override
  List<Object?> get props => [];

}

class LayoutEventChangeLayout extends LayoutEvent {
  
  // 0 == tabbed focus Left
  // 1 == tabbed focus Right
  // 2 == listing
  // 3 == playlist
  final int newLayout;

  LayoutEventChangeLayout({
    required this.newLayout,
  });
  @override
  List<Object?> get props => [newLayout];
}


class ListenPlaylistListing extends LayoutEvent {

}

