import 'package:bloc_demo/demo_3/bloc/user_event.dart';
import 'package:bloc_demo/demo_3/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final ApiServices api;

  UserBloc(this.api) : super(UserInitial()){
    on<FetchUsersEvent>((event,emit) async {
      emit(UserLoading());
      try{
        final users = await api.fetchUsers();
        emit(UserLoaded(users));
      }catch(e){
        emit(UserError(e.toString()));
      }
    });
  }
}