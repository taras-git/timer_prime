part of 'random_number_bloc.dart';

@immutable
sealed class RandomNumberState {}

final class RandomNumberInitialState extends RandomNumberState {}

final class RandomNumberFetchingState extends RandomNumberState {}

final class RandomNumberFetchedState extends RandomNumberState {
  final int fetchedNumber;

  RandomNumberFetchedState({
    required this.fetchedNumber,
  });
}

final class RandomNumberFailureState extends RandomNumberState {
  final String errorMessage;

  RandomNumberFailureState({
    required this.errorMessage,
  });
}
