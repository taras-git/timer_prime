import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:timer_prime/data/api_provider.dart';

part 'random_number_event.dart';
part 'random_number_state.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  late final StreamSubscription _randomNumberPeriodicSubscription;

  final ApiProvider apiRepository = ApiProvider();

  RandomNumberBloc() : super(RandomNumberInitialState()) {
    _randomNumberPeriodicSubscription = Stream.periodic(
      const Duration(seconds: 4),
    ).listen(
      (_) {
        add(RandomNumberFetchEvent());
      },
    );

    on<RandomNumberFetchEvent>(_onRandomNumberEvent);
  }

  @override
  Future<void> close() {
    _randomNumberPeriodicSubscription.cancel();
    return super.close();
  }

  Future<FutureOr<void>> _onRandomNumberEvent(
    RandomNumberFetchEvent event,
    Emitter<RandomNumberState> emit,
  ) async {
    emit(RandomNumberFetchingState());

    final fetchedNumber = await apiRepository.fetchRandomNumber();

    fetchedNumber != null
        ? emit(RandomNumberFetchedState(
            fetchedNumber: fetchedNumber.randomNumber!))
        : emit(RandomNumberFailureState(
            errorMessage: fetchedNumber!.errorMessage!));
  }
}
