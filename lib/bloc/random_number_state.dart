part of 'random_number_bloc.dart';

@immutable
sealed class RandomNumberState {}

final class RandomNumberInitial extends RandomNumberState {}

final class RandomNumberFetching extends RandomNumberState {}

final class RandomNumberFetched extends RandomNumberState {
  final int fetchedNumber;

  RandomNumberFetched({
    required this.fetchedNumber,
  });
}

final class RandomNumberFailure extends RandomNumberState {
  final String errorMessage;

  RandomNumberFailure({
    required this.errorMessage,
  });
}
