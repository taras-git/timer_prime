import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerBaseEvent, TickerBaseState> {
  late final StreamSubscription _tickerPeriodicSubscription;

  TickerBloc() : super(TickerInitialState()) {
    _tickerPeriodicSubscription = Stream.periodic(
      const Duration(seconds: 1),
    ).listen(
      (_) {
        add(TickerUpdateEvent());
      },
    );
    on<TickerInitialEvent>(_onTickerInitialEvent);
    on<TickerUpdateEvent>(_onTickerEvent);
    on<TickerResetEvent>(_onTickerResetEvent);
  }

  @override
  Future<void> close() {
    _tickerPeriodicSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onTickerEvent(
    TickerUpdateEvent event,
    Emitter<TickerBaseState> emit,
  ) {
    print('>>>>>>>>> 2 TickerEvent ');

    emit(TickerContinueState());
  }

  FutureOr<void> _onTickerInitialEvent(
    TickerInitialEvent event,
    Emitter<TickerBaseState> emit,
  ) {
    print('>>>>>>>>> 1 TickerInitialEvent ');
  }

  FutureOr<void> _onTickerResetEvent(
      TickerResetEvent event, Emitter<TickerBaseState> emit) {
    print('>>>>>>>>> 3 TickerResetEvent ');
    emit(TickerResetState());
  }
}
