import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent', () {
    test('supports comparisons', () {
      expect(HomeEvent(), HomeEvent());
    });
  });

  group('NextStepStepper', () {
    test('supports comparisons', () {
      expect(
        NextStepStepper(),
        NextStepStepper(),
      );
    });
  });

  group('BackStepStepper', () {
    test('supports comparisons', () {
      expect(
        BackStepStepper(),
        BackStepStepper(),
      );
    });
  });

  group('OnStepStepper', () {
    test('supports comparisons', () {
      expect(
        OnStepStepper(1),
        OnStepStepper(1),
      );
    });
  });

  group('OnChangeInstruction', () {
    test('supports comparisons', () {
      expect(
        OnChangeInstruction('FF'),
        OnChangeInstruction('FF'),
      );
    });
  });

  group('SendInstructions', () {
    test('supports comparisons', () {
      expect(
        SendInstructions(),
        SendInstructions(),
      );
    });
  });
}
