import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:timer_prime/data/api_client.dart';

part 'random_number_event.dart';
part 'random_number_state.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  RandomNumberBloc() : super(RandomNumberInitial()) {
    on<RandomNumberFetchEvent>(_onRandomNumberEvent);
  }

  Future<FutureOr<void>> _onRandomNumberEvent(
    RandomNumberFetchEvent event,
    Emitter<RandomNumberState> emit,
  ) async {
    emit(RandomNumberFetching());

    try {
      var client = DioClient();

      await client.dio.get("api/v1.0/random").then((response) {
        var fetchedNumber = (response.data as List)[0];
        emit(RandomNumberFetched(fetchedNumber: fetchedNumber));
      }).catchError((error) {
        emit(RandomNumberFailure(errorMessage: error.toString()));
      });
    } catch (e) {
      emit(RandomNumberFailure(errorMessage: e.toString()));
    }
  }
}
