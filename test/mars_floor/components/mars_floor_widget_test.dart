import 'package:belts_test/constants/constants.dart';
import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:belts_test/mars_floor/components/mars_floor_widget.dart';
import 'package:belts_test/mars_floor/model/position.dart';
import 'package:belts_test/mars_floor/model/tile.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockMarsFloorBloc extends MockBloc<MarsFloorEvent, MarsFloorState>
    implements MarsFloorBloc {}

class FakeMarsFloorState extends Fake implements MarsFloorState {}

class FakeMarsFloorEvent extends Fake implements MarsFloorEvent {}

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late MockMarsFloorBloc _mock;
  late GoRouter _mockRoute;

  setUp(() {
    _mock = MockMarsFloorBloc();
    _mockRoute = MockGoRouter();
  });

  setUpAll(() {
    registerFallbackValue(FakeMarsFloorEvent());
    registerFallbackValue(FakeMarsFloorState());
  });

  group('MarsFloorWidget', () {
    testWidgets('renders MarsFloorWidget', (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.initial,
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      expect(find.byType(MarsFloorWidget), findsOneWidget);
    });

    testWidgets('renders MarsFloorWidget when status is scanningFloor',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.scanningFloor,
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
          );

          expect(find.byType(MarsFloorWidget), findsOneWidget);
        });

    testWidgets('renders MarsFloorWidget when status is scanFinished',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.scanFinished,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      expect(find.byType(MarsFloorWidget), findsOneWidget);
    });

    testWidgets('renders MarsFloorWidget when status is outOfLimits',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.outOfLimits,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      expect(find.byType(MarsFloorWidget), findsOneWidget);
    });

    testWidgets('renders MarsFloorWidget when status is aborted',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.aborted,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          abortedPosition: Position(8, 8),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      expect(find.byType(MarsFloorWidget), findsOneWidget);
    });

    testWidgets('renders MarsFloorWidget when status is finished',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.finished,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      expect(find.byType(MarsFloorWidget), findsOneWidget);
    });

    testWidgets('should call to start process when clicks on start button',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.scanFinished,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      await tester.tap(find.byKey(const Key('button')));
      await tester.pump();
      verify(
        () => _mock.add(
          NextInstructionEvent(),
        ),
      ).called(1);
    });

    testWidgets('should call to next instruction when the rover is moving',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.scanFinished,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      whenListen(
        _mock,
        Stream<MarsFloorState>.fromIterable(
          [
            MarsFloorState().copyWith(
              status: MarsFloorStateEnum.moved,
            ),
          ],
        ),
      );

      await tester.pumpApp(
        BlocProvider<MarsFloorBloc>(
          create: (_) => _mock,
          child: const MarsFloorWidget(),
        ),
      );

      verify(
        () => _mock.add(
          NextInstructionEvent(),
        ),
      ).called(1);
    });

    testWidgets('should clicks on back when the rover finish all instructions',
        (tester) async {
      when(() => _mock.state).thenReturn(
        MarsFloorState().copyWith(
          status: MarsFloorStateEnum.finished,
          instruction: 'FFFRF'.split(''),
          currentRoverPosition: Position(startPositionX, startPositionY),
          indexInstruction: 0,
          logInstruction: List.filled(5, -1),
          tiles: List.generate(
            maxRows,
            (i) => List.generate(
              maxColumns,
              (j) => Tile(
                position: Position(i, j),
                isEmpty: true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpApp(
        InheritedGoRouter(
          goRouter: _mockRoute,
          child: BlocProvider<MarsFloorBloc>(
            create: (_) => _mock,
            child: const MarsFloorWidget(),
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('button')));
      await tester.pumpAndSettle();
      verify(() => _mockRoute.go('/')).called(1);
    });
  });
}
