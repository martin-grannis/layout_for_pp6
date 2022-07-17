// ignore_for_file: unnecessary_this

part of 'layout_bloc.dart';

@immutable
abstract class LayoutState extends Equatable {
  // ignore: recursive_getters
  get leftWindowStatus => this.leftWindowStatus;

  LayoutCurrent copyWith({
    int? leftWindowStatus,
  }) {
    return LayoutCurrent(
      leftWindowStatus: leftWindowStatus ?? this.leftWindowStatus,
    );
  }
}

class LayoutInitial extends LayoutState {
  @override
  final int leftWindowStatus = 0;
  @override
  List<Object?> get props => [];
}

class LayoutCurrent extends LayoutState {
  // 0 == tabbed focus Left
  // 1 == tabbed focus Right
  // 2 == listing
  // 3 == playlist

  @override
  final int leftWindowStatus;
  LayoutCurrent({
    required this.leftWindowStatus,
  });
  @override
  List<Object?> get props => [leftWindowStatus];
}
