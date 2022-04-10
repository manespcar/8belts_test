import 'package:belts_test/mars_floor/bloc/mars_floor_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MarsFloorStatusX ', () {
    test('returns correct values for MarsFloorStateEnum.initial', () {
      const status = MarsFloorStateEnum.initial;
      expect(status.isInitial, isTrue);
      expect(status.isScanningFloor, isFalse);
      expect(status.isScanFinished, isFalse);
      expect(status.isMoved, isFalse);
      expect(status.isFinished, isFalse);
      expect(status.isAborted, isFalse);
    });

    test('returns correct values for MarsFloorStateEnum.isScanningFloor', () {
      const status = MarsFloorStateEnum.scanningFloor;
      expect(status.isInitial, isFalse);
      expect(status.isScanningFloor, isTrue);
      expect(status.isScanFinished, isFalse);
      expect(status.isMoved, isFalse);
      expect(status.isFinished, isFalse);
      expect(status.isAborted, isFalse);
    });

    test('returns correct values for MarsFloorStateEnum.isScanFinished', () {
      const status = MarsFloorStateEnum.scanFinished;
      expect(status.isInitial, isFalse);
      expect(status.isScanningFloor, isFalse);
      expect(status.isScanFinished, isTrue);
      expect(status.isMoved, isFalse);
      expect(status.isFinished, isFalse);
      expect(status.isAborted, isFalse);
    });

    test('returns correct values for MarsFloorStateEnum.isMoved', () {
      const status = MarsFloorStateEnum.moved;
      expect(status.isInitial, isFalse);
      expect(status.isScanningFloor, isFalse);
      expect(status.isScanFinished, isFalse);
      expect(status.isMoved, isTrue);
      expect(status.isFinished, isFalse);
      expect(status.isAborted, isFalse);
    });

    test('returns correct values for MarsFloorStateEnum.isFinished', () {
      const status = MarsFloorStateEnum.finished;
      expect(status.isInitial, isFalse);
      expect(status.isScanningFloor, isFalse);
      expect(status.isScanFinished, isFalse);
      expect(status.isMoved, isFalse);
      expect(status.isFinished, isTrue);
      expect(status.isAborted, isFalse);
    });

    test('returns correct values for MarsFloorStateEnum.isAborted', () {
      const status = MarsFloorStateEnum.aborted;
      expect(status.isInitial, isFalse);
      expect(status.isScanningFloor, isFalse);
      expect(status.isScanFinished, isFalse);
      expect(status.isMoved, isFalse);
      expect(status.isFinished, isFalse);
      expect(status.isAborted, isTrue);
    });

    test('compare status', () {
      expect(
        MarsFloorState().status,
        MarsFloorState().copyWith().status,
      );
    });
  });
}
