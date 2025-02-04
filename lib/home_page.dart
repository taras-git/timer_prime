import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_prime/bloc/random_number_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
          bloc: RandomNumberBloc()..add(RandomNumberFetchEvent()),
          builder: (context, RandomNumberState state) {
            switch (state.runtimeType) {
              case const (RandomNumberInitial):
                return const Text("please wait...");
              case const (RandomNumberFetched):
                final num = (state as RandomNumberFetched).fetchedNumber;
                return Center(
                  child: Text('$num'),
                );

              default:
                return const Text("well, well, well...");
            }
          },
        ),
      ),
    );
  }
}
