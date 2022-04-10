part of 'mars_floor_bloc.dart';

class MarsFloorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScanFloorEvent extends MarsFloorEvent {
  ScanFloorEvent(this.instruction);

  final String instruction;

  @override
  List<Object?> get props => [instruction];
}

class NextInstructionEvent extends MarsFloorEvent {
  @override
  List<Object?> get props => [];
}
