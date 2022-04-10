import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:belts_test/home/home_page.dart';
import 'package:belts_test/l10n/l10n.dart';
import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:belts_test/mars_floor/components/floor_widget.dart';
import 'package:belts_test/mars_floor/components/instructions_widget.dart';
import 'package:belts_test/mars_floor/components/rover_widget.dart';
import 'package:belts_test/mars_floor/components/scan_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarsFloorWidget extends StatelessWidget {
  const MarsFloorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MarsFloorBloc, MarsFloorState>(
      listener: (context, state) {
        if (state.status.isMoved) {
          context.read<MarsFloorBloc>().add(
                NextInstructionEvent(),
              );
        }
      },
      builder: (context, state) {
        if (state.status.isScanningFloor) {
          return const ScanWidget();
        }
        if (state.status.isInitial) {
          return Container();
        } else {
          return Column(
            children: [
              Stack(
                children: [
                  FloorWidget(tiles: state.tiles),
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    left: state.positionLeft,
                    bottom: state.positionBottom,
                    child: const RoverWidget(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          key: const Key('button'),
                          onPressed: state.status.isScanFinished
                              ? () => context
                                  .read<MarsFloorBloc>()
                                  .add(NextInstructionEvent())
                              : state.status.isAborted ||
                                      state.status.isFinished ||
                                      state.status.isOutOfLimits
                                  ? () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      )
                                  : null,
                          child: Text(
                            state.status.isAborted ||
                                    state.status.isFinished ||
                                    state.status.isOutOfLimits
                                ? context.l10n.marsFloorPageBackButton
                                : context.l10n.marsFloorPageStartButton,
                          ),
                        ),
                        for (var i = 0; i < state.instruction.length; i++) ...[
                          InstructionsWidget(
                            instruction: state.instruction[i],
                            logInstruction: state.logInstruction[i],
                          ),
                        ]
                      ],
                    ),
                    if (state.status.isAborted ||
                        state.status.isFinished ||
                        state.status.isOutOfLimits) ...[
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.status.isAborted
                              ? context.l10n.marsFloorPageAbortedText
                                  .replaceFirst(
                                  '{0}',
                                  '(${state.abortedPosition.x},'
                                      '${state.abortedPosition.y})',
                                )
                              : state.status.isOutOfLimits
                                  ? context.l10n.marsFloorPageOutOfLimitsText
                                  : context.l10n.marsFloorPageSuccessText,
                          style: BeltsTheme.themeData.textTheme.subtitle2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
