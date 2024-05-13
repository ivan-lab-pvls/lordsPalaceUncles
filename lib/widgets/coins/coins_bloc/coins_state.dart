part of 'coins_bloc.dart';

@immutable
sealed class CoinsState {}

final class CoinsInitial extends CoinsState {}

final class UpdateCoinsState extends CoinsState {
  final int coins;

  UpdateCoinsState({required this.coins});
}

