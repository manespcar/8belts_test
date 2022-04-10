import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:belts_test/mars_floor/mars_floor_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/helpers.dart';

class MockMarsFloorBloc extends MockBloc<MarsFloorEvent, MarsFloorState>
    implements MarsFloorBloc {}

class FakeMarsFloorState extends Fake implements MarsFloorState {}

class FakeMarsFloorEvent extends Fake implements MarsFloorEvent {}

void main() {
  group('MarsFloorPage', () {
    testWidgets('renders MarsFloorPage', (tester) async {
      await tester.pumpApp(
        const MarsFloorPage(
          instruction: 'FFFRLRLR',
        ),
      );
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(MarsFloorPage), findsOneWidget);
    });
  });
}
