import 'dart:async';
import 'dart:math';

import 'package:belts_test/constants/constants.dart';
import 'package:belts_test/mars_floor/model/position.dart';
import 'package:belts_test/mars_floor/model/tile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mars_floor_event.dart';
part 'mars_floor_state.dart';

class MarsFloorBloc extends Bloc<MarsFloorEvent, MarsFloorState> {
  MarsFloorBloc() : super(MarsFloorState()) {
    on<ScanFloorEvent>(_mapScanFloorEventToState);
    on<NextInstructionEvent>(_mapNextInstructionEventToState);
  }

  Future<void> _mapScanFloorEventToState(
    ScanFloorEvent event,
    Emitter<MarsFloorState> emit,
  ) async {
    emit(state.copyWith(status: MarsFloorStateEnum.scanningFloor));

    await Future<dynamic>.delayed(const Duration(seconds: 3));

    final stonesPosition = _getRandomStonesPosition();
    final tiles = List.generate(
      maxRows,
      (i) => List.generate(
        maxColumns,
        (j) => Tile(
          position: Position(i, j),
          isEmpty: _checkIfExistStone(stonesPosition, i, j),
        ),
      ),
    );

    emit(
      state.copyWith(
        status: MarsFloorStateEnum.scanFinished,
        tiles: tiles,
        instruction: event.instruction.toUpperCase().split(''),
        logInstruction: List.filled(event.instruction.length, -1),
      ),
    );
  }

  Future<void> _mapNextInstructionEventToState(
    NextInstructionEvent event,
    Emitter<MarsFloorState> emit,
  ) async {
    if (state.indexInstruction == state.instruction.length) {
      emit(state.copyWith(status: MarsFloorStateEnum.finished));
    } else {
      final currentInstruction = state.instruction[state.indexInstruction];
      final nextPosition = _getNextPosition(
        currentInstruction,
        state.currentRoverPosition,
      );

      await Future<dynamic>.delayed(const Duration(seconds: 1));

      if (_outOfLimits(nextPosition)) {
        state.logInstruction[state.indexInstruction] = 0;
        emit(
          state.copyWith(
            status: MarsFloorStateEnum.outOfLimits,
          ),
        );
      } else if (!_canMove(nextPosition, state.tiles)) {
        final backInstruction = state.instruction[
            state.indexInstruction > 0 ? state.indexInstruction - 1 : 0];
        state.logInstruction[state.indexInstruction] = 0;
        emit(
          state.copyWith(
            status: MarsFloorStateEnum.aborted,
            abortedPosition: nextPosition,
            positionBottom: backInstruction == forward
                ? state.positionBottom - offsetY
                : state.positionBottom,
            positionLeft: backInstruction == left
                ? state.positionLeft + offsetX
                : backInstruction == right
                    ? state.positionLeft - offsetX
                    : state.positionLeft,
          ),
        );
      } else {
        state.logInstruction[state.indexInstruction] = 1;
        emit(
          state.copyWith(
            status: MarsFloorStateEnum.moved,
            currentRoverPosition: nextPosition,
            indexInstruction: state.indexInstruction + 1,
            positionBottom: currentInstruction == forward
                ? state.positionBottom + offsetY
                : state.positionBottom,
            positionLeft: currentInstruction == left
                ? state.positionLeft - offsetX
                : currentInstruction == right
                    ? state.positionLeft + offsetX
                    : state.positionLeft,
          ),
        );
      }
    }
  }

  List<Position> _getRandomStonesPosition() {
    final random = Random();
    return List.generate(
      maxStones,
      (index) {
        int x, y = -1;
        do {
          x = random.nextInt(maxRows);
          y = random.nextInt(maxColumns);
        } while (x == startPositionX && y == startPositionY);
        return Position(x, y);
      },
      growable: false,
    );
  }

  bool _checkIfExistStone(
    final List<Position> stonesPosition,
    final int i,
    final int j,
  ) {
    return stonesPosition
        .where((stone) => stone.x == i && stone.y == j)
        .isEmpty;
  }

  Position _getNextPosition(
    String currentInstruction,
    Position currentRoverPosition,
  ) {
    if (currentInstruction == forward) {
      return Position(currentRoverPosition.x - 1, currentRoverPosition.y);
    } else if (currentInstruction == left) {
      return Position(currentRoverPosition.x, currentRoverPosition.y - 1);
    } else {
      return Position(currentRoverPosition.x, currentRoverPosition.y + 1);
    }
  }

  bool _canMove(
    Position nextPosition,
    List<List<Tile>> tiles,
  ) {
    return tiles[nextPosition.x][nextPosition.y].isEmpty;
  }

  bool _outOfLimits(Position nextPosition) {
    return nextPosition.x < 0 || nextPosition.y > 8 || nextPosition.y < 0;
  }
}
