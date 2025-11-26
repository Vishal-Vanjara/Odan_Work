import 'package:bloc_demo/Toggle_on_off_app/toggle/toggle_event.dart';
import 'package:bloc_demo/Toggle_on_off_app/toggle/toggle_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleBloc extends Bloc<ToggleEvent,ToggleState>{
  ToggleBloc() : super(ToggleState(false)){
    on<TogglePressed>((event,emit){
      emit(ToggleState(!state.isOn));
    });
  }
}