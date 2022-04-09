import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<NextStepStepper>(_mapNextStepStepperToState);
    on<BackStepStepper>(_mapBackStepStepperToState);
    on<OnStepStepper>(_mapOnStepStepperToState);
    on<OnChangeInstruction>(_mapOnChangeInstructionToState);
    on<SendInstructions>(_mapSendInstructionsToState);
  }

  void _mapNextStepStepperToState(
    NextStepStepper event,
    Emitter<HomeState> emit,
  ) {
    final newIndex = state.index + 1;
    emit(state.copyWith(index: newIndex));
  }

  void _mapBackStepStepperToState(
    BackStepStepper event,
    Emitter<HomeState> emit,
  ) {
    final newIndex = state.index - 1;
    emit(state.copyWith(index: newIndex));
  }

  void _mapOnStepStepperToState(OnStepStepper event, Emitter<HomeState> emit) {
    final newIndex = event.index;
    emit(state.copyWith(index: newIndex));
  }

  void _mapOnChangeInstructionToState(
    OnChangeInstruction event,
    Emitter<HomeState> emit,
  ) {
    final newInstruction = event.value;
    emit(state.copyWith(instruction: newInstruction));
  }

  void _mapSendInstructionsToState(
    SendInstructions event,
    Emitter<HomeState> emit,
  ) {
    final validCharacters = RegExp(r'^[lLrRfF]+$');
    if (validCharacters.hasMatch(state.instruction)) {
    } else {
      emit(state.copyWith(status: HomeStateEnum.failure));
    }
  }
}
