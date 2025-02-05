part of 'random_number_bloc.dart';

@immutable
sealed class RandomNumberEvent {}

final class RandomNumberFetchEvent extends RandomNumberEvent {}
