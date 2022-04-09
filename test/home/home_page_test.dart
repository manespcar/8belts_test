import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:belts_test/home/home_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeState extends Fake implements HomeState {}

class FakeHomeEvent extends Fake implements HomeEvent {}

void main() {
  group('HomePage', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(const HomePage());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
