import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    setUp(() {});

    test('initial state of the bloc is [HomeStateEnum.initial]', () {
      expect(HomeBloc().state, const HomeState().copyWith());
    });

    blocTest<HomeBloc, HomeState>(
      'should increment index when NextStepStepper is called',
      build: HomeBloc.new,
      act: (bloc) => bloc.add(NextStepStepper()),
      expect: () => [const HomeState(index: 1)],
    );

    blocTest<HomeBloc, HomeState>(
      'should decrement index when BackStepStepper is called',
      build: HomeBloc.new,
      seed: () => const HomeState().copyWith(index: 2),
      act: (bloc) => bloc.add(BackStepStepper()),
      expect: () => [const HomeState(index: 1)],
    );

    blocTest<HomeBloc, HomeState>(
      'should go to the index passed by parameter when OnStepStepper is called',
      build: HomeBloc.new,
      act: (bloc) => bloc.add(OnStepStepper(3)),
      expect: () => [const HomeState(index: 3)],
    );

    blocTest<HomeBloc, HomeState>(
      'should change instruction when OnChangeInstruction is called',
      build: HomeBloc.new,
      act: (bloc) => bloc.add(OnChangeInstruction('FRLF')),
      expect: () => [const HomeState(instruction: 'FRLF')],
    );

    blocTest<HomeBloc, HomeState>(
      'should emits failure if the instruction is not valid',
      build: HomeBloc.new,
      seed: () => const HomeState().copyWith(instruction: 'FLRHE'),
      act: (bloc) => bloc.add(SendInstructions()),
      expect: () => [
        const HomeState(
          instruction: 'FLRHE',
          status: HomeStateEnum.failure,
        )
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should emits success if the instruction is valid',
      build: HomeBloc.new,
      seed: () => const HomeState().copyWith(instruction: 'FLRFFL'),
      act: (bloc) => bloc.add(SendInstructions()),
      expect: () => [
        const HomeState(
          instruction: 'FLRFFL',
          status: HomeStateEnum.success,
        )
      ],
    );
  });
}
