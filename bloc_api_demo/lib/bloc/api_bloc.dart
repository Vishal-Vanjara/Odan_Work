import 'dart:async';
import '../repository/api_repository.dart';
import 'api_event.dart';
import 'api_state.dart';


class ApiBloc {
  final ApiRepository repository;


  final _stateController = StreamController<ApiState>.broadcast();
  Stream<ApiState> get state => _stateController.stream;


  final _eventController = StreamController<ApiEvent>();


  ApiBloc(this.repository) {
    _eventController.stream.listen(_mapEventToState);
  }


  void add(ApiEvent event) {
    _eventController.add(event);
  }


  Future<void> _mapEventToState(ApiEvent event) async {
    if (event is FetchDataEvent) {
      _stateController.add(ApiLoading());
      try {
        final data = await repository.fetchData();
        _stateController.add(ApiSuccess(data));
      } catch (e) {
        _stateController.add(ApiError(e.toString()));
      }
    }
  }


  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}