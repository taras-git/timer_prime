import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_prime/bloc/random_number_bloc.dart';
import 'package:timer_prime/utils.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? displayedPrimeNumber;
    final stopwatch = Stopwatch();
    stopwatch.start();
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => RandomNumberBloc(),
          child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
            bloc: RandomNumberBloc()..add(RandomNumberFetchEvent()),
            builder: (context, RandomNumberState state) {
              if (state is RandomNumberInitialState) {
                return const Text("please wait...");
              }
              if (state is RandomNumberFetchedState) {
                final number = state.fetchedNumber;

                if (NumberUtils.isPrime(number)) {
                  displayedPrimeNumber = number;
                  stopwatch.reset();
                  return ShowPrimeNumber(
                    primeNumber: displayedPrimeNumber,
                    sw: stopwatch,
                  );
                }

                return displayedPrimeNumber == null
                    ? const ShowTime()
                    : ShowPrimeNumber(
                        primeNumber: displayedPrimeNumber,
                        sw: stopwatch,
                      );
              } else {
                return displayedPrimeNumber == null
                    ? const ShowTime()
                    : ShowPrimeNumber(
                        primeNumber: displayedPrimeNumber,
                        sw: stopwatch,
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ShowTime extends StatelessWidget {
  const ShowTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(TimeUtils.formattedTime()),
        Text('${TimeUtils.formattedDate()} kw${TimeUtils.weekNumber()}'),
      ],
    );
  }
}

class ShowPrimeNumber extends StatelessWidget {
  const ShowPrimeNumber({
    super.key,
    required this.primeNumber,
    required this.sw,
  });

  final int? primeNumber;
  final Stopwatch sw;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Congrats!'),
      Text('Prime number: $primeNumber'),
      Text('Seconds: ${sw.elapsedMilliseconds / 1000}'),
    ]);
  }
}
