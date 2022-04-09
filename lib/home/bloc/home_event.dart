part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NextStepStepper extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class BackStepStepper extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class OnStepStepper extends HomeEvent {
  OnStepStepper(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class OnChangeInstruction extends HomeEvent {
  OnChangeInstruction(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

class SendInstructions extends HomeEvent {
  @override
  List<Object?> get props => [];
}
