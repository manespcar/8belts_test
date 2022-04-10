part of 'mars_floor_bloc.dart';

enum MarsFloorStateEnum {
  initial,
  scanningFloor,
  scanFinished,
  moved,
  finished,
  aborted,
  outOfLimits,
}

extension MarsFloorStatusX on MarsFloorStateEnum {
  bool get isInitial => this == MarsFloorStateEnum.initial;

  bool get isScanningFloor => this == MarsFloorStateEnum.scanningFloor;

  bool get isScanFinished => this == MarsFloorStateEnum.scanFinished;

  bool get isMoved => this == MarsFloorStateEnum.moved;

  bool get isFinished => this == MarsFloorStateEnum.finished;

  bool get isAborted => this == MarsFloorStateEnum.aborted;

  bool get isOutOfLimits => this == MarsFloorStateEnum.outOfLimits;
}

class MarsFloorState extends Equatable {
  MarsFloorState({
    this.status = MarsFloorStateEnum.initial,
    List<List<Tile>>? tiles,
    List<String>? instruction,
    int? indexInstruction,
    double? positionLeft,
    double? positionBottom,
    Position? currentRoverPosition,
    Position? abortedPosition,
    List<int>? logInstruction,
  })  : tiles = tiles ?? const [],
        instruction = instruction ?? const [],
        indexInstruction = indexInstruction ?? 0,
        positionLeft = positionLeft ?? 185,
        positionBottom = positionBottom ?? 38,
        currentRoverPosition =
            currentRoverPosition ?? Position(startPositionX, startPositionY),
        abortedPosition = abortedPosition ?? Position(0, 0),
        logInstruction = logInstruction ?? const [];

  final List<List<Tile>> tiles;
  final List<String> instruction;
  final int indexInstruction;
  final double positionLeft;
  final double positionBottom;
  final Position currentRoverPosition;
  final Position abortedPosition;
  final List<int> logInstruction;
  final MarsFloorStateEnum status;

  @override
  List<Object?> get props => [
        tiles,
        instruction,
        indexInstruction,
        positionLeft,
        positionBottom,
        currentRoverPosition,
        abortedPosition,
        logInstruction,
        status,
      ];

  MarsFloorState copyWith({
    List<List<Tile>>? tiles,
    List<String>? instruction,
    int? indexInstruction,
    double? positionLeft,
    double? positionBottom,
    Position? currentRoverPosition,
    Position? abortedPosition,
    List<int>? logInstruction,
    MarsFloorStateEnum? status,
  }) {
    return MarsFloorState(
      tiles: tiles ?? this.tiles,
      instruction: instruction ?? this.instruction,
      indexInstruction: indexInstruction ?? this.indexInstruction,
      positionLeft: positionLeft ?? this.positionLeft,
      positionBottom: positionBottom ?? this.positionBottom,
      currentRoverPosition: currentRoverPosition ?? this.currentRoverPosition,
      abortedPosition: abortedPosition ?? this.abortedPosition,
      logInstruction: logInstruction ?? this.logInstruction,
      status: status ?? this.status,
    );
  }
}
