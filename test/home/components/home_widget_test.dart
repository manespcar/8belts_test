import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:belts_test/home/components/home_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeState extends Fake implements HomeState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

void main() {
  late MockHomeBloc _mock;

  setUp(() {
    _mock = MockHomeBloc();
  });

  setUpAll(() {
    registerFallbackValue(FakeHomeEvent());
    registerFallbackValue(FakeHomeState());
  });

  group('HomeWidget', () {
    testWidgets('renders HomeWidget', (tester) async {
      when(() => _mock.state).thenReturn(const HomeState());
      await tester.pumpApp(
        BlocProvider<HomeBloc>(
          create: (_) => _mock,
          child: const HomeWidget(),
        ),
      );
      expect(find.byType(HomeWidget), findsOneWidget);
    });
  });
}
