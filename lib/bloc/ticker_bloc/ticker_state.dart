part of 'ticker_bloc.dart';

@immutable
sealed class TickerBaseState {}

final class TickerInitialState extends TickerBaseState {}

final class TickerContinueState extends TickerBaseState {}

final class TickerResetState extends TickerBaseState {}
