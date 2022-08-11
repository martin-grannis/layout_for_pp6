// ignore_for_file: unnecessary_this

part of 'layout_bloc.dart';

@immutable
abstract class LayoutState extends Equatable {
  // ignore: recursive_getters
  get leftWindowStatus => this.leftWindowStatus;
  //get splitPoint => this.splitPoint;
  get lockedSplit => this.lockedSplit;

  get splitPoint => this.splitPoint;
}

// class LayoutInitial extends LayoutState {
//   @override
//   final int leftWindowStatus = 0;
//   @override
//   List<Object?> get props => [];
// }

class LayoutCurrent extends LayoutState {
  // 0 == tabbed focus Left
  // 1 == tabbed focus Right
  // 2 == listing
  // 3 == playlist

  @override
  final int leftWindowStatus;
  final double splitPoint;
  final bool lockedSplit;

  LayoutCurrent({
    required this.leftWindowStatus,
    required this.splitPoint,
    required this.lockedSplit,
  });

  LayoutCurrent copyWith({
    int? leftWindowStatus,
    double? splitPoint,
    bool? lockedSplit,
  }) {
    return LayoutCurrent(
      leftWindowStatus: leftWindowStatus ?? this.leftWindowStatus,
      splitPoint: splitPoint ?? this.splitPoint,
      lockedSplit: lockedSplit ?? this.lockedSplit,
    );
  }

  @override
  List<Object?> get props => [leftWindowStatus, lockedSplit];
}
