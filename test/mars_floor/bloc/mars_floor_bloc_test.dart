import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:belts_test/mars_floor/model/position.dart';
import 'package:belts_test/mars_floor/model/tile.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarsFloorBloc', () {
    setUp(() {});

    test('initial state of the bloc is [MarsFloorStateEnum.initial]', () {
      expect(MarsFloorBloc().state.status, MarsFloorState().copyWith().status);
    });

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.scanFinished] when calls ScanFloorEvent',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(ScanFloorEvent('FRFRLL')),
      skip: 1,
      wait: const Duration(seconds: 3),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.scanFinished);
        expect(bloc.state.instruction, 'FRFRLL'.split(''));
        expect(bloc.state.tiles.isNotEmpty, true);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.finished] when calls NextInstructionEvent and '
      'there are not more instructions',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      seed: () => MarsFloorState().copyWith(
        instruction: 'FRFRLL'.split(''),
        indexInstruction: 6,
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.finished);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.outOfLimits] when calls NextInstructionEvent '
      'and the rover goes out of limits',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'FFFFFFFFF'.split(''),
        indexInstruction: 8,
        logInstruction: [1, 1, 1, 1, 1, 1, 1, 1, -1],
        currentRoverPosition: Position(0, 4),
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.outOfLimits);
        expect(bloc.state.logInstruction[8], 0);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.aborted] when calls NextInstructionEvent '
      'and the rover can not move to left',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'LFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(0, 1),
        tiles: [
          [Tile(position: Position(0, 0), isEmpty: false)]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.aborted);
        expect(bloc.state.abortedPosition.x, 0);
        expect(bloc.state.abortedPosition.y, 0);
        expect(bloc.state.logInstruction[0], 0);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.aborted] when calls NextInstructionEvent '
      'and the rover can not move to right',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'RFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(0, 1),
        tiles: [
          [
            Tile(position: Position(0, 0), isEmpty: true),
            Tile(position: Position(0, 1), isEmpty: true),
            Tile(position: Position(0, 2), isEmpty: false),
          ]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.aborted);
        expect(bloc.state.abortedPosition.x, 0);
        expect(bloc.state.abortedPosition.y, 2);
        expect(bloc.state.logInstruction[0], 0);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.aborted] when calls NextInstructionEvent '
      'and the rover can not move to forward',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'FFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(1, 0),
        tiles: [
          [
            Tile(position: Position(0, 0), isEmpty: false),
          ]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.aborted);
        expect(bloc.state.abortedPosition.x, 0);
        expect(bloc.state.abortedPosition.y, 0);
        expect(bloc.state.logInstruction[0], 0);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.moved] when calls NextInstructionEvent '
      'and the rover can move to left',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'LFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(0, 1),
        tiles: [
          [Tile(position: Position(0, 0), isEmpty: true)]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.moved);
        expect(bloc.state.logInstruction[0], 1);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.aborted] when calls NextInstructionEvent '
      'and the rover can move to right',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'RFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(0, 1),
        tiles: [
          [
            Tile(position: Position(0, 0), isEmpty: true),
            Tile(position: Position(0, 1), isEmpty: false),
            Tile(position: Position(0, 2), isEmpty: true),
          ]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.moved);
        expect(bloc.state.logInstruction[0], 1);
      },
    );

    blocTest<MarsFloorBloc, MarsFloorState>(
      'emits[MarsFloorStateEnum.aborted] when calls NextInstructionEvent '
      'and the rover can move to forward',
      build: MarsFloorBloc.new,
      act: (bloc) => bloc.add(NextInstructionEvent()),
      wait: const Duration(seconds: 1),
      seed: () => MarsFloorState().copyWith(
        instruction: 'FFFFFFFFF'.split(''),
        indexInstruction: 0,
        logInstruction: List.filled(9, -1),
        currentRoverPosition: Position(1, 0),
        tiles: [
          [
            Tile(position: Position(0, 0), isEmpty: true),
          ]
        ],
      ),
      verify: (bloc) {
        expect(bloc.state.status, MarsFloorStateEnum.moved);
        expect(bloc.state.logInstruction[0], 1);
      },
    );
  });
}
