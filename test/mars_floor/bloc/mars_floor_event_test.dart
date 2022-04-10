import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarsFloorEvent', () {
    test('supports comparisons', () {
      expect(MarsFloorEvent(), MarsFloorEvent());
    });
  });

  group('ScanFloorEvent', () {
    test('supports comparisons', () {
      expect(
        ScanFloorEvent('F'),
        ScanFloorEvent('F'),
      );
    });
  });

  group('NextInstructionEvent', () {
    test('supports comparisons', () {
      expect(
        NextInstructionEvent(),
        NextInstructionEvent(),
      );
    });
  });
}
