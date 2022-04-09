import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:belts_test/home/components/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: const Scaffold(
        body: HomeWidget(),
      ),
    );
  }
}
