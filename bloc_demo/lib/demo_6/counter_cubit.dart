import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterCubit extends HydratedCubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['value'] as int?;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {'value': state};
  }
}
