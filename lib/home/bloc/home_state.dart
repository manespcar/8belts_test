part of 'home_bloc.dart';

enum HomeStateEnum {
  initial,
  loading,
  success,
  failure,
}

extension HomeStatusX on HomeStateEnum {
  bool get isInitial => this == HomeStateEnum.initial;

  bool get isLoading => this == HomeStateEnum.loading;

  bool get isSuccess => this == HomeStateEnum.success;

  bool get isFailure => this == HomeStateEnum.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStateEnum.initial,
    int? index,
    String? instruction,
  })  : index = index ?? 0,
        instruction = instruction ?? '';

  final int index;
  final String instruction;
  final HomeStateEnum status;

  @override
  List<Object?> get props => [
        index,
        instruction,
        status,
      ];

  HomeState copyWith({
    int? index,
    String? instruction,
    HomeStateEnum? status,
  }) {
    return HomeState(
      index: index ?? this.index,
      instruction: instruction ?? this.instruction,
      status: status ?? this.status,
    );
  }
}
