part of 'ticker_bloc.dart';

@immutable
sealed class TickerBaseEvent {}

final class TickerInitialEvent extends TickerBaseEvent {}

final class TickerUpdateEvent extends TickerBaseEvent {}

final class TickerResetEvent extends TickerBaseEvent {}
