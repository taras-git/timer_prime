import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:timer_prime/data/api_client.dart';

part 'random_number_event.dart';
part 'random_number_state.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  late final StreamSubscription _periodicSubscription;

  RandomNumberBloc() : super(RandomNumberInitial()) {
    _periodicSubscription = Stream.periodic(
      const Duration(seconds: 2),
    ).listen(
      (_) {
        add(RandomNumberFetchEvent());
      },
    );

    on<RandomNumberFetchEvent>(_onRandomNumberEvent);
  }

  @override
  Future<void> close() {
    _periodicSubscription.cancel();
    return super.close();
  }

  Future<FutureOr<void>> _onRandomNumberEvent(
    RandomNumberFetchEvent event,
    Emitter<RandomNumberState> emit,
  ) async {
    emit(RandomNumberFetching());

    try {
      var client = DioClient();

      await client.dio.get("api/v1.0/random").then((response) {
        final int fetchedNumber = (response.data as List)[0];

        emit(RandomNumberFetched(fetchedNumber: fetchedNumber));
      }).catchError((error) {
        emit(
          RandomNumberFailure(errorMessage: error.toString()),
        );
      });
    } catch (e) {
      emit(
        RandomNumberFailure(errorMessage: e.toString()),
      );
    }
  }
}
