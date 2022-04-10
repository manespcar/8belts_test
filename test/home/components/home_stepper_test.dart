import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:belts_test/home/components/home_stepper.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeState extends Fake implements HomeState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockHomeBloc _mock;
  late GoRouter _mockRoute;

  setUp(() {
    _mock = MockHomeBloc();
    _mockRoute = MockGoRouter();
  });

  setUpAll(() {
    registerFallbackValue(FakeHomeEvent());
    registerFallbackValue(FakeHomeState());
  });

  group('HomeStepper', () {
    testWidgets('renders HomeStepper', (tester) async {
      when(() => _mock.state).thenReturn(const HomeState());
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );
      expect(find.byType(HomeStepper), findsOneWidget);
    });

    testWidgets('should jump step when the user clicks on next step',
        (tester) async {
      when(() => _mock.state).thenReturn(const HomeState());
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.tap(find.byKey(const Key('nextStep')).first);
      await tester.pump();
      verify(
        () => _mock.add(
          NextStepStepper(),
        ),
      ).called(1);
    });

    testWidgets('should return step when the user clicks on back step',
        (tester) async {
      when(() => _mock.state).thenReturn(const HomeState().copyWith(index: 4));
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.tap(find.byKey(const Key('backStep')).last);
      await tester.pump();
      verify(
        () => _mock.add(
          BackStepStepper(),
        ),
      ).called(1);
    });

    testWidgets('should go to specific test when the user clicks on it',
        (tester) async {
      when(() => _mock.state).thenReturn(const HomeState());
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.tap(find.text('Step 2').first);
      await tester.pump();
      verify(
        () => _mock.add(
          OnStepStepper(1),
        ),
      ).called(1);
    });

    testWidgets('should change instruction when the user adds a new character',
        (tester) async {
      const instruction = 'FRLLF';
      when(() => _mock.state).thenReturn(const HomeState().copyWith(index: 4));
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('input_instructions')).first,
        instruction,
      );
      await tester.pump();
      verify(
        () => _mock.add(
          OnChangeInstruction(instruction),
        ),
      ).called(1);
    });

    testWidgets('should send instruction when the user clicks on the button',
        (tester) async {
      when(() => _mock.state).thenReturn(
        const HomeState().copyWith(
          index: 4,
          instruction: 'FRLLF',
        ),
      );
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.tap(find.byKey(const Key('send_button')));
      await tester.pump();
      verify(
        () => _mock.add(
          SendInstructions(),
        ),
      ).called(1);
    });

    testWidgets('should shows an error when the instruction is no valid',
        (tester) async {
      when(() => _mock.state).thenReturn(
        const HomeState().copyWith(
          index: 4,
          instruction: 'FRLLFEW',
        ),
      );
      whenListen(
        _mock,
        Stream<HomeState>.fromIterable(
          [
            const HomeState().copyWith(
              status: HomeStateEnum.failure,
            ),
          ],
        ),
      );

      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeStepper(),
        ),
      );

      await tester.tap(find.byKey(const Key('send_button')));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('The instruction is not valid'), findsOneWidget);
    });

    testWidgets('should navigate to other page when the instruction is valid',
        (tester) async {
      when(() => _mock.state).thenReturn(
        const HomeState().copyWith(
          index: 4,
          instruction: 'FRLLFR',
        ),
      );
      whenListen(
        _mock,
        Stream<HomeState>.fromIterable(
          [
            const HomeState().copyWith(
              status: HomeStateEnum.success,
              instruction: 'FRLLFR',
            ),
          ],
        ),
      );

      await tester.pumpApp(
        InheritedGoRouter(
          goRouter: _mockRoute,
          child: BlocProvider<HomeBloc>(
            create: (_) => _mock,
            child: const HomeStepper(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      verify(() => _mockRoute.go('/mars_floor/FRLLFR')).called(1);
    });
  });
}
