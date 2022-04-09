import 'package:belts_test/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeStatusX ', () {
    test('returns correct values for HomeStateEnum.initial', () {
      const status = HomeStateEnum.initial;
      expect(status.isInitial, isTrue);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for HomeStateEnum.isLoading', () {
      const status = HomeStateEnum.loading;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isTrue);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for HomeStateEnum.isSuccess', () {
      const status = HomeStateEnum.success;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isTrue);
      expect(status.isFailure, isFalse);
    });

    test('returns correct values for HomeStateEnum.isFailure', () {
      const status = HomeStateEnum.failure;
      expect(status.isInitial, isFalse);
      expect(status.isLoading, isFalse);
      expect(status.isSuccess, isFalse);
      expect(status.isFailure, isTrue);
    });

    test('compare status', () {
      expect(
        const HomeState(),
        const HomeState().copyWith(),
      );
    });
  });
}
