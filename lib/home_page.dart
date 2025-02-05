import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_prime/bloc/random_number_bloc.dart';
import 'package:timer_prime/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
          bloc: RandomNumberBloc()..add(RandomNumberFetchEvent()),
          builder: (context, RandomNumberState state) {
            if (state is RandomNumberInitial) {
              return const Text("please wait...");
            }
            if (state is RandomNumberFetched) {
              final number = state.fetchedNumber;
              // check if prime
              // NumberUtils.isPrime(number) ?

              // start timer
              return Center(
                  child: Text(NumberUtils.isPrime(number)
                      ? 'PRIME $number'
                      : 'not PRIME $number'));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TimeUtils.formattedTime()),
                  Text(
                      '${TimeUtils.formattedDate()} kw${TimeUtils.weekNumber()}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
