import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_prime/bloc/random_number_bloc/random_number_bloc.dart';
import 'package:timer_prime/bloc/ticker_bloc/ticker_bloc.dart';
import 'package:timer_prime/utils.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? displayedPrimeNumber;

    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => TickerBloc()..add(TickerInitialEvent()),
          child: BlocBuilder<TickerBloc, TickerBaseState>(
            builder: (context, tickerState) {
              return BlocProvider(
                create: (context) => RandomNumberBloc(),
                child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
                  bloc: RandomNumberBloc()..add(RandomNumberFetchEvent()),
                  builder: (context, RandomNumberState rnState) {
                    if (rnState is RandomNumberInitialState) {
                      return const Text("please wait...");
                    }
                    if (rnState is RandomNumberFetchedState) {
                      final fetchedNumber = rnState.fetchedNumber;

                      if (NumberUtils.isPrime(fetchedNumber)) {
                        displayedPrimeNumber = fetchedNumber;
                        context.read<TickerBloc>().add(TickerResetEvent());

                        return ShowPrimeNumber(
                          primeNumber: displayedPrimeNumber,
                        );
                      }
                      return displayedPrimeNumber == null
                          ? const ShowTime()
                          : ShowPrimeNumber(
                              primeNumber: displayedPrimeNumber,
                            );
                    } else {
                      return displayedPrimeNumber == null
                          ? const ShowTime()
                          : ShowPrimeNumber(
                              primeNumber: displayedPrimeNumber,
                            );
                    }
                  },
                ),
              );
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
  });

  final int? primeNumber;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Congrats!'),
      Text('Prime number: $primeNumber'),
    ]);
  }
}
