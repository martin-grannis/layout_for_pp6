import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(LayoutInitial()) {
    // on change layout
    
    on<LayoutEventChangeLayout>((event, emit) {
      emit(state.copyWith(leftWindowStatus: event.newLayout));
      
    });
  }
@override
void onTransition(Transition<LayoutEvent, LayoutState> transition) {
    
    super.onTransition(transition);
    debugPrint("${transition.currentState}\n${transition.nextState}\n\n");
  }  
}
