import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:belts_test/mars_floor/components/mars_floor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarsFloorPage extends StatelessWidget {
  const MarsFloorPage({Key? key, required this.instruction}) : super(key: key);

  final String instruction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MarsFloorBloc>(
      lazy: false,
      create: (context) => MarsFloorBloc()
        ..add(
          ScanFloorEvent(instruction),
        ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Text(
                    context.l10n.homePageTitle,
                    style: BeltsTheme.themeData.textTheme.headline1,
                  ),
                ),
                const SizedBox(height: 30),
                const MarsFloorWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
